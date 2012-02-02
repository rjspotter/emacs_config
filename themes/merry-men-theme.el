;;; merry-men-theme.el --- Custom face theme for Emacs

;; Copyright (C) 2010 Mario Lassnig.

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

(deftheme merry-men
  "A calm forest for the weary.")

(custom-theme-set-faces
 'merry-men
 '(default ((t (:background "#304020" :foreground "#ffdead"))))
 '(cursor ((t (:background "#000000" :foreground "#ffdead"))))
 '(region ((t (:background "#707777" :foreground "#ffdead"))))
 '(mode-line ((t (:background "#556b2f" :foreground "#f5deb3"))))
 '(mode-line-inactive ((t (:background "#556b2f" :foreground "#bdab8a"))))
 '(fringe ((t (:background "#003300"))))
 '(minibuffer-prompt ((t (:foreground "#98fb98"))))
 '(font-lock-builtin-face ((t (:foreground "#e68e1c"))))
 '(font-lock-comment-face ((t (:foreground "#aaaa77"))))
 '(font-lock-constant-face ((t (:foreground "#e67d40"))))
 '(font-lock-function-name-face ((t (:foreground "#e6a06a"))))
 '(font-lock-keyword-face ((t (:foreground "#97fb5d"))))
 '(font-lock-string-face ((t (:foreground "#e6a06a"))))
 '(font-lock-type-face ((t (:foreground "#e66423"))))
 '(font-lock-variable-name-face ((t (:foreground "#85e6d6"))))
 '(font-lock-warning-face ((t (:foreground "#ff0000"))))
 '(isearch ((t (:background "#ff0000"))))
 '(lazy-highlight ((t (:background "#597d6e" :foreground "#ff0000"))))
 '(link ((t (:foreground "#ccb28a" :underline t))))
 '(link-visited ((t (:foreground "#ccb28a" :underline t))))
 '(button ((t (:foreground "#98fb98" :weight bold))))
 '(header-line ((t (:background "#003300" :foreground "#aaaa77")))))

(provide-theme 'merry-men)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; merry-men-theme.el  ends here
