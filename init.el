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

;; Lusty Explorer replaced by vertico et al
;; (require 'lusty-explorer)
;; (global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
;; (global-set-key (kbd "C-x C-b") 'lusty-buffer-explorer)

;;; ripgrep
(use-package rg
  :ensure t)


;; Helm Projectile find files in projects better
;; (global-set-key (kbd "C-x C-p") 'helm-projectile)
;; (global-set-key (kbd "C-x C-g") 'projectile-ripgrep)

(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '("~/code")
        projectile-tags-command "/home/rjspotter/bin/ctags")
  :config
  (define-key projectile-mode-map (kbd "C-c a p ") 'projectile-command-map)
  (global-set-key (kbd "C-c a p ") 'projectile-command-map)
  (projectile-mode +1))

(add-hook 'project-find-functions #'project-projectile)

;; (global-set-key (kbd "C-x C-p") 'project-find-file)
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
        lsp-modeline-code-actions-segments '(count icon name))
  (add-to-list 'exec-path "/home/rjspotter/lib/elixir-ls/"))

(use-package lsp-ui
  :ensure t
  :init
  (setq lsp-ui-doc-show-with-cursor t
        lsp-ui-sideline-show-hover t
        lsp-ui-sideline-show-code-actions t))


;;; eglot
;; (use-package eglot
;;   :ensure t
;;   :demand t
;;   :bind (:map eglot-mode-map
;; 	      ("C-c a f b" . eglot-format-buffer)
;; 	      ("C-c a a" . eglot-code-actions)
;; 	      ("C-c a h e" . eldoc)
;; 	      ("C-c a p r" . eglot-rename)
;;               )
  ;; :config
  ;; (setq eglot-ignored-server-capabilities '(:inlayHintProvider))
;; )


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
                        '(yas-hippie-try-expand
                          try-expand-dabbrev-visible
                          try-expand-dabbrev
                          try-expand-dabbrev-all-buffers
                          ;try-expand-tag
                          ) t))
;; end hippie expand stuff

;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;;;; Completion & Hinting [End]

;;;;; Languages [Start]

;;; Elixir

;; (add-hook 'elixir-mode-hook 'alchemist-mode)
;; (add-hook 'elixir-mode-hook 'rainbow-delimiters-mode)
;; (setq alchemist-hooks-test-on-save t)
;; ;(setq alchemist-hooks-compile-on-save t)

;; (add-hook 'elixir-mode-hook
;;   (lambda ()
;;     (define-key elixir-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
;;   )
;; )

(use-package elixir-ts-mode
  :ensure t
  :after (ls-mode)
  :hook ((elixir-ts-mode . lsp)
	 (elixir-ts-mode . rainbow-delimiters-mode)
         (before-save . lsp-format-buffer))
  :config
  (add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-ts-mode)))

(use-package mix
  :ensure t
  :config
  (add-hook 'elixir-ts-mode-hook 'mix-minor-mode))

(use-package inf-elixir
  :ensure t)

(require 'dap-elixir)

(add-hook 'elixir-ts-mode-hook
  (lambda ()
    (define-key elixir-ts-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key elixir-ts-mode-map (kbd "C-c a f b") 'lsp-format-buffer)
    (define-key elixir-ts-mode-map (kbd "C-c a f r") 'lsp-format-region)
    (define-key elixir-ts-mode-map (kbd "C-c a i i") 'inf-elixir)
    (define-key elixir-ts-mode-map (kbd "C-c a i p") 'inf-elixir-project)
    (define-key elixir-ts-mode-map (kbd "C-c a i r") 'inf-elixir-send-region)
    (define-key elixir-ts-mode-map (kbd "C-c a i l") 'inf-elixir-send-line)
    (define-key elixir-ts-mode-map (kbd "C-c a i b") 'inf-elixir-send-buffer)
    (define-key elixir-ts-mode-map (kbd "C-c a i R") 'inf-elixir-reload-module)
    (define-key elixir-ts-mode-map (kbd "C-c a m t t") 'mix-test)
    (define-key elixir-ts-mode-map (kbd "C-c a m t .") 'mix-test-current-test)
    (define-key elixir-ts-mode-map (kbd "C-c a m t b") 'mix-test-current-buffer)
    (define-key elixir-ts-mode-map (kbd "C-c a m t r") 'mix-last-command)
    (define-key elixir-ts-mode-map (kbd "C-c a m r") 'mix-last-command)
    (define-key elixir-ts-mode-map (kbd "C-c a m x") 'mix-execute-task)
    (define-key elixir-ts-mode-map (kbd "C-c a h e") 'eldoc)
  )
)

(add-to-list 'major-mode-remap-alist '(elixir-mode . elixir-ts-mode))


;;; Clojure
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(require 'cider)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
(setq cider-auto-select-error-buffer nil)

;;; Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;; HTML web-mode
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

;;; Sass
(require 'sass-mode)

;;; CSS
(setq css-indent-offset 2)

;;  Python
(use-package python
  :hook ((python-ts-mode . lsp-deferred)
         (python-ts-mode . rainbow-delimiters-mode)
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
    (define-key python-ts-mode-map (kbd "C-c a v e a") 'pyvenv-activate)
  )
)

(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :hook (python-ts-mode . highlight-indent-guides-mode)
  :config
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  (setq highlight-indent-guides-method 'character))

;; Python-end

;; Julia
;; (use-package julia-ts-mode
;;   :ensure t
;;   :after (ls-mode)
;;   :hook ((julia-ts-mode . lsp-julia)
;; 	 (julia-ts-mode . company-mode)
;; 	 (julia-ts-mode . rainbow-delimiters-mode)
;; 	 (julia-ts-mode . flycheck-julia-setup)
;;          (before-save . lsp-format-buffer))
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-ts-mode)))

(add-to-list 'load-path "/home/rjspotter/.emacs.d/modes/julia-ts-mode/")
(require 'julia-mode)

;; (require 'julia-repl)
(use-package julia-snail
  :ensure t
  :custom
  (julia-snail-terminal-type :eat)
  :hook
  (julia-mode . julia-snail-mode))

(setq lsp-julia-package-dir nil)
(setq lsp-julia-flags `("-J/home/rjspotter/lib/julialanguageserver.so"))
(require 'lsp-julia)

(add-to-list 'lsp-language-id-configuration '(julia-mode . "julia"))
(lsp-register-client
(make-lsp-client :new-connection (lsp-stdio-connection 'lsp-julia--rls-command)
                :major-modes '(julia-mode ess-julia-mode julia-mode)
                :server-id 'julia-ls
                :multi-root t))

(add-hook 'julia-mode-hook
  (lambda ()
    (rainbow-delimiters-mode)
    (define-key julia-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key julia-mode-map (kbd "C-c a f b") 'lsp-format-buffer)
    (define-key julia-mode-map (kbd "C-c a f r") 'lsp-format-region)
    (define-key julia-mode-map (kbd "C-c a i b") 'julia-snail-send-buffer)
    (define-key julia-mode-map (kbd "C-c a i r") 'julia-snail-send-region)
    (define-key julia-mode-map (kbd "C-c a i l") 'julia-snail-send-line)
    (define-key julia-mode-map (kbd "C-c a i i") 'julia-snail)
    (define-key julia-mode-map (kbd "C-c a i p") 'julia-snail)
    (define-key julia-mode-map (kbd "C-c a h e") 'julia-snail-doc-lookup)
    (define-key julia-mode-map (kbd "C-c a v e a") 'julia-snail-package-activate)
    (define-key julia-mode-map (kbd "C-c a i R") 'julia-snail-update-module-cache)
  )
)
(setq julia-indent-offset 2)

;; (add-to-list 'major-mode-remap-alist '(julia-mode . julia-ts-mode))
;; Julia-end

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

;; (eval-after-load 'company
;;   '(push 'company-robe company-backends))


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
    (setq-default tab-width 2)
    (add-hook 'before-save-hook #'whitespace-cleanup)
    (define-key ruby-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key ruby-mode-map (kbd "C-c a i b") 'ruby-load-file)
    (define-key ruby-mode-map (kbd "C-c a i r") 'ruby-send-region)
    (define-key ruby-mode-map (kbd "C-c a i m") 'ruby-send-region-and-go)
    (define-key ruby-mode-map (kbd "C-c a i i") 'inf-ruby-console-auto)
    ;; (define-key ruby-mode-map (kbd "C-c a i p") 'inf-ruby-console-auto)
  )
)

(add-hook 'compilation-filter-hook 'inf-ruby-auto-enter)

;; Rust start
;;
;; Rustic for Rust
(use-package rustic
  :ensure t)

;; If having problems with the analyzer not starting install it with rustup
;; (setq rustic-analyzer-command '("~/.cargo/bin/rust-analyzer"))
;; (setq rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer"))

(defun rustic-mode-auto-save-hook ()
  "Enable auto-saving in rustic-mode buffers."
  (when buffer-file-name
    (setq-local compilation-ask-about-save nil)))

(add-hook 'rustic-mode-hook 'rustic-mode-auto-save-hook)

(add-hook 'rustic-mode-hook
  (lambda ()
    (rainbow-delimiters-mode)
    (define-key rustic-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key rustic-mode-map (kbd "C-c a f b") 'lsp-format-buffer)
    (define-key rustic-mode-map (kbd "C-c a f r") 'lsp-format-region)
    (define-key rustic-mode-map (kbd "C-c a f p") 'rustic-cargo-fmt)
    (define-key rustic-mode-map (kbd "C-c a c r") 'rustic-cargo-run)
    (define-key rustic-mode-map (kbd "C-c a c b") 'rustic-cargo-build)
    (define-key rustic-mode-map (kbd "C-c a c c") 'rustic-cargo-check)
    (define-key rustic-mode-map (kbd "C-c a c C") 'rustic-cargo-clean)
    (define-key rustic-mode-map (kbd "C-c a c f") 'rustic-cargo-fmt)
    (define-key rustic-mode-map (kbd "C-c a c l l") 'rustic-cargo-clippy)
    (define-key rustic-mode-map (kbd "C-c a c l f") 'rustic-cargo-clippy-fix)
    (define-key rustic-mode-map (kbd "C-c a c B") 'rustic-cargo-bench)
    (define-key rustic-mode-map (kbd "C-c a t t") 'rustic-cargo-test)
    (define-key rustic-mode-map (kbd "C-c a t .") 'rustic-cargo-current-test)
    (define-key rustic-mode-map (kbd "C-c a t r") 'rustic-cargo-test-rerun)
    (define-key rustic-mode-map (kbd "C-c a t f") 'lsp-rust-analyzer-related-tests)
    (define-key rustic-mode-map (kbd "C-c a p O") 'lsp-rust-analyzer-open-cargo-toml)
    (define-key rustic-mode-map (kbd "C-c a p n") 'rustic-cargo-new)
    (define-key rustic-mode-map (kbd "C-c a p o") 'rustic-cargo-outdated)
    (define-key rustic-mode-map (kbd "C-c a p u") 'rustic-cargo-upgrade)
    (define-key rustic-mode-map (kbd "C-c a p a") 'rustic-cargo-add)
    (define-key rustic-mode-map (kbd "C-c a p r") 'rustic-cargo-rm)
    (define-key rustic-mode-map (kbd "C-c a p d") 'rustic-cargo-doc)
    (define-key rustic-mode-map (kbd "C-c a p c") 'rustic-cargo-clean)
    (define-key rustic-mode-map (kbd "C-c a p i") 'rustic-cargo-init)
    (define-key rustic-mode-map (kbd "C-c a p T") 'rustic-cargo-tree)
    (define-key rustic-mode-map (kbd "C-c a e .") 'lsp-execute-code-action)
    (define-key rustic-mode-map (kbd "C-c a e r") 'lsp-rename)
    (define-key rustic-mode-map (kbd "C-c a h e") 'lsp-describe-thing-at-point)
    (define-key rustic-mode-map (kbd "C-c a h D") 'lsp-find-definition)
    (define-key rustic-mode-map (kbd "C-c a h T") 'lsp-find-type-definition)
    (define-key rustic-mode-map (kbd "C-c a h m") 'lsp-rust-analyzer-expand-macro)
    (define-key rustic-mode-map (kbd "C-c a h g") 'lsp-ui-doc-glance)
    (define-key rustic-mode-map (kbd "C-c a h s") 'lsp-ui-doc-show)
    (define-key rustic-mode-map (kbd "C-c a h x") 'lsp-ui-doc-hide)
    (define-key rustic-mode-map (kbd "C-c a h d") 'lsp-ui-peek-find-definitions)
    (define-key rustic-mode-map (kbd "C-c a h r") 'lsp-ui-peek-find-reference)
  )
)

(add-hook 'rustic-compilation-mode-hook
  (lambda ()
    (define-key rustic-compilation-mode-map (kbd "C-d") 'compilation-display-error)
    (define-key rustic-compilation-mode-map (kbd "C-o") 'other-window)
  )
)
;;; Rust end

;;; SQL start

;; Capitalize keywords in SQL mode
(add-hook 'sql-mode-hook 'sqlup-mode)
;; Capitalize keywords in an interactive session (e.g. psql)
(add-hook 'sql-interactive-mode-hook 'sqlup-mode)

;;(add-to-list 'sqlup-blacklist "public")
;;(add-to-list 'sqlup-blacklist "id")

;; sqlformat

(require 'sqlformat)
(setq sqlformat-command 'sqlfluff)
(setq sqlformat-args '("-n" "--ignore=templating" "--config=/home/rjspotter/.config/sqlfluff/setup.cfg"))
(add-hook 'sql-mode-hook 'sqlformat-on-save-mode)

;;; [try later] add jinja mode for dbt
;; (add-to-list 'auto-mode-alist '("\\.sql\\'" . sql-mode))
;; (mmm-add-mode-ext-class 'html-mode "\\.sql\\'" 'jinja2)

;; I haven't really found that LSP makes doing SQL better
;; (add-hook 'sql-mode-hook 'lsp)
;; (setq lsp-sql-server-path "/usr/bin/sql-language-server")
;; (setq lsp-sqls-server "/home/rjspotter/go/bin/sqls")
;; (setq lsp-sqls-workspace-config-path nil)

;; (add-hook 'sql-mode-hook 'sqlind-minor-mode)
;; (setq sql-indent-offset 4)

(add-hook 'sql-mode-hook
  (lambda ()
    (add-hook 'before-save-hook #'whitespace-cleanup)
    (define-key sql-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
    (define-key sql-mode-map (kbd "C-c a i r") 'sql-send-region)
    (define-key sql-mode-map (kbd "C-c a i m") 'sql-send-region-and-go)
    (define-key sql-mode-map (kbd "C-c a i b") 'sql-send-buffer)
    (define-key sql-mode-map (kbd "C-c a f b") 'sqlformat-buffer)
    (define-key sql-mode-map (kbd "C-c a f r") 'sqlformat-region)
    (define-key sql-mode-map (kbd "C-c a f s") 'sqlformat-on-save-mode)
  )
)

;;; SQL end

;;;;; Languages [End]

;;;;; Global Useful [Start]

(setq auto-save-file-name-transforms
  `((".*" ,(concat user-emacs-directory "auto-save/") t)))

(global-display-line-numbers-mode 1)

;; parens et al
(autoload 'rainbow-delimiters-mode "rainbow-delimiters" nil t)

(show-paren-mode 1)

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
(global-set-key "'" 'skeleton-pair-insert-maybe)

;; Terminals

(setq explicit-shell-file-name "/home/rjspotter/.cargo/bin/fish")

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
    (define-key eat-line-mode-map (kbd "C-o") 'other-window)
    (define-key eat-semi-char-mode-map (kbd "C-o") 'other-window)
    (define-key eat-char-mode-map (kbd "C-o") 'other-window)
  )
  )

;;stylin

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(require 'color-theme)

(setq x-select-enable-clipboard t)

;; indentation
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;; (setq-default indent-line-function 'insert-tab)

(delete-selection-mode 1)

(require 'whitespace)
(setq whitespace-style '(face empty trailing))
(global-whitespace-mode t)


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-z") 'goto-line)
(global-set-key (kbd "C-o") 'other-window)
;;(global-set-key (kbd "C-i") 'previous-multiframe-window)
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

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "/usr/bin/conkeror")

(defvar w/configs (make-hash-table :test #'equal)
  "This is a hash-table where window configurations used by w/save and w/load are stored.")

(defun w/save (key)
  "Save the current window configuration to w/configs."
  (interactive "sName for window configuration: ")
  (puthash key
           (window-state-get (frame-root-window) t)
           w/configs))

(defun w/load (key)
  "Load a named window configuration from w/configs."
  (interactive
   (let* ((completion-ignore-case t)
          (completions '())
          (nothing (maphash (lambda (k v) (push k completions)) w/configs)))
     (list (completing-read "Choose: " completions nil t))))
  (window-state-put (gethash key w/configs)))

(defun package-reinstall-all-activated-packages ()
  "Refresh and reinstall all activated packages."
  (interactive)
  (package-refresh-contents)
  (dolist (package-name package-activated-list)
    (when (package-installed-p package-name)
      (unless (ignore-errors                   ;some packages may fail to install
                (package-reinstall package-name))
        (warn "Package %s failed to reinstall" package-name)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2664eff0633db73cbcd5ef35070fc5901f4067861ee7a3e9cb4a7421bbbb0ce5" "030c9f5defbca9f2e09e15560b0994bec9a983c50c85fa89891a045ec3d7ce5c" "13718d1f34bf28b67653754a6c041087ce6e16be1ab0afb8e99ecae1d2e3b990" "fde89f5022d602613b17df04a8075fa8b39d42e3bad0d165401daefa59ed90c7" "80cc2866d01d4beeb62e7db06e1b3da3238dfa308dac6b84ca73104b41da4f0d" "64aa574bcf17bcb3991ba2ae2790a1e376751f1a78e93969b7999fafc7397788" "875a26098a8383b7077ed6b420f5f35c9d48ccea41ecf3029482d00fbe299705" "d8e14fb20c3b86f63b7815ca3fbe8cca2783c959efa5553c10b740af11fda8b1" "6804f0a43f217541d825911dffd8b9e8f6520744846976d5c6c3ad1f9f3c15ba" "563dd3ddad50e6887c9bc1aecf296cc3f2edce55537f0db48f719a70d3401131" "6f4c7ba06a17f53ce8fd24339558a320e255a135463f0b52820d2d64d07fa20b" "d6c896faa310e2c894f77c46cc083ae88b5da037d5ff1f06f850e330dcfc19bb" "a29b6383f0ab5550cb33b372b33006119f980fc369c6276a8f6de2ae14511b50" "964fd76d9adab895b54238794ef7e7036c1696bd8a44ed0093810cd467ec988d" "e03cb2cc566c46866bb355d691404cba3bf71d286426d9f142a0e7355b6bf3e6" "3d5f2fe54a9ab976d144f8d19bbc72b074c8a412a6cda0f9d691c37e4c53427c" "ca3b4f9009735476101aa08fcfb0872150810aa22e571d79e2b69193b61f1c86" "4528fb576178303ee89888e8126449341d463001cb38abe0015541eb798d8a23" "a8474a7e7e8951c5c111f80ac20de97139d44f20a8ed04254aa912a0edf501b2" "04731852318149f51dcf8ea7b1cafd20ff890d73ad7e585960a31d641d433893" "569db32037846cb93193d61c602eea9e6a4298ae3c4ee427cba2bcf14abeeef5" "dafd9d8d03e1068a05f98d77930e6cae260401fc9b93d1c03a5283b4db5ad26d" "fcc4badafd60fc0213472e655145fba70a7fa537db9f2aca80ec9edda221741d" "1414739793dd40e6cded535aaab7aa1f85577325312f3c4f7a294ac7464d7355" "32bf5c3ac67a48d910fbe94ccf3a8252b60f6ddf" "16c3a1560cc699bfc8ea13e9acba10045b02aa8d" "d66b5da4870d8838edbf984b1dc31e37efe1257b" "b5d3a19124561e92127c3bd917a6c2ae520c4c10" "c3adda001695657e6da90aa3268bbbf4f6af433b" "101b2a189997144931107b663cf1937ce94acd5a" "07c541895ec9b323bf25dc3c63a8a400dba6d2ca" "f67bc85632a7db951c45fbcdf55456b882f1ce32" "63baf5b4551d57e16ae558d40a0b27c426fbd880" "285a5928d414486528564472e49ce46db448e296" "9f3b064f42e48f3cce4ee007301453e37a871df5" "a71460243d93d271e33a969dd064a663022781d7" "f1ca2dfb5f86a53c386c18a8cc194474f4932a79" "0943252a540b205d7a7e492b33067c6740a0870a" default))
 '(package-selected-packages
   '(sql-clickhouse flymake-ruff ruff-format py-snippets yasnippet-capf yasnippet-snippets lsp-ui julia-snail eat julia-formatter lsp-julia pyenv-mode dap-mode sqlformat elixir-ts-mode heex-ts-mode inf-elixir mix highlight-indent-guides rg orderless marginalia vertico exec-path-from-shell rustic gnu-elpa-keyring-update sql-trino python-black python-pytest string-inflection jinja2-mode mmm-jinja2 mmm-mode company-ansible company-ctags company-fuzzy company-inf-ruby company-lsp company-nginx company-statistics company-terraform company-try-hard sparql-mode sql-impala google-translate sql-presto flycheck-soar format-sql helm-sql-connect hive pgdevenv sql-indent sqlup-mode docker docker-cli docker-compose-mode dockerfile-mode ein py-autopep8 elpy flycheck-pycheckers flycheck-pyflakes flycheck-pyre ammonite-term-repl ensime scala-mode scalariform fsharp-mode ng2-mode ess flycheck-julia julia-mode julia-repl julia-shell caml coffee-mode flycheck-ocaml haskell-mode haskell-snippets php-mode smarty-mode tuareg rubocop rubocopfmt rspec-mode foreman-mode fish-mode utop lusty-explorer merlin merlin-eldoc reason-mode eslint-fix indium handlebars-mode handlebars-sgml-mode prettier-js helm-rg projectile-ripgrep ripgrep slim-mode minitest projectile robe helm-projectile helm-rails helm-rb helm-rubygems-local flycheck-clojure flycheck-credo flycheck-dialyxir flycheck-elixir flycheck-haskell flycheck-mix flycheck-yamllint yaml-mode tide ts-comint typescript-mode js2-mode graphql-mode magit json-mode inf-ruby multi-term mustache-mode rainbow-delimiters sass-mode yasnippet alchemist elm-mode elm-yasnippets web-mode flycheck cider clojure-mode clojure-snippets smartparens react-snippets markdown-mode+ javap-mode helm eval-sexp-fu elixir-yasnippets elixir-mode el-autoyas datomic-snippets company cil-mode autopair auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Auto load rjspotter-new theme in terminal mode
(add-hook 'after-init-hook (lambda () (load-theme 'rjspotter-new)))
