;;; merlin-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "merlin" "merlin.el" (23981 1412 530337 896000))
;;; Generated autoloads from merlin.el

(autoload 'merlin-mode "merlin" "\
Minor mode for interacting with a merlin process.
Runs a merlin process in the background and perform queries on it.

Short cuts:
\\{merlin-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "merlin-company" "merlin-company.el" (23981
;;;;;;  1412 542337 538000))
;;; Generated autoloads from merlin-company.el

(autoload 'merlin-company-backend "merlin-company" "\


\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

;;;***

;;;### (autoloads nil "merlin-imenu" "merlin-imenu.el" (23981 1412
;;;;;;  518338 257000))
;;; Generated autoloads from merlin-imenu.el

(autoload 'merlin-use-merlin-imenu "merlin-imenu" "\
Merlin: use the custom imenu feature from Merlin

\(fn)" t nil)

;;;***

;;;### (autoloads nil "merlin-xref" "merlin-xref.el" (23981 1412
;;;;;;  498338 855000))
;;; Generated autoloads from merlin-xref.el

(autoload 'merlin-xref-backend "merlin-xref" "\
Merlin backend for Xref.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("merlin-ac.el" "merlin-cap.el" "merlin-iedit.el"
;;;;;;  "merlin-pkg.el") (23981 1412 546337 417000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; merlin-autoloads.el ends here
