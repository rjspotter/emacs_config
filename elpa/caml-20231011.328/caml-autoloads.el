;;; caml-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "caml" "caml.el" (0 0 0 0))
;;; Generated autoloads from caml.el

(autoload 'caml-mode "caml" "\
Major mode for editing OCaml code.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "caml" '("caml-")))

;;;***

;;;### (autoloads nil "caml-font" "caml-font.el" (0 0 0 0))
;;; Generated autoloads from caml-font.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "caml-font" '("inferior-caml-" "caml-font-")))

;;;***

;;;### (autoloads nil "caml-font-old" "caml-font-old.el" (0 0 0 0))
;;; Generated autoloads from caml-font-old.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "caml-font-old" '("inferior-caml-" "caml-" "Stop")))

;;;***

;;;### (autoloads nil "caml-help" "caml-help.el" (0 0 0 0))
;;; Generated autoloads from caml-help.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "caml-help" '("ocaml-" "caml-")))

;;;***

;;;### (autoloads nil "caml-types" "caml-types.el" (0 0 0 0))
;;; Generated autoloads from caml-types.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "caml-types" '("caml-")))

;;;***

;;;### (autoloads nil "camldebug" "camldebug.el" (0 0 0 0))
;;; Generated autoloads from camldebug.el

(defvar camldebug-command-name "ocamldebug" "\
*Pathname for executing camldebug.")

(autoload 'camldebug "camldebug" "\
Run camldebug on program FILE in buffer *camldebug-FILE*.
The directory containing FILE becomes the initial working directory
and source-file directory for camldebug.  If you wish to change this, use
the camldebug commands `cd DIR' and `directory'.

\(fn FILE)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "camldebug" '("current-camldebug-buffer" "camldebug-" "def-camldebug")))

;;;***

;;;### (autoloads nil "inf-caml" "inf-caml.el" (0 0 0 0))
;;; Generated autoloads from inf-caml.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "inf-caml" '("caml-" "inferior-caml-" "run-caml")))

;;;***

;;;### (autoloads nil nil ("caml-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; caml-autoloads.el ends here
