;;; robe-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "robe" "robe.el" (0 0 0 0))
;;; Generated autoloads from robe.el

(autoload 'company-robe "robe" "\
A `company-mode' completion back-end for `robe-mode'.

\(fn COMMAND &optional ARG &rest IGNORE)" t nil)

(autoload 'robe-mode "robe" "\
Improved navigation for Ruby.

The following commands are available:

\\{robe-mode-map}

\(fn &optional ARG)" t nil)

(defvar global-robe-mode nil "\
Non-nil if Global Robe mode is enabled.
See the `global-robe-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-robe-mode'.")

(custom-autoload 'global-robe-mode "robe" nil)

(autoload 'global-robe-mode "robe" "\
Toggle Robe mode in all buffers.
With prefix ARG, enable Global Robe mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Robe mode is enabled in all buffers where
`robe-mode-on' would do it.
See `robe-mode' for more information on Robe mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "robe" '("robe-" "company-robe--prefix")))

;;;***

;;;### (autoloads nil nil ("robe-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; robe-autoloads.el ends here
