;;; sql-presto-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "sql-presto" "sql-presto.el" (0 0 0 0))
;;; Generated autoloads from sql-presto.el

(autoload 'sql-presto "sql-presto" "\
Run Presto as an inferior process.

The buffer with name BUFFER will be used or created.

\(fn &optional BUFFER)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sql-presto" '("sql-presto-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; sql-presto-autoloads.el ends here
