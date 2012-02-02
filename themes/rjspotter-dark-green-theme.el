;;; rjspotter-dark-green-theme.el --- Custom face theme for Emacs

;; Copyright (C) 2010 rjspotter-dark-lime.

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(deftheme rjspotter-dark-green
  "")

(custom-theme-set-faces
 'rjspotter-dark-green
 '(default ((t (:background "#0d170d" :foreground "#bdddbd"))))
 '(cursor ((t (:background "#000000" :foreground "#eeeeee"))))
 '(font-lock-builtin-face ((t (:foreground "#068876"))))
 '(font-lock-comment-face ((t (:foreground "#999999"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#888888"))))
 '(font-lock-constant-face ((t (:foreground "#797e07"))))
 '(font-lock-doc-string-face ((t (:foreground "#880b88"))))
 '(font-lock-doc-face ((t (:foreground "#8968cd"))))
 '(font-lock-reference-face ((t (:foreground "#864b06"))))
 '(font-lock-function-name-face ((t (:foreground "#367bb7"))))
 '(font-lock-keyword-face ((t (:foreground "#79cdcd"))))
 '(font-lock-preprocessor-face ((t (:foreground "#488f06"))))
 '(font-lock-string-face ((t (:foreground "#ad5dc7"))))
 '(font-lock-type-face ((t (:bold t :foreground "#a72b66"))))
 '(font-lock-variable-name-face ((t (:foreground "#488f06"))))
 '(font-lock-warning-face ((t (:foreground "#850b06"))))
 '(hl-line ((t (:background "#111111"))))
 '(mode-line ((t (:foreground "#eeeeee" :background "#111111"))))
 '(region ((t (:foreground nil :background "#223344"))))
 '(show-paren-match-face ((t (:foreground "#7fff00")))))

(provide-theme 'rjspotter-dark-green)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; rjspotter-dark-green-theme.el  ends here
