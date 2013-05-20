;;; rjspotter-dark-lime-theme.el --- Custom face theme for Emacs

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

(deftheme rjspotter-dark-lime
  "")

(custom-theme-set-faces
 'rjspotter-dark-lime
 '(default ((t (:background "#222222" :foreground "#eeeeee"))))
 '(cursor ((t (:background "#222222" :foreground "#22ee22"))))
 '(region ((t (:background "#444444" :foreground "#eeeeee"))))
 '(mode-line ((t (:background "#111111" :foreground "#229922"))))
 '(mode-line-inactive ((t (:background "#111111" :foreground "#dddddd"))))
 '(fringe ((t (:background "#111111"))))
 '(minibuffer-prompt ((t (:background "#222222" :foreground "#22aa22"))))
 '(font-lock-builtin-face ((t (:background "#222222" :foreground "#22ff22"))))
 '(font-lock-comment-face ((t (:foreground "#aaaaaa"))))
 '(font-lock-constant-face ((t (:foreground "#22bb22"))))
 '(font-lock-function-name-face ((t (:foreground "#22ff22"))))
 '(font-lock-keyword-face ((t (:foreground "#22ee22"))))
 '(font-lock-string-face ((t (:foreground "#22af22"))))
 '(font-lock-type-face ((t (:foreground "#228822"))))
 '(font-lock-variable-name-face ((t (:foreground "#ffffff"))))
 '(font-lock-warning-face ((t (:foreground "#882255"))))
 '(isearch ((t (:background "#eeeeee" :foreground "#226622"))))
 '(lazy-highlight ((t (:background "#555555"))))
 '(link ((t (:foreground "#229999" :underline t))))
 '(link-visited ((t (:foreground "#22aaaa" :underline t))))
 '(button ((t (:underline t))))
 '(header-line ((t (:background "#444444" :foreground "#dddddd")))))

(provide-theme 'rjspotter-dark-lime)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; rjspotter-dark-lime-theme.el  ends here
