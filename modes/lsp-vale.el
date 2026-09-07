;;; lsp-vale.el --- LSP client for the Vale prose linter -*- lexical-binding: t; -*-

;; Copyright (C) 2026 lsp-vale contributors

;; Author: rjspotter
;; URL: https://github.com/rjspotter/lsp-vale
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.1") (lsp-mode "8.0.0"))
;; Keywords: convenience lsp vale prose

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; LSP client for vale-ls, the Language Server for the Vale prose linter.
;;
;; Vale enforces writing-style rules via configurable rule sets ("styles")
;; and reads a .vale.ini configuration file.  vale-ls wraps the Vale CLI
;; and exposes its linting as a standard LSP server.
;;
;; See https://docs.vale.sh/guides/lsp for server documentation.
;;
;; Quick start:
;;
;;   (require 'lsp-vale)
;;
;; Then open any prose file and run M-x lsp.  Vale-ls runs alongside any
;; other active language server for the same buffer.

;;; Code:

(require 'lsp-mode)

;;; Customization

(defgroup lsp-vale nil
  "Settings for the Vale Language Server (vale-ls)."
  :group 'lsp-mode
  :link '(url-link "https://vale.sh")
  :link '(url-link "https://github.com/vale-cli/vale-ls"))

(defcustom lsp-vale-binary "vale-ls"
  "Path to the vale-ls executable.
May be an absolute path or a bare command name resolvable via $PATH."
  :type 'string
  :group 'lsp-vale)

(defcustom lsp-vale-vale-binary-path ""
  "Absolute path to the vale binary that vale-ls should invoke.
When empty, vale-ls looks for vale on $PATH."
  :type 'string
  :group 'lsp-vale)

(defcustom lsp-vale-config-path nil
  "Absolute path to a .vale.ini configuration file.
When nil (the default), lsp-vale searches upward from the current buffer
for a .vale.ini file and passes that path to vale-ls automatically.
Set to an empty string to disable auto-detection and rely entirely on
Vale's own upward search.  Set to an explicit path to override both."
  :type '(choice (const  :tag "Auto-detect" nil)
                 (string :tag "Path to .vale.ini"))
  :group 'lsp-vale)

(defcustom lsp-vale-install-vale nil
  "When non-nil, allow vale-ls to install and manage its own Vale binary.
The binary is placed in a vale_bin directory beside the vale-ls executable."
  :type 'boolean
  :group 'lsp-vale)

(defcustom lsp-vale-sync-on-startup nil
  "When non-nil, run `vale sync' each time the language server starts."
  :type 'boolean
  :group 'lsp-vale)

(defcustom lsp-vale-lint-on-change nil
  "When non-nil, report diagnostics while typing (requires stdin pipe support).
When nil (the default), diagnostics are reported on file open and save only.
Enabling this relies on vale-ls feeding buffer text to vale via a stdin pipe;
on some systems the pipe handshake fails and produces a JSON parse error in
vale-ls logs.  Enable only if you confirm it works reliably on your system."
  :type 'boolean
  :group 'lsp-vale)

(defcustom lsp-vale-debounce-ms 300
  "Milliseconds to wait after a keystroke before running Vale.
Only relevant when `lsp-vale-lint-on-change' is non-nil."
  :type 'integer
  :group 'lsp-vale)

(defcustom lsp-vale-show-metrics t
  "When non-nil, display code lenses with document word and sentence counts."
  :type 'boolean
  :group 'lsp-vale)

(defcustom lsp-vale-filter ""
  "An output filter expression applied to Vale diagnostics.
Example: \".Level in [\\\"warning\\\", \\\"error\\\"]\"
When empty, all diagnostics are shown."
  :type 'string
  :group 'lsp-vale)

(defcustom lsp-vale-active-modes
  '(text-mode markdown-mode gfm-mode org-mode rst-mode adoc-mode
    latex-mode LaTeX-mode)
  "Major modes in which vale-ls is activated.
vale-ls runs as an add-on alongside any other language server active for
the same buffer, so listing a mode here does not displace other servers."
  :type '(repeat symbol)
  :group 'lsp-vale)

;;; Internal helpers

(defun lsp-vale--find-ini-path ()
  "Return the path to a .vale.ini file, or nil if none is found.
Searches in order:
  1. Upward from the current buffer file or default-directory.
  2. $XDG_CONFIG_HOME/vale/.vale.ini (defaulting to ~/.config/vale/).
  3. ~/.vale.ini"
  (or
   (when-let* ((start (or buffer-file-name default-directory))
               (dir   (locate-dominating-file start ".vale.ini")))
     (expand-file-name ".vale.ini" dir))
   (let* ((xdg  (or (getenv "XDG_CONFIG_HOME")
                    (expand-file-name "~/.config")))
          (path (expand-file-name "vale/.vale.ini" xdg)))
     (when (file-readable-p path) path))
   (let ((path (expand-file-name "~/.vale.ini")))
     (when (file-readable-p path) path))))

(defun lsp-vale--initialization-options ()
  "Build the initializationOptions plist sent to vale-ls on startup."
  (let ((config-path (if (null lsp-vale-config-path)
                         (or (lsp-vale--find-ini-path) "")
                       lsp-vale-config-path)))
    (list :installVale    (if lsp-vale-install-vale t :json-false)
          :syncOnStartup  (if lsp-vale-sync-on-startup t :json-false)
          :lintOnChange   (if lsp-vale-lint-on-change t :json-false)
          :debounceMs     lsp-vale-debounce-ms
          :showMetrics    (if lsp-vale-show-metrics t :json-false)
          :filter         lsp-vale-filter
          :configPath     config-path
          :valeBinaryPath lsp-vale-vale-binary-path)))

;;; Settings registration
;;
;; Registers vale settings with lsp-mode so they can be sent via
;; workspace/didChangeConfiguration if the user wishes to push updates
;; to a running server (e.g. after M-x customize-group lsp-vale).
;; Vale-ls does not request workspace/configuration, so all startup
;; configuration flows through :initialization-options above.

(lsp-register-custom-settings
 '(("vale.installVale"    lsp-vale-install-vale    t)
   ("vale.syncOnStartup"  lsp-vale-sync-on-startup t)
   ("vale.lintOnChange"   lsp-vale-lint-on-change  t)
   ("vale.debounceMs"     lsp-vale-debounce-ms)
   ("vale.showMetrics"    lsp-vale-show-metrics     t)
   ("vale.filter"         lsp-vale-filter)
   ("vale.configPath"     lsp-vale-config-path)
   ("vale.valeBinaryPath" lsp-vale-vale-binary-path)))

;;; Client registration

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-stdio-connection (lambda () lsp-vale-binary))
  :activation-fn (lambda (_file-name _mode)
                   (apply #'derived-mode-p lsp-vale-active-modes))
  :initialization-options #'lsp-vale--initialization-options
  :priority -1
  :add-on? t
  :multi-root t
  :server-id 'vale-ls))

;;; Interactive commands

(defun lsp-vale-sync ()
  "Run `vale sync' via the language server to update remote styles."
  (interactive)
  (lsp-request-async
   "workspace/executeCommand"
   (list :command "cli.sync")
   (lambda (_) (message "vale: sync complete"))))

(defun lsp-vale-install ()
  "Install or update the Vale binary managed by vale-ls."
  (interactive)
  (lsp-request-async
   "workspace/executeCommand"
   (list :command "cli.install")
   (lambda (_) (message "vale: install complete"))))

(defun lsp-vale-compile-rule ()
  "Compile the Vale rule for the current buffer and open it on Regex101."
  (interactive)
  (lsp-request-async
   "workspace/executeCommand"
   (list :command "cli.compile"
         :arguments (vector (lsp--buffer-uri)))
   (lambda (_) nil)))

(defun lsp-vale-metrics ()
  "Display prose metrics for the current buffer."
  (interactive)
  (lsp-request-async
   "workspace/executeCommand"
   (list :command "doc.metrics"
         :arguments (vector (list :uri (lsp--buffer-uri))))
   (lambda (result)
     (message "vale metrics: %s" (lsp--json-serialize result)))))

(defun lsp-vale-vocab-add (term vocab)
  "Add TERM to the accept list of Vale vocabulary VOCAB.
When called interactively, prompts for both the term and the vocabulary name."
  (interactive
   (list (read-string "Term to accept: " (thing-at-point 'word t))
         (read-string "Vocabulary name: ")))
  (lsp-request-async
   "workspace/executeCommand"
   (list :command "vocab.add"
         :arguments (vector (list :uri   (lsp--buffer-uri)
                                  :vocab vocab
                                  :term  term)))
   (lambda (_) (message "vale: added %S to %s accept list" term vocab))))

(defun lsp-vale-vocab-reject (term vocab)
  "Add TERM to the reject list of Vale vocabulary VOCAB.
When called interactively, prompts for both the term and the vocabulary name."
  (interactive
   (list (read-string "Term to reject: " (thing-at-point 'word t))
         (read-string "Vocabulary name: ")))
  (lsp-request-async
   "workspace/executeCommand"
   (list :command "vocab.reject"
         :arguments (vector (list :uri   (lsp--buffer-uri)
                                  :vocab vocab
                                  :term  term)))
   (lambda (_) (message "vale: added %S to %s reject list" term vocab))))

;;; Footer

(lsp-consistency-check lsp-vale)

(provide 'lsp-vale)
;;; lsp-vale.el ends here
