;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; ---------------------------
;;
;; rjspotter-matrix-theme
;;
;; ----------------------------

(unless (>= emacs-major-version 24)
  (error "requires Emacs 24 or later."))

(deftheme rjspotter-matrix "Black & Green theme for Emacs.")

(let (
      ;; match ghostty theme
      (base-bg         "#000000")
      (base-bg-br      "#333333")
      (base-fg         "#efefef")
      (base-fg-br      "#ffffff")
      (base-cursor-fg  "#384545")
      (base-cursor-bg  "#00ff00")
      (base-black      "#aaaaaa") ;; 0
      (base-black-br   "#688060") ;; 8
      (base-red        "#23755a") ;; 1
      (base-red-br     "#2fc079") ;; 9
      (base-green      "#82d967") ;; 2
      (base-green-br   "#90d762") ;; 10
      (base-yellow     "#ffd700") ;; 3
      (base-yellow-br  "#faff00") ;; 11
      (base-blue       "#6f8272") ;; 4
      (base-blue-br    "#4f7e7e") ;; 12
      (base-magenta    "#409931") ;; 5
      (base-magenta-br "#11ff25") ;; 13
      (base-cyan       "#50b45a") ;; 6
      (base-cyan-br    "#c1ff8a") ;; 14
      (base-white      "#507350") ;; 7
      (base-white-br   "#678c61") ;; 15

      ;; ghostty default dark bright colors

      (ghostty-black   "#666666")
      (ghostty-red     "#c55757")
      (ghostty-green   "#bcc95f")
      (ghostty-yellow  "#e1c65e")
      (ghostty-blue    "#83a5d6")
      (ghostty-magenta "#bc99d4")
      (ghostty-cyan    "#83beb1")
      (ghostty-white   "#eaeaea")


      (*background*         "#000000")
      (*comments*           "#aaaaaa")
      (*constant*           "#008080")
      (*current-line*       "#90d762")
      (*cursor-underscore*  "#4f7e7e")
      (*keywords*           "#6f8272")
      (*line-number*        "#aaaaaa")
      (*method-declaration* "#6f8272")
      (*mode-line-bg*       "#333333")
      (*mode-inactive-bg*   "#555555")
      (*mode-line-fg*       "#688060")
      (*normal*             "#efefef")
      (*number*             "#50b45a")
      (*operators*          "#678c61")
      (*warning*            "#ffd700")
      (*regexp*             "#11ff25")
      (*string*             "#90d762")
      (*variable*           "#23755a")
      (*visual-selection*   "#333333")
      (*header-line-bg*     "#678c61"))

  (custom-theme-set-faces
   'rjspotter-matrix

   `(bold ((t (:bold t))))
   `(button ((t (:foreground, *keywords* :underline t))))
   `(default ((t (:background, *background* :foreground, *normal*))))
   ;; Colour of header lines in Proced, info, Buffer list etc...
   `(header-line ((t (:background, *header-line-bg* :foreground, *background*))))
   `(highlight ((t (:background, *current-line*))))
   `(highlight-face ((t (:background, *current-line*))))
   `(hl-line ((t (:background, *current-line* :underline t))))
   `(info-xref ((t (:foreground, *keywords* :underline t))))
   `(region ((t (:background, *visual-selection*))))
   `(underline ((nil (:underline t))))

   ;; font-lock
   `(font-lock-builtin-face ((t (:foreground, *operators*))))
   `(font-lock-comment-delimiter-face ((t (:foreground, *comments*))))
   `(font-lock-comment-face ((t (:foreground, *comments*))))
   `(font-lock-constant-face ((t (:foreground, *constant*))))
   `(font-lock-doc-face ((t (:foreground, *string*))))
   `(font-lock-doc-string-face ((t (:foreground, *string*))))
   `(font-lock-function-name-face ((t (:foreground, *method-declaration*))))
   `(font-lock-keyword-face ((t (:foreground, *keywords*))))
   `(font-lock-negation-char-face ((t (:foreground, *warning*))))
   `(font-lock-number-face ((t (:foreground, *number*))))
   `(font-lock-preprocessor-face ((t (:foreground, *keywords*))))
   `(font-lock-reference-face ((t (:foreground, *constant*))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground, *regexp*))))
   `(font-lock-regexp-grouping-construct ((t (:foreground, *regexp*))))
   `(font-lock-string-face ((t (:foreground, *string*))))
   `(font-lock-type-face ((t (:foreground, *operators*))))
   `(font-lock-variable-name-face ((t (:foreground, *variable*))))
   `(font-lock-warning-face ((t (:foreground, *warning*))))

   ;; GUI
   `(fringe ((t (:background, *background*))))
   `(linum ((t (:background, *line-number*))))
   `(minibuffer-prompt ((t (:foreground, *variable*))))
   `(mode-line ((t (:background, *mode-line-bg* :foreground, *mode-line-fg*))))
   `(mode-line-inactive ((t (:background, *mode-inactive-bg* :foreground, *background*))))
   `(cursor ((t (:background, *cursor-underscore*))))
   `(text-cursor ((t (:background, *cursor-underscore*))))
   `(vertical-border ((t (:foreground, *background*)))) ;; between splits

   ;; show-paren
   `(show-paren-mismatch ((t (:background, *warning* :foreground, *normal* :weight bold))))
   `(show-paren-match ((t (:background, *keywords* :foreground, *normal* :weight bold))))

   ;; search
   `(isearch ((t (:background, *header-line-bg* :foreground, *background*))))
   `(isearch-fail ((t (:background, *warning*))))
   `(lazy-highlight ((t (:background, *operators* :foreground, *visual-selection*))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground, base-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground, ghostty-green))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground, ghostty-magenta))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground, ghostty-yellow))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground, ghostty-cyan))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground, ghostty-red))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground, ghostty-blue))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground, base-fg))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground, ghostty-green))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground, ghostty-magenta))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground, ghostty-yellow))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground, ghostty-red))))

   ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'rjspotter-matrix)

;; Local Variables:
;; no-byte-compile: t
;; End:
