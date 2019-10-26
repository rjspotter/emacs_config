;;; scalariform-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "scalariform" "scalariform.el" (0 0 0 0))
;;; Generated autoloads from scalariform.el

(autoload 'scalariform-format-region "scalariform" "\
Format the region.
Argument START: region to start.
Argument END: region to end.

\(fn START END)" t nil)

(autoload 'scalariform-format-region-or-buffer "scalariform" "\
Format the region or buffer.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "scalariform" '("scalariform-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; scalariform-autoloads.el ends here
