;;; datomic-snippets-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "datomic-snippets" "datomic-snippets.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from datomic-snippets.el

(autoload 'datomic-snippets-show-docs-at-point "datomic-snippets" "\


\(fn)" t nil)

(autoload 'datomic-snippets-initialize "datomic-snippets" "\


\(fn)" nil nil)

(eval-after-load "yasnippet" '(datomic-snippets-initialize))

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "datomic-snippets" '("datomic-snippets/" "-aget")))

;;;***

;;;### (autoloads nil nil ("datomic-snippets-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; datomic-snippets-autoloads.el ends here
