;;; julia-shell-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "julia-shell" "julia-shell.el" (23521 813 343499
;;;;;;  871000))
;;; Generated autoloads from julia-shell.el

(autoload 'inferior-julia-shell "julia-shell" "\
Run an inferior instance of `julia' inside Emacs.

\(fn)" t nil)

(defalias 'run-julia #'inferior-julia-shell "\
Run an inferior instance of `julia' inside Emacs.")

;;;***

;;;### (autoloads nil nil ("julia-shell-pkg.el") (23521 813 287501
;;;;;;  579000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; julia-shell-autoloads.el ends here
