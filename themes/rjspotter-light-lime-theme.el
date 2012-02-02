;;; rjspotter-light-lime-theme.el --- Custom face theme for Emacs

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

(deftheme rjspotter-light-lime
  "")

(custom-theme-set-faces
 'rjspotter-light-lime
 '(default ((t (:background "#eeeeee" :foreground "#333333"))))
 '(cursor ((t (:background "#eeeeee" :foreground "#22ee22"))))
 '(region ((t (:background "#999999" :foreground "#222222"))))
 '(mode-line ((t (:background "#aaaaaa" :foreground "#229922"))))
 '(mode-line-inactive ((t (:background "#dddddd" :foreground "#333333"))))
 '(fringe ((t (:background "#dddddd"))))
 '(minibuffer-prompt ((t (:background "#eeeeee" :foreground "#22aa22"))))
 '(font-lock-builtin-face ((t (:background "#eeeeee" :foreground "#229922"))))
 '(font-lock-comment-face ((t (:foreground "#aaaaaa"))))
 '(font-lock-constant-face ((t (:foreground "#22bb22"))))
 '(font-lock-function-name-face ((t (:foreground "#22bb22"))))
 '(font-lock-keyword-face ((t (:foreground "#22ee22"))))
 '(font-lock-string-face ((t (:foreground "#226622"))))
 '(font-lock-type-face ((t (:foreground "#228822"))))
 '(font-lock-variable-name-face ((t (:foreground "#44cc44"))))
 '(font-lock-warning-face ((t (:foreground "#882222"))))
 '(isearch ((t (:background "#eeeeee" :foreground "#226622"))))
 '(lazy-highlight ((t (:background "#aaaaaa"))))
 '(link ((t (:foreground "#44cccc" :underline t))))
 '(link-visited ((t (:foreground "#44aaaa" :underline t))))
 '(button ((t (:underline t))))
 '(header-line ((t (:background "#dddddd" :foreground "#222222")))))

(provide-theme 'rjspotter-light-lime)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; rjspotter-light-lime-theme.el  ends here
