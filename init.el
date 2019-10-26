;;; package --- Summary
;;; Commentary:

;;; Code:
(defun toggle-fullscreen ()
  (interactive)
  (cond ((string= window-system "x")
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
    (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
    )
  )
)
(toggle-fullscreen)

(setq inhibit-startup-message t) ;no splash screen
(setq make-backup-files nil)     ;no backup files
(setq default-directory "~/code/" )
;(tool-bar-mode -1)
(menu-bar-mode -1)
(set-frame-font "-*-white rabbit-normal-normal-normal-*-14-*-*-*-*-120-iso10646-1")
(modify-frame-parameters nil '((wait-for-wm . nil)))

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;; Manage
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/modes/")

(autoload 'mode-compile "mode-compile"
      "Command to compile current buffer file based on the major mode" t)

;; Lusty Explorer find stuff better
(require 'lusty-explorer)
(global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
(global-set-key (kbd "C-x C-b") 'lusty-buffer-explorer)
;; Helm Projectile find files in projects better
(global-set-key (kbd "C-x C-p") 'helm-projectile)
;; Ripgrep find stuff better
(global-set-key (kbd "C-x C-g") 'projectile-ripgrep)
(global-set-key (kbd "C-c g i r") 'ripgrep-regexp)

;; Company Mode
(autoload 'company-mode "company" nil t)
(add-hook 'after-init-hook 'global-company-mode)

;; Rainbow delimiters
(autoload 'rainbow-delimiters-mode "rainbow-delimiters" nil t)

;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;Snippets
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
	        ))
(yas-global-mode 1)


;; Hippie expand stuff
(require 'cc-mode)
;(require 'etags-table)

(defun tags-complete-tag (string predicate what)
  (save-excursion
    ;; If we need to ask for the tag table, allow that.
    (if (eq what t)
        (all-completions string (tags-completion-table) predicate)
      (try-completion string (tags-completion-table) predicate))))

(defun he-tag-beg ()
  (let ((p
         (save-excursion
           (backward-word 1)
           (point))))
    p))

(defun try-expand-tag (old)
  (unless  old
    (he-init-string (he-tag-beg) (point))
    (setq he-expand-list (sort
                          (all-completions he-search-string 'tags-complete-tag) 'string-lessp)))
  (while (and he-expand-list
              (he-string-member (car he-expand-list) he-tried-table))
              (setq he-expand-list (cdr he-expand-list)))
  (if (null he-expand-list)
      (progn
        (when old (he-reset-string))
        ())
    (he-substitute-string (car he-expand-list))
    (setq he-expand-list (cdr he-expand-list))
    t))
;;(global-set-key "\M- " 'hippie-expand)
(global-set-key "\M- " (make-hippie-expand-function
                        '(try-expand-dabbrev-visible
                          try-expand-dabbrev
                          try-expand-dabbrev-all-buffers
                          ;try-expand-tag
                          ) t))
;; end hippie expand stuff

;; CL

(require 'info-look)
(info-lookup-add-help
 :mode 'lisp-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))

;(load (expand-file-name "~/quicklisp/slime-helper.el"))

;(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
;(add-to-list 'load-path "~/.emacs.d/modes/slime/")  ; your SLIME directory

;(require 'slime)
;(slime-setup)

;; Elixir
(add-hook 'elixir-mode-hook 'alchemist-mode)
(add-hook 'elixir-mode-hook 'rainbow-delimiters-mode)
(setq alchemist-hooks-test-on-save t)
;(setq alchemist-hooks-compile-on-save t)

(add-hook 'elixir-mode-hook
  (lambda ()
    (define-key elixir-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
  )
)

;;Clojure
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(require 'cider)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(setq cider-auto-select-error-buffer nil)

;;ML
(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;; (autoload 'utop-minor-mode "utop" "Minor mode for utop" t)
;; (add-hook 'tuareg-mode-hook 'utop-minor-mode)

;;Puppet
(require 'puppet-mode)
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

;;Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;HTML web-mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html.erb?\\'" . web-mode))

;;Mustache
(add-to-list 'auto-mode-alist '("\\.mustache$" . tpl-mode))
(add-hook 'mustache-mode-hook 'rainbow-delimiters-mode)

;;Sass
(require 'sass-mode)

;; CSS
(setq css-indent-offset 2)

;;Javascript
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook 'rainbow-delimiters-mode)
(add-hook 'js2-mode-hook 'company-mode)
;(setq js2-bounce-indent-p t)
;(setq js2-mirror-mode nil)
(add-hook 'js2-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(require 'indium)
(add-hook 'js2-mode-hook #'indium-interaction-mode)

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)

(add-hook 'json-mode-hook 'rainbow-delimiters-mode)
(add-hook 'json-mode-hook 'company-mode)
(add-hook 'json-mode-hook 'prettier-js-mode)
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; use eslint with web-mode for jsx files & js2 mode
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
	  '(json-jsonlist)))

;; Typescript
(setq typescript-indent-level 2
      typescript-expr-indent-offset 2)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
;;(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-hook 'typescript-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c a i i") 'run-ts)
            (local-set-key (kbd "C-c a i r") 'ts-send-region-and-go)
            (local-set-key (kbd "C-c a i b") 'ts-send-buffer-and-go)))

;;Coffee
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(add-hook 'coffee-mode-hook 'rainbow-delimiters-mode)
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)

  (setq coffee-debug-mode t)

  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)

;  (add-hook 'after-save-hook
;    '(lambda ()
;      (when (string-match "\.coffee$" (buffer-name))
;        (coffee-compile-file))))
)
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;;Python
(elpy-enable)
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
	                  "jupyter")
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;;PHP
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;;Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'rainbow-delimiters-mode)

;;Julia
(require 'julia-mode)
(require 'julia-repl)

(flycheck-julia-setup)

(add-hook 'julia-mode-hook
  (lambda ()
    (define-key julia-mode-map (kbd "C-c a i b") 'julia-repl-send-buffer)
    (define-key julia-mode-map (kbd "C-c a i r") 'julia-repl-send-region-or-line)
    (define-key julia-mode-map (kbd "C-c a i i") 'julia-repl)
    (define-key julia-mode-map (kbd "C-c a i p") 'julia-repl)
  )
)
(setq julia-indent-offset 2)

;;Octave
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

;; Scala
(add-hook 'ensime-mode-hook
  (lambda ()
    ;; (define-key ensime-mode-map (kbd "C-c a i b") 'ammonite-term-repl-load-file)
    ;; (define-key ensime-mode-map (kbd "C-c a i r") 'ammonite-term-repl-send-region)
    ;; (define-key ensime-mode-map (kbd "C-c a i i") 'run-ammonite)
    (define-key ensime-mode-map (kbd "C-c a i b") 'ensime-inf-eval-buffer)
    (define-key ensime-mode-map (kbd "C-c a i r") 'ensime-inf-eval-region)
    (define-key ensime-mode-map (kbd "C-c a i i") 'ensime-inf-switch)
    (define-key ensime-mode-map (kbd "C-c a i p") 'ensime-sbt-switch)
    (define-key ensime-mode-map (kbd "C-c a t") 'ensime-sbt-do-test)
    (define-key ensime-mode-map (kbd "C-c a r") 'ensime-sbt-do-test-quick-dwim)
    (define-key ensime-mode-map (kbd "C-c a m t b") 'ensime-sbt-do-test-dwim)
    (define-key ensime-mode-map (kbd "C-c a m t .") 'ensime-sbt-do-test-only-dwim)

    (add-hook 'before-save-hook 'ensime-format-source)
  )
)
;; ReasonML
(defun shell-cmd (cmd)
  "Returns the stdout output of a shell command or nil if the command returned
   an error"
  (car (ignore-errors (apply 'process-lines (split-string cmd)))))

(defun reason-cmd-where (cmd)
  (let ((where (shell-cmd cmd)))
    (if (not (string-equal "unknown flag ----where" where))
      where)))

(let* ((refmt-bin (or (reason-cmd-where "refmt ----where")
                      (shell-cmd "which refmt")))
       (merlin-bin (or (reason-cmd-where "ocamlmerlin ----where")
                       (shell-cmd "which ocamlmerlin")))
       (merlin-base-dir (when merlin-bin
                          (replace-regexp-in-string "bin/ocamlmerlin$" "" merlin-bin))))
  ;; Add merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
  (when merlin-bin
    (add-to-list 'load-path (concat merlin-base-dir "share/emacs/site-lisp/"))
    (setq merlin-command merlin-bin))

  (when refmt-bin
    (setq refmt-command refmt-bin)))

(require 'reason-mode)
(require 'merlin)

(add-hook 'reason-mode-hook (lambda ()
                              (add-hook 'before-save-hook 'refmt-before-save)
                              (merlin-mode)))

(setq merlin-ac-setup t)

(add-to-list 'auto-mode-alist '("\\.re$" . reason-mode))
(add-to-list 'auto-mode-alist '("\\.rei$" . reason-mode))

(require 'utop)
;;(setq utop-command "opam config exec -- rtop -emacs")
(setq utop-command "rtop -emacs")
(add-hook 'reason-mode-hook #'utop-minor-mode)

(add-hook 'reason-mode-hook
  (lambda ()
    (define-key reason-mode-map (kbd "C-c a i b") 'utop-eval-buffer)
    (define-key reason-mode-map (kbd "C-c a i r") 'utop-eval-region)
    (define-key reason-mode-map (kbd "C-c a i i") 'utop)
    (define-key reason-mode-map (kbd "C-c a i p") 'utop)
  )
)

;; Ruby
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

(setq ruby-insert-encoding-magic-comment nil)

(add-hook 'ruby-mode-hook 'rainbow-delimiters-mode)

(add-hook 'ruby-mode-hook #'rubocopfmt-mode)
(add-hook 'ruby-mode-hook 'rubocop-mode)

;; Start minitest setup
(add-hook 'ruby-mode-hook 'minitest-mode)
(eval-after-load 'minitest
  '(minitest-install-snippets))

(add-hook 'minitest-mode-hook
  (lambda ()
    (define-key minitest-mode-map (kbd "C-c a t") 'minitest-verify-all)
    (define-key minitest-mode-map (kbd "C-c a r") 'minitest-rerun)
    (define-key minitest-mode-map (kbd "C-c a m t b") 'minitest-verify)
    (define-key minitest-mode-map (kbd "C-c a m t .") 'minitest-verify-single)
  )
)

(add-hook 'minitest-compilation-mode-hook
  (lambda ()
    (define-key minitest-compilation-mode-map (kbd "C-o") nil)
    (define-key minitest-compilation-mode-map (kbd "C-c a t") 'minitest-verify-all)
    (define-key minitest-compilation-mode-map (kbd "C-c a r") 'minitest-rerun)
  )
)
;; End Minitest setup

;; Start Rspec Setup
;; (add-hook 'ruby-mode-hook 'rspec-mode)
;; (eval-after-load 'rspec-mode
;;  '(rspec-install-snippets))
;; (add-hook 'rspec-mode-hook
;;   (lambda ()
;;     (define-key rspec-mode-map (kbd "C-c a t") 'rspec-verify-all)
;;     (define-key rspec-mode-map (kbd "C-c a r") 'rspec-rerun)
;;     (define-key rspec-mode-map (kbd "C-c a m t b") 'rspec-verify)
;;     (define-key rspec-mode-map (kbd "C-c a m t .") 'rspec-verify-single)
;;   )
;; )
;; (add-hook 'rspec-verifiable-mode-hook
;;   (lambda ()
;;     (define-key rspec-verifiable-mode-map (kbd "C-c a t") 'rspec-verify-all)
;;     (define-key rspec-verifiable-mode-map (kbd "C-c a r") 'rspec-rerun)
;;     (define-key rspec-verifiable-mode-map (kbd "C-c a m t b") 'rspec-verify)
;;     (define-key rspec-verifiable-mode-map (kbd "C-c a m t .") 'rspec-verify-method)
;;   )
;; )
;; (add-hook 'rspec-compilation-mode-hook
;;   (lambda ()
;;     (define-key rspec-compilation-mode-map (kbd "C-o") nil)
;;     (define-key rspec-compilation-mode-map (kbd "C-c a t") 'rspec-verify-all)
;;     (define-key rspec-compilation-mode-map (kbd "C-c a r") 'rspec-rerun)
;;   )
;; )
;; (setq rspec-use-rvm nil)
;; (setq rspec-use-spring-when-possible nil)
;; (add-hook 'after-init-hook 'inf-ruby-switch-setup)

;; End Rspec Setup

(require 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)

(eval-after-load 'company
  '(push 'company-robe company-backends))


(add-hook 'robe-mode-hook
  (lambda ()
    (define-key robe-mode-map (kbd "C-c a h e") 'robe-doc)
  )
)

(add-hook 'ruby-mode-hook 'projectile-mode)

(require 'projectile-rails)
(projectile-rails-global-mode)
(setq projectile-rails-expand-snippet nil)

(define-key projectile-rails-mode-map (kbd "C-c a i p") 'projectile-rails-server)
(define-key projectile-rails-mode-map (kbd "C-c a i i") 'projectile-rails-console)

(add-hook 'ruby-mode-hook
  (lambda ()
    (define-key ruby-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key ruby-mode-map (kbd "C-c a i b") 'ruby-load-file)
    (define-key ruby-mode-map (kbd "C-c a i r") 'ruby-send-region)
    (define-key ruby-mode-map (kbd "C-c a i m") 'ruby-send-region-and-go)
    (define-key ruby-mode-map (kbd "C-c a i i") 'inf-ruby-console-auto)
    ;; (define-key ruby-mode-map (kbd "C-c a i p") 'inf-ruby-console-auto)
  )
)

(add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)

;; SQL mode
;; Capitalize keywords in SQL mode
(add-hook 'sql-mode-hook 'sqlup-mode)
;; Capitalize keywords in an interactive session (e.g. psql)
(add-hook 'sql-interactive-mode-hook 'sqlup-mode)

(eval-after-load 'flycheck
  '(progn
     (flycheck-add-mode 'sql-sqlint 'sql-mode)))

;; (eval-after-load 'flycheck
;;   '(flycheck-soar-setup))

;; (flycheck-define-checker sql-sqlcheck
;;   "Identify anti-patterns"
;;   :command ("sqlcheck" "-v" "-f" source-inplace)
;;   ;; :standard-input t
;;   :error-patterns
;;   (
;;    ;; (info line-start (file-name) ":" line ":" column ": C: "
;;    ;;       (optional (id (one-or-more (not (any ":")))) ": ") (message) line-end)
;;    ;; (warning line-start (file-name) ":" line ":" column ": W: "
;;    ;;          (optional (id (one-or-more (not (any ":")))) ": ") (message)
;;    ;;          line-end)
;;    (error line-start
;;           (minimal-match (one-or-more (not-char "[")))
;;           "[" (file-name) "]: (HIGH RISK)" (message (one-or-more (not-char "[")))
;;           "[Matching Expression:" (minimal-match (one-or-more not-newline)) "]"line-end)
;;    )
;;   :modes (sql-mode)
;;   :predicate (lambda () (buffer-file-name))
;;   )
;; (add-to-list 'flycheck-checkers 'sql-sqlcheck t)
;;
;; (eval-after-load 'flycheck
;;   '(progn
;;      (flycheck-add-mode 'sql-sqlcheck 'sql-mode)))
;;
;; (flycheck-add-next-checker 'sql-sqlint 'sql-sqlcheck)

(setq sql-indent-offset 2)


(add-hook 'sql-mode-hook
  (lambda ()
    ;; (add-hook 'before-save-hook #'format-sql-buffer)
    (define-key sql-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key sql-mode-map (kbd "C-c a i r") 'sql-send-region)
    (define-key sql-mode-map (kbd "C-c a i m") 'sql-send-region-and-go)
    (define-key sql-mode-map (kbd "C-c a i b") 'sql-send-buffer)
  )
)

;; Global Useful


(require 'linum)
(global-linum-mode 1)
(setq linum-format " %d ")


(defvar skeletons-alist
      '((?\( . ?\))
        (?\' . ?\')
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
;; (global-set-key "' 'skeleton-pair-insert-maybe)

;; Terminals

(setq explicit-shell-file-name "/usr/bin/fish")

(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)

(setq multi-term-program "/bin/bash")   ;; use bash
;; (setq multi-term-program "/bin/zsh") ;; or use zsh...

;; only needed if you use autopair
;(add-hook 'term-mode-hook
;  #'(lambda () (setq autopair-dont-activate t)))

(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

(global-set-key (kbd "M-S-<up>")   'enlarge-window)
(global-set-key (kbd "M-S-<down>") 'shrink-window)
;;stylin

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(require 'color-theme)

(setq x-select-enable-clipboard t)

(show-paren-mode 1)
(setq-default c-basic-offset 2)
(setq-default indent-tabs-mode nil)
(delete-selection-mode 1)

(require 'whitespace)
(setq whitespace-style '(face lines-tail trailing))
(global-whitespace-mode t)

(require 'ebs)
  (ebs-initialize)
  (global-set-key [(control tab)] 'ebs-switch-buffer)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(global-set-key (kbd "C-z") 'goto-line)

(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-u") 'previous-multiframe-window)

(global-set-key (kbd "C-k") 'kill-buffer)


(add-hook 'coffee-mode-hook
  (lambda ()
    (define-key coffee-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
  )
)

(put 'upcase-region 'disabled nil)

(defun rjspotter-set-font-snap()
  (interactive)
  (set-default-font "-artwiz-snap-normal-normal-normal-*-10-*-*-*-*-90-iso10646-1")
)

(defun rjspotter-set-font-edges()
  (interactive)
  (set-default-font "-artwiz-edges-normal-normal-normal-*-10-*-*-*-*-90-iso10646-1")
)

(defun rjspotter-set-font-bitstream()
  (interactive)
  (set-default-font "-*-bitstream vera sans mono-medium-r-*-*-*-100-*-*-*-*-iso8859-*")
)

(defun rjspotter-set-font-whiterabbit()
  (interactive)
(set-default-font "-*-white rabbit-normal-normal-normal-*-14-*-*-*-*-140-iso10646-1")
)
;; font to try http://www.fonts.com/findfonts/detail.htm?productid=46934

;; Change cursor color according to mode; inspired by
;; http://www.emacswiki.org/emacs/ChangingCursorDynamically
(setq djcb-read-only-color       "gray")
;; valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for set-cursor-type

(setq djcb-read-only-cursor-type 'hbar)
(setq djcb-overwrite-color       "red")
(setq djcb-overwrite-cursor-type 'box)
(setq djcb-normal-color          "green")
(setq djcb-normal-cursor-type    'bar)

(defun djcb-set-cursor-according-to-mode ()
  "change cursor color and type according to some minor modes."

  (cond
    (buffer-read-only
      (set-cursor-color djcb-read-only-color)
      (setq cursor-type djcb-read-only-cursor-type))
    (overwrite-mode
      (set-cursor-color djcb-overwrite-color)
      (setq cursor-type djcb-overwrite-cursor-type))
    (t
      (set-cursor-color djcb-normal-color)
      (setq cursor-type djcb-normal-cursor-type))))

(add-hook 'post-command-hook 'djcb-set-cursor-according-to-mode)

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/conkeror")

;; Auto load rjspotter-new theme in terminal mode
(add-hook 'after-init-hook (lambda () (load-theme 'rjspotter-new)))

(defun package-reinstall-all-activated-packages ()
  "Refresh and reinstall all activated packages."
  (interactive)
  (package-refresh-contents)
  (dolist (package-name package-activated-list)
    (when (package-installed-p package-name)
      (unless (ignore-errors                   ;some packages may fail to install
                (package-reinstall package-name))
        (warn "Package %s failed to reinstall" package-name)))))

;; (defun rjspotter-do-translate ()
;;   (interactive)
;;   (setq google-translate-default-source-language "zh" )
;;   (setq google-translate-default-target-language "en")
;;   (setq google-translate-output-destination 'kill-ring)
;;   (google-translate-at-point)
;;   (delete-active-region)
;;   (yank)
;; )
;; (global-set-key (kbd "C-c t") 'rjspotter-do-translate)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("80cc2866d01d4beeb62e7db06e1b3da3238dfa308dac6b84ca73104b41da4f0d" "64aa574bcf17bcb3991ba2ae2790a1e376751f1a78e93969b7999fafc7397788" "875a26098a8383b7077ed6b420f5f35c9d48ccea41ecf3029482d00fbe299705" "d8e14fb20c3b86f63b7815ca3fbe8cca2783c959efa5553c10b740af11fda8b1" "6804f0a43f217541d825911dffd8b9e8f6520744846976d5c6c3ad1f9f3c15ba" "563dd3ddad50e6887c9bc1aecf296cc3f2edce55537f0db48f719a70d3401131" "6f4c7ba06a17f53ce8fd24339558a320e255a135463f0b52820d2d64d07fa20b" "d6c896faa310e2c894f77c46cc083ae88b5da037d5ff1f06f850e330dcfc19bb" "a29b6383f0ab5550cb33b372b33006119f980fc369c6276a8f6de2ae14511b50" "964fd76d9adab895b54238794ef7e7036c1696bd8a44ed0093810cd467ec988d" "e03cb2cc566c46866bb355d691404cba3bf71d286426d9f142a0e7355b6bf3e6" "3d5f2fe54a9ab976d144f8d19bbc72b074c8a412a6cda0f9d691c37e4c53427c" "ca3b4f9009735476101aa08fcfb0872150810aa22e571d79e2b69193b61f1c86" "4528fb576178303ee89888e8126449341d463001cb38abe0015541eb798d8a23" "a8474a7e7e8951c5c111f80ac20de97139d44f20a8ed04254aa912a0edf501b2" "04731852318149f51dcf8ea7b1cafd20ff890d73ad7e585960a31d641d433893" "569db32037846cb93193d61c602eea9e6a4298ae3c4ee427cba2bcf14abeeef5" "dafd9d8d03e1068a05f98d77930e6cae260401fc9b93d1c03a5283b4db5ad26d" "fcc4badafd60fc0213472e655145fba70a7fa537db9f2aca80ec9edda221741d" "1414739793dd40e6cded535aaab7aa1f85577325312f3c4f7a294ac7464d7355" "32bf5c3ac67a48d910fbe94ccf3a8252b60f6ddf" "16c3a1560cc699bfc8ea13e9acba10045b02aa8d" "d66b5da4870d8838edbf984b1dc31e37efe1257b" "b5d3a19124561e92127c3bd917a6c2ae520c4c10" "c3adda001695657e6da90aa3268bbbf4f6af433b" "101b2a189997144931107b663cf1937ce94acd5a" "07c541895ec9b323bf25dc3c63a8a400dba6d2ca" "f67bc85632a7db951c45fbcdf55456b882f1ce32" "63baf5b4551d57e16ae558d40a0b27c426fbd880" "285a5928d414486528564472e49ce46db448e296" "9f3b064f42e48f3cce4ee007301453e37a871df5" "a71460243d93d271e33a969dd064a663022781d7" "f1ca2dfb5f86a53c386c18a8cc194474f4932a79" "0943252a540b205d7a7e492b33067c6740a0870a" default)))
 '(package-selected-packages
   (quote
    (google-translate sql-presto flycheck-soar format-sql helm-sql-connect hive pgdevenv sql-indent sqlformat sqlup-mode docker docker-cli docker-compose-mode docker-tramp dockerfile-mode ein py-autopep8 elpy flycheck-pycheckers flycheck-pyflakes flycheck-pyre ammonite-term-repl ensime scala-mode scalariform fsharp-mode ng2-mode ess flycheck-julia julia-mode julia-repl julia-shell caml coffee-mode flycheck-ocaml haskell-mode haskell-snippets php-mode smarty-mode tuareg rubocop rubocopfmt rspec-mode foreman-mode fish-mode utop lusty-explorer merlin merlin-eldoc reason-mode eslint-fix indium handlebars-mode handlebars-sgml-mode prettier-js helm-rg projectile-ripgrep ripgrep slim-mode minitest projectile robe helm-projectile helm-rails helm-rb helm-rubygems-local flycheck-clojure flycheck-credo flycheck-dialyxir flycheck-elixir flycheck-haskell flycheck-mix flycheck-yamllint yaml-mode tide ts-comint typescript-mode js2-mode graphql-mode magit json-mode inf-ruby multi-term mustache-mode rainbow-delimiters sass-mode yasnippet alchemist elm-mode elm-yasnippets web-mode flycheck cider clojure-mode clojure-snippets smartparens react-snippets markdown-mode+ javap-mode helm eval-sexp-fu elixir-yasnippets elixir-mode el-autoyas datomic-snippets company cil-mode autopair auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
