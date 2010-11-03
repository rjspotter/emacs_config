

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

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/modes/")

(autoload 'mode-compile "mode-compile"
      "Command to compile current buffer file based on the major mode" t)

(require 'lusty-explorer)
(global-set-key (kbd "C-x C-f") 'lusty-file-explorer)
(global-set-key (kbd "C-x b")   'lusty-buffer-explorer)

(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)

(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)

(autoload 'company-mode "company" nil t)

(add-to-list 'load-path "~/.emacs.d/modes/mustache-mode.el")
(require 'mustache-mode)

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

(require 'linum)
(global-linum-mode 1)
(setq linum-format " %d ")

(require 'autotest)
(require 'toggle)

;(setq tags-table-list (list "./" "./../" "./../../" "./../../../" "./../../../" "/home/rjspotter/.bundle/ruby/1.8/gems" "/usr/local/lib/ruby/gems/1.8/gems/"))

;;stylin
(require 'color-theme)

(defun color-theme-rjspotter-green ()
  "dark green theme created by rjspotter, june, 2010."
  (interactive)
  (color-theme-install
    '(color-theme-rjspotter-green
       ((foreground-color . "#bdddbd")
         (background-color . "#0d170d")
         (background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))
       
       (font-lock-builtin-face ((t (:foreground "#068876"))))
       (font-lock-comment-face ((t (:foreground "#999999"))))
       (font-lock-comment-delimiter-face ((t (:foreground "#888888"))))
       (font-lock-constant-face ((t (:foreground "#797e07"))))
       (font-lock-doc-string-face ((t (:foreground "#880b88"))))
       (font-lock-doc-face ((t (:foreground "#8968cd"))))
       (font-lock-reference-face ((t (:foreground "#864b06"))))
       (font-lock-function-name-face ((t (:foreground "#064b87"))))
       (font-lock-keyword-face ((t (:foreground "#79cdcd"))))
       (font-lock-preprocessor-face ((t (:foreground "#488f06"))))
       (font-lock-string-face ((t (:foreground "#ad5dc7"))))
       (font-lock-type-face ((t (:bold t :foreground "#870b46"))))
       (font-lock-variable-name-face ((t (:foreground "#488f06"))))
       (font-lock-warning-face ((t (:foreground "#850b06"))))
       (hl-line ((t (:background "#111111"))))
       (mode-line ((t (:foreground "#ffffff" :background "#111111"))))
       (region ((t (:foreground nil :background "#223344"))))
       (show-paren-match-face ((t (:foreground "#7fff00"))))
    )
  )
)


(cond ((string= window-system "x")(color-theme-rjspotter-green)))

;(cua-mode t)
;    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;    (transient-mark-mode 1) ;; No region when it is not highlighted
;    (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
;(cua-mode nil)

(setq x-select-enable-clipboard t)
(global-set-key (kbd "C-w") 'copy-region-as-kill)
(global-set-key (kbd "M-w") 'kill-region)

(show-paren-mode 1)
(setq-default c-basic-offset 2)
(setq-default indent-tabs-mode nil)
(delete-selection-mode 1)

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
(global-set-key (kbd "C-d") 'duplicate-line)

(add-hook 'rinari-minor-mode-hook
  (lambda () (define-key ruby-mode-map "\C-t" 'toggle-window))
)

(add-hook 'ruby-mode-hook
  (lambda ()
    (define-key ruby-mode-map (kbd "C-c C-c") 'comment-or-uncomment-region)
  )
)

