
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

(set-default 'autopair-dont-activate #'(lambda () (eq major-mode 'sldb-mode)))
;;(add-hook 'sldb-mode-hook #'(lambda () (setq autopair-dont-activate t)))

(setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
(add-to-list 'load-path "~/.emacs.d/modes/slime/")  ; your SLIME directory
(require 'slime)
(slime-setup)

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
(require 'color-theme)

(defun color-theme-rjspotter-green ()
  "dark green theme created by rjspotter, june, 2010.  updated Dec, 2011"
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
       (font-lock-function-name-face ((t (:foreground "#367bb7"))))
       (font-lock-keyword-face ((t (:foreground "#79cdcd"))))
       (font-lock-preprocessor-face ((t (:foreground "#488f06"))))
       (font-lock-string-face ((t (:foreground "#ad5dc7"))))
       (font-lock-type-face ((t (:bold t :foreground "#a72b66"))))
       (font-lock-variable-name-face ((t (:foreground "#488f06"))))
       (font-lock-warning-face ((t (:foreground "#850b06"))))
       (hl-line ((t (:background "#111111"))))
       (mode-line ((t (:foreground "#eeeeee" :background "#111111"))))
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
;(global-set-key (kbd "C-w") 'copy-region-as-kill)
;(global-set-key (kbd "M-w") 'kill-region)

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
;;(global-set-key (kbd "C-o") 'duplicate-line)

(global-set-key (kbd "C-d") 'backward-char)

(global-set-key (kbd "C-z") 'goto-line)

(global-set-key (kbd "C-b") 'lusty-buffer-explorer)

(global-set-key (kbd "C-o") 'other-window)

(global-set-key (kbd "C-k") 'kill-buffer)

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
(set-default-font "-*-white rabbit-normal-normal-normal-*-14-*-*-*-*-100-iso10646-1")
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
