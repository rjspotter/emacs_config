;;; cil-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "cil-mode" "cil-mode.el" (0 0 0 0))
;;; Generated autoloads from cil-mode.el

(add-to-list 'auto-mode-alist '("\\.il\\'" . cil-mode))

(autoload 'cil-mode "cil-mode" "\
Major mode for editing Common Intermediate Language files

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cil-mode" '("cil-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cil-mode-autoloads.el ends here
