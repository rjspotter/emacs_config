;;; package --- Summary
;;; Commentary:

;;; Code:

(setq inhibit-startup-message t) ;no splash screen
(setq make-backup-files nil)     ;no backup files
(setq default-directory "~/code/" )
(menu-bar-mode -1)

;; Manage
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

(setq package-check-signature nil)

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/modes/")

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)

(exec-path-from-shell-initialize)


;;;;; Finding Things [Start]

;;; Better buffers

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(global-set-key (kbd "C-x b") 'switch-to-buffer)
(global-set-key (kbd "C-x C-b") 'switch-to-buffer)

;;; ripgrep
(use-package rg
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/code"))
  :config
  (define-key projectile-mode-map (kbd "C-c a p ") 'projectile-command-map)
  (global-set-key (kbd "C-c a p ") 'projectile-command-map)
  (projectile-mode +1))

(add-hook 'project-find-functions #'project-projectile)

(global-set-key (kbd "C-c a p g") 'projectile-ripgrep)

;;;;; Finding Things [End]

;;;;; Completion & Hinting [Start]

;;; eldoc
(use-package eldoc
  :ensure t
  ;; :custom (eldoc-echo-area-use-multiline-p 'truncate-sym-name-if-fit)
)

(setq read-process-output-max (* 1024 1024))


;;;; LSP Stuff

;;; lsp-mode
(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  (elixir-ts-mode . lsp)
  :init
  (setq lsp-keymap-prefix "C-c l"
        lsp-before-save-edits nil
        lsp-auto-guess-root nil
        lsp-completion-provider :none
        company-ctags-ignore-case t
        company-ctags-fuzzy-match-p t
        lsp-signature-render-documentation t
        lsp-modeline-code-actions-segments '(count icon name)))

(use-package lsp-ui
  :ensure t
  :init
  (setq lsp-ui-doc-show-with-cursor t
        ;; lsp-ui-sideline-show-hover t
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-show-code-actions t))


;; Snippets
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
	        ))
(yas-global-mode 1)
(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

;; Company Mode
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2
        company-abort-on-unique-match nil
        company-dabbrev-downcase t
        company-dabbrev-code-everywhere t
        company-dabbrev-code-modes t
        company-dabbrev-code-other-buffers 'all
        company-backends '((company-capf company-yasnippet company-dabbrev-code) (company-dabbrev company-files) (company-ispell))
  ))

(define-key company-active-map (kbd "C-f") #'company-other-backend)
(define-key company-active-map (kbd "C-d") #'company-try-hard)
(define-key company-active-map (kbd "C-g") #'company-abort)

(add-hook 'after-init-hook 'global-company-mode)

;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;;;; Completion & Hinting [End]

;;;;; Languages [Start]


;;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook
  (lambda ()
    (add-hook 'before-save-hook #'whitespace-cleanup)
    (auto-fill-mode)
    (setq fill-column 100)
  )
)

;;; HTML web-mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Mustache
(add-to-list 'auto-mode-alist '("\\.mustache$" . tpl-mode))
(add-hook 'mustache-mode-hook 'rainbow-delimiters-mode)

;;; Sass
(require 'sass-mode)

;;; CSS
(setq css-indent-offset 2)
(add-to-list 'major-mode-remap-alist '(css-mode . css-ts-mode))

;;;  Python
(use-package python
  :hook ((python-ts-mode . lsp-deferred)
         (python-ts-mode . ruff-format-on-save-mode)
         (python-ts-mode . flymake-ruff-load)
         )
  :custom (dap-python-debugger 'debugpy)
  :config (require 'dap-python)

  :mode (("\\.py\\'" . python-ts-mode)))

(add-hook 'python-ts-mode-hook
  (lambda ()
    (add-hook 'before-save-hook #'whitespace-cleanup)
    (define-key python-ts-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key python-ts-mode-map (kbd "C-c a f b") 'ruff-format-buffer)
    (define-key python-ts-mode-map (kbd "C-c a f r") 'ruff-format-region)
    (define-key python-ts-mode-map (kbd "C-c a i b") 'python-shell-send-buffer)
    (define-key python-ts-mode-map (kbd "C-c a i r") 'python-shell-send-region)
    (define-key python-ts-mode-map (kbd "C-c a i i") 'run-python)
    (define-key python-ts-mode-map (kbd "C-c a i p") 'python-shell)
    (define-key python-ts-mode-map (kbd "C-c a m t t") 'python-pytest)
    (define-key python-ts-mode-map (kbd "C-c a m t .") 'python-pytest-function)
    (define-key python-ts-mode-map (kbd "C-c a m t b") 'python-pytest-file)
    (define-key python-ts-mode-map (kbd "C-c a m t r") 'python-pytest-repeat)
    (define-key python-ts-mode-map (kbd "C-c a h e") 'eldoc)
  )
)
(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))


(use-package highlight-indent-guides
  :ensure t
  :hook (python-ts-mode . highlight-indent-guides-mode)
  :config
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  (setq highlight-indent-guides-method 'character))

;;; Python-end

;;; SQL start

;; I haven't really found that LSP makes doing SQL better
;; (add-hook 'sql-mode-hook 'lsp)
;; (setq lsp-sql-server-path "/usr/bin/sql-language-server")
;; (setq lsp-sqls-server "/home/rjspotter/go/bin/sqls")
;; (setq lsp-sqls-workspace-config-path nil)

;; sqlformat
(require 'sqlformat)
(setq sqlformat-command 'sqlfluff)
(setq sqlformat-args '("-n" "--ignore=templating" "--config=~/.config/sqlfluff/setup.cfg"))

(add-hook 'sql-mode-hook
  (lambda ()
    (add-hook 'before-save-hook #'whitespace-cleanup)
    (sqlup-mode)
    (sqlformat-on-save-mode)
    (define-key sql-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key sql-mode-map (kbd "C-c a i r") 'sql-send-region)
    (define-key sql-mode-map (kbd "C-c a i m") 'sql-send-region-and-go)
    (define-key sql-mode-map (kbd "C-c a i b") 'sql-send-buffer)
    (define-key sql-mode-map (kbd "C-c a f b") 'sqlformat-buffer)
    (define-key sql-mode-map (kbd "C-c a f r") 'sqlformat-region)
    (define-key sql-mode-map (kbd "C-c a f s") 'sqlformat-on-save-mode)
  )
)

(add-hook 'sql-interactive-mode-hook
  (lambda ()
    (sqlup-mode)
    (display-line-numbers-mode)
  )
)

;;; SQL end

;;; Typescript start
(use-package typescript
  :hook (
         ;; (typescript-ts-mode . flymake-eslint)
         (typescript-ts-mode . prettier-js-mode))
  :mode (
         ("\\.ts\\'" . typescript-ts-mode)
         ("\\.mts\\'" . typescript-ts-mode)
         ("\\.js\\'" . typescript-ts-mode)
         ("\\.mjs\\'" . typescript-ts-mode)
         ("\\.cjs\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)
         ("\\.jsx\\'" . tsx-ts-mode)
         ))

(add-hook 'typescript-ts-mode-hook
  (lambda ()
    (add-hook 'before-save-hook #'whitespace-cleanup)
    (define-key typescript-ts-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key typescript-ts-mode-map (kbd "C-c a h e") 'eldoc)
    (define-key typescript-ts-mode-map (kbd "C-c a i i") 'run-ts)
    (define-key typescript-ts-mode-map (kbd "C-c a i r") 'ts-send-region)
    (define-key typescript-ts-mode-map (kbd "C-c a i m") 'ts-send-region-and-go)
    (define-key typescript-ts-mode-map (kbd "C-c a i b") 'ts-send-buffer-and-go)
    (define-key typescript-ts-mode-map (kbd "C-c a f b") 'prettier-js-prettify)
    (define-key typescript-ts-mode-map (kbd "C-c a f r") 'prettier-js-prettify-region)
  )
)
(add-to-list 'major-mode-remap-alist '(typescript-mode . typescript-ts-mode))

(use-package lsp-eslint
  :demand t
  :after lsp-mode)

(add-to-list 'major-mode-remap-alist '(json-mode . json-ts-mode))

;;; Typescript end

;;;;; Languages [End]

;;;;; Global Useful [Start]

;; mise environment management
(add-hook 'after-init-hook #'global-mise-mode)

(setq auto-save-file-name-transforms
  `((".*" ,"~/.emacs.d/auto-save/" t)))

(global-display-line-numbers-mode 1)

;; parens et al
(autoload 'rainbow-delimiters-mode "rainbow-delimiters" nil t)

(show-paren-mode 1)

(defvar skeletons-alist
      '((?\( . ?\))
        (?\" . ?\")
        (?[  . ?])
        (?{  . ?})))

(defadvice delete-backward-char (before delete-empty-pair activate)
      (if (eq (cdr (assq (char-before) skeletons-alist)) (char-after))
          (and (char-after) (delete-char 1))))

(setq skeleton-pair t)
(setq skeleton-autowrap t)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)

;; Terminals

(setq explicit-shell-file-name "/usr/bin/fish")

(use-package eat
  :pin nongnu
  :custom
  (eat-kill-buffer-on-exit t)
  :config
  (delete [?\C-u] eat-semi-char-non-bound-keys) ; make C-u work in Eat terminals like in normal terminals
  (delete [?\C-g] eat-semi-char-non-bound-keys) ; ditto for C-g
  (eat-update-semi-char-mode-map)
  ;; XXX: Awkward workaround for the need to call eat-reload after changing Eat's keymaps,
  ;; but reloading from :config section causes infinite recursion because :config wraps with-eval-after-load.
  (defvar eat--prevent-use-package-config-recursion nil)
  (unless eat--prevent-use-package-config-recursion
    (setq eat--prevent-use-package-config-recursion t)
    (eat-reload))
  (makunbound 'eat--prevent-use-package-config-recursion)
  )

(add-hook 'eat-mode-hook
  (lambda ()
    (rainbow-delimiters-mode)
    (display-line-numbers-mode)
    (define-key eat-line-mode-map (kbd "C-o") 'other-window)
    (define-key eat-semi-char-mode-map (kbd "C-o") 'other-window)
    (define-key eat-char-mode-map (kbd "C-o") 'other-window)
  )
  )

;;stylin

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; indentation
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; (setq-default indent-line-function 'insert-tab)

(delete-selection-mode 1)

(require 'whitespace)
(setq whitespace-style '(face empty trailing))
(global-whitespace-mode t)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-z") 'goto-line)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-k") 'kill-buffer)
(global-set-key (kbd "C-c a T") 'eat)
(global-set-key (kbd "M-S-<up>")   'enlarge-window)
(global-set-key (kbd "M-S-<down>") 'shrink-window)
(global-set-key (kbd "C-c a f u") 'string-inflection-underscore)
(global-set-key (kbd "C-c a f c") 'string-inflection-camelcase)
(global-set-key (kbd "C-c a f l") 'string-inflection-lower-camelcase)

(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("620701aa8cacf5791f0c7a9e0347158aa91d660a1f7beae2290bfeb1fd8fd645"
     "a627866aec24c6463384d9089d8fe7ef7223d5653fddd0bc61bf03b3d21b21c3"
     "2664eff0633db73cbcd5ef35070fc5901f4067861ee7a3e9cb4a7421bbbb0ce5"
     default))
 '(package-selected-packages
   '(auto-complete autopair company company-ctags company-fuzzy
                   company-lsp company-nginx company-statistics
                   company-terraform company-try-hard dap-mode docker
                   docker-cli docker-compose-mode dockerfile-mode eat
                   ein ess eval-sexp-fu exec-path-from-shell fish-mode
                   flycheck flycheck-pycheckers flycheck-pyflakes
                   flycheck-pyre flycheck-yamllint flymake-ruff
                   format-sql gnu-elpa-keyring-update graphql-mode
                   handlebars-mode highlight-indent-guides jinja2-mode
                   json-mode lsp-ui magit marginalia markdown-mode+
                   mise mmm-jinja2 mmm-mode mustache-mode orderless
                   prettier-js projectile projectile-ripgrep
                   py-autopep8 py-snippets python-black python-pytest
                   rainbow-delimiters react-snippets rg ripgrep
                   ruff-format sass-mode smartparens sql-indent
                   sqlformat sqlup-mode string-inflection ts-comint
                   typescript-mode vertico web-mode yaml-mode
                   yasnippet yasnippet-capf yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Auto load rjspotter-new theme in terminal mode
(add-hook 'after-init-hook (lambda () (load-theme 'rjspotter-matrix)))
