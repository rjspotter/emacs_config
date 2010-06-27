(add-to-list 'load-path "~/.emacs.d/modes/")
(autoload 'company-mode "company" nil t)

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'sass-mode)
;;(require 'smarty-mode)

(require 'linum)
(global-linum-mode 1)
(setq linum-format " %d ")

;;stylin
(require 'color-theme)
(defun color-theme-rjspotter ()
  "dark color theme created by rjspotter, Mar, 2010."
  (interactive)
  (color-theme-install
    '(color-theme-rjspotter
       ((foreground-color . "#bfbfbf")
         (background-color . "#313634") 
         (background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))
       
       (font-lock-builtin-face ((t (:foreground "#d3d649"))))
       (font-lock-comment-face ((t (:foreground "#999999"))))
       (font-lock-comment-delimiter-face ((t (:foreground "#666666"))))
       (font-lock-constant-face ((t (:foreground "#00bfff"))))
       (font-lock-doc-string-face ((t (:foreground "#8968cd"))))
       (font-lock-doc-face ((t (:foreground "#8968cd"))))
       (font-lock-reference-face ((t (:foreground "#48d1cc"))))
       (font-lock-function-name-face ((t (:foreground "#9acd32"))))
       (font-lock-keyword-face ((t (:foreground "#79cdcd"))))
       (font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
       (font-lock-string-face ((t (:foreground "#9f79ee"))))
       (font-lock-type-face ((t (:foreground "#74adb0"))))
       (font-lock-variable-name-face ((t (:foreground "#9bcd9b"))))
       (font-lock-warning-face ((t (:foreground "#b22222"))))
       (hl-line ((t (:background "#111111"))))
       (mode-line ((t (:foreground "#ffffff" :background "#111111"))))
       (region ((t (:foreground nil :background "#555555"))))
       (show-paren-match-face ((t (:foreground "#7fff00"))))
    )
  )
)

(defun color-theme-rjspotter-green ()
  "dark green theme created by rjspotter, june, 2010."
  (interactive)
  (color-theme-install
    '(color-theme-rjspotter-green
       ((foreground-color . "#799979")
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


(color-theme-rjspotter-green)

(cua-mode t)
    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
    (transient-mark-mode 1) ;; No region when it is not highlighted
    (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

(show-paren-mode 1)

(setq-default c-basic-offset 2)

(setq-default indent-tabs-mode nil)

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

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
