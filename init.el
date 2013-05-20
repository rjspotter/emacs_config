
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
(tool-bar-mode -1)
(set-default-font "-*-white rabbit-normal-normal-normal-*-14-*-*-*-*-120-iso10646-1")
(modify-frame-parameters nil '((wait-for-wm . nil)))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/modes/")

(autoload 'mode-compile "mode-compile"
      "Command to compile current buffer file based on the major mode" t)

(require 'lusty-explorer)
(global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
(global-set-key (kbd "C-x C-b")   'lusty-buffer-explorer)

(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)


;; Hippie expand stuff
(require 'cc-mode)
(require 'etags-table)

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
                          try-expand-tag) t))
;; end hippie expand stuff

(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

(set-default 'autopair-dont-activate #'(lambda () (eq major-mode 'sldb-mode)))
;;(add-hook 'sldb-mode-hook #'(lambda () (setq autopair-dont-activate t)))

(require 'info-look)
(info-lookup-add-help
 :mode 'lisp-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))

;(load (expand-file-name "~/quicklisp/slime-helper.el"))

;(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
;(add-to-list 'load-path "~/.emacs.d/modes/slime/")  ; your SLIME directory
(require 'slime)
(slime-setup)

(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

(add-to-list 'auto-mode-alist '("\\.ml[iylp]?" . tuareg-mode))
  (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
  (autoload 'camldebug "camldebug" "Run the Caml debugger" t)

(autoload 'company-mode "company" nil t)

(require 'puppet-mode)
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

(add-to-list 'load-path "~/.emacs.d/modes/mustache-mode.el")
(require 'mustache-mode)
(add-to-list 'auto-mode-alist '("\\.mustache$" . tpl-mode))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-bounce-indent-p t)
(setq js2-mirror-mode nil)

(add-to-list 'load-path "~/.emacs.d/modes/coffee-mode")
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (set (make-local-variable 'tab-width) 2)

  (setq coffee-debug-mode t)

  (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)

  (add-hook 'after-save-hook
    '(lambda ()
      (when (string-match "\.coffee$" (buffer-name))
        (coffee-compile-file))))
)
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(load "~/.emacs.d/modes/haskell-mode/haskell-site-file")
 (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
 (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)    

(require 'sass-mode)

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

(require 'linum)
(global-linum-mode 1)
(setq linum-format " %d ")

(require 'autotest)
(require 'toggle)

(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)

(setq multi-term-program "/bin/bash")   ;; use bash
;; (setq multi-term-program "/bin/zsh") ;; or use zsh...

;; only needed if you use autopair
;(add-hook 'term-mode-hook
;  #'(lambda () (setq autopair-dont-activate t)))


(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

;(setq tags-table-list (list "./" "./../" "./../../" "./../../../" "./../../../" "/home/rjspotter/.bundle/ruby/1.8/gems" "/usr/local/lib/ruby/gems/1.8/gems/"))

;;stylin

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(require 'color-theme)

;(cua-mode t)
;    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;    (transient-mark-mode 1) ;; No region when it is not highlighted
;    (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
;(cua-mode nil)

(setq x-select-enable-clipboard t)
;(global-set-key (kbd "C-w") 'copy-region-as-kill)
;(global-set-key (kbd "M-w") 'kill-region)

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
;;(global-set-key (kbd "C-o") 'duplicate-line)

;;(global-set-key (kbd "C-d") 'backward-char)

(global-set-key (kbd "C-z") 'goto-line)

;;(global-set-key (kbd "C-b") 'lusty-buffer-explorer)

(global-set-key (kbd "C-o") 'other-window)

(global-set-key (kbd "C-k") 'kill-buffer)

(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(autoload 'inf-ruby-keys "inf-ruby" "" t) 
(eval-after-load 'ruby-mode '(add-hook 'ruby-mode-hook 'inf-ruby-keys))

(add-hook 'rinari-minor-mode-hook
  (lambda () (define-key ruby-mode-map "\C-t" 'toggle-window))
)

(add-hook 'ruby-mode-hook
  (lambda ()
    (define-key ruby-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
  )
)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("dafd9d8d03e1068a05f98d77930e6cae260401fc9b93d1c03a5283b4db5ad26d" "fcc4badafd60fc0213472e655145fba70a7fa537db9f2aca80ec9edda221741d" "1414739793dd40e6cded535aaab7aa1f85577325312f3c4f7a294ac7464d7355" "32bf5c3ac67a48d910fbe94ccf3a8252b60f6ddf" "16c3a1560cc699bfc8ea13e9acba10045b02aa8d" "d66b5da4870d8838edbf984b1dc31e37efe1257b" "b5d3a19124561e92127c3bd917a6c2ae520c4c10" "c3adda001695657e6da90aa3268bbbf4f6af433b" "101b2a189997144931107b663cf1937ce94acd5a" "07c541895ec9b323bf25dc3c63a8a400dba6d2ca" "f67bc85632a7db951c45fbcdf55456b882f1ce32" "63baf5b4551d57e16ae558d40a0b27c426fbd880" "285a5928d414486528564472e49ce46db448e296" "9f3b064f42e48f3cce4ee007301453e37a871df5" "a71460243d93d271e33a969dd064a663022781d7" "f1ca2dfb5f86a53c386c18a8cc194474f4932a79" "0943252a540b205d7a7e492b33067c6740a0870a" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
