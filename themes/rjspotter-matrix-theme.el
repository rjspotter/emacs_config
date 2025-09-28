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
      (base-bg         "#010101")
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


      (*background*         "#010101")
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
   `(link ((t (:foreground, base-red-br :underline t))))
   `(button ((t (:foreground, *keywords* :underline t))))
   `(default ((t (:foreground, *normal*))))
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
   `(mode-line-inactive ((t (:background, *mode-inactive-bg* :foreground, base-bg))))
   `(cursor ((t (:background, *cursor-underscore*))))
   `(text-cursor ((t (:background, *cursor-underscore* :foreground, base-bg))))
   `(vertical-border ((t (:foreground, base-bg-br)))) ;; between splits

   ;; show-paren
   `(show-paren-mismatch ((t (:background, *warning* :foreground, *normal* :weight bold))))
   `(show-paren-match ((t (:background, *keywords* :foreground, *normal* :weight bold))))

   ;; search
   `(isearch ((t (:background, *normal* :foreground, *regexp*))))
   `(isearch-fail ((t (:background, *warning* :foreground, base-bg))))
   `(lazy-highlight ((t (:background, base-black :foreground, base-magenta-br))))

   ;; company-mode
   `(company-tooltip ((t (:foreground, base-fg :background, base-bg-br))))
   `(company-tooltip-annotation ((t (:foreground, base-white-br :background, base-bg-br))))
   `(company-tooltip-annotation-selection ((t (:foreground, base-white-br :background, base-bg))))
   `(company-tooltip-selection ((t (:foreground, base-fg :background, base-bg))))
   `(company-tooltip-mouse ((t (:background, base-bg))))
   `(company-tooltip-common ((t (:foreground, base-green-br))))
   `(company-tooltip-common-selection ((t (:foreground, base-green-br :background, base-bg))))
   `(company-scrollbar-fg ((t (:background, base-bg))))
   `(company-scrollbar-bg ((t (:background, base-bg-br))))
   `(company-preview ((t (:background, base-green-br))))
   `(company-preview-common ((t (:foreground, base-green-br :background, base-bg))))

   ;; eat mode
   `(eat-term-color-black          ((t (:foreground, base-black))))
   `(eat-term-color-bright-black   ((t (:foreground, base-black-br))))
   `(eat-term-color-red            ((t (:foreground, base-red))))
   `(eat-term-color-bright-red     ((t (:foreground, base-red-br))))
   `(eat-term-color-green          ((t (:foreground, base-green))))
   `(eat-term-color-bright-green   ((t (:foreground, base-green-br))))
   `(eat-term-color-yellow         ((t (:foreground, base-yellow))))
   `(eat-term-color-bright-yellow  ((t (:foreground, base-yellow-br))))
   `(eat-term-color-blue           ((t (:foreground, base-blue))))
   `(eat-term-color-bright-blue    ((t (:foreground, base-blue-br))))
   `(eat-term-color-magenta        ((t (:foreground, base-magenta))))
   `(eat-term-color-bright-magenta ((t (:foreground, base-magenta-br))))
   `(eat-term-color-cyan           ((t (:foreground, base-cyan))))
   `(eat-term-color-bright-cyan    ((t (:foreground, base-cyan-br))))
   `(eat-term-color-white          ((t (:foreground, base-white))))
   `(eat-term-color-bright-white   ((t (:foreground, base-white-br))))

   ;; lsp-ui
   `(lsp-ui-doc-background ((t (:background, base-bg-br))))
   `(lsp-ui-doc-header     ((t (:background, base-bg-br :foreground, base-green))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face  ((t (:foreground, base-fg))))
   `(rainbow-delimiters-depth-2-face  ((t (:foreground, ghostty-green))))
   `(rainbow-delimiters-depth-3-face  ((t (:foreground, ghostty-magenta))))
   `(rainbow-delimiters-depth-4-face  ((t (:foreground, ghostty-yellow))))
   `(rainbow-delimiters-depth-5-face  ((t (:foreground, ghostty-cyan))))
   `(rainbow-delimiters-depth-6-face  ((t (:foreground, ghostty-red))))
   `(rainbow-delimiters-depth-7-face  ((t (:foreground, ghostty-blue))))
   `(rainbow-delimiters-depth-8-face  ((t (:foreground, base-fg))))
   `(rainbow-delimiters-depth-9-face  ((t (:foreground, ghostty-green))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground, ghostty-magenta))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground, ghostty-yellow))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground, ghostty-red))))

   ;; whitespace-mode
   `(whitespace-space ((t (:background, base-bg-br :foreground, base-bg-br))))
   `(whitespace-hspace ((t (:background, base-bg-br :foreground, base-bg-br))))
   `(whitespace-tab ((t (:background, ghostty-red))))
   `(whitespace-newline ((t (:foreground, base-bg-br))))
   `(whitespace-trailing ((t (:background, ghostty-red))))
   `(whitespace-line ((t (:background, base-bg :foreground, base-magenta-br))))
   `(whitespace-space-before-tab ((t (:background, base-yellow-br :foreground, base-yellow-br))))
   `(whitespace-indentation ((t (:background, base-yellow :foreground, ghostty-red))))
   `(whitespace-empty ((t (:background, base-yellow))))
   `(whitespace-space-after-tab ((t (:background, base-yellow :foreground, ghostty-red))))

   ;; vertico
   `(vertico-multiline ((t (:foreground, base-cyan-br))))

   ))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'rjspotter-matrix)

;; Local Variables:
;; no-byte-compile: t
;; End:
