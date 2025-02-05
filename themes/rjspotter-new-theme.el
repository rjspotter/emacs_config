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
;; rjspotter-new-theme
;;
;; ----------------------------

(unless (>= emacs-major-version 24)
  (error "requires Emacs 24 or later."))

(deftheme rjspotter-new "A dark color theme for Emacs")

(let ((*comments*           "#aaaaaa")
      (*constant*           "#22bb22")
      (*current-line*       "#555555")
      (*cursor-underscore*  "#222222")
      (*keywords*           "#22ee22")
      (*line-number*        "#aaaaaa")
      (*method-declaration* "#22ff22")
      (*mode-line-fg*       "#229922")
      (*mode-inactive-fg*   "#dddddd")
      (*normal*             "#eeeeee")
      (*number*             "#eeeeee")
      (*operators*          "#eeeeee")
      (*warning*            "#882255")
      (*regexp*             "#44af44")
      (*string*             "#22af22")
      (*variable*           "#33cc33")
      (*visual-selection*   "#444444")
      (zenburn-fg+1         "#FFFFEF")
      (zenburn-fg           "#DCDCCC")
      (zenburn-fg-1         "#656555")
      (zenburn-bg-2         "#000000")
      (zenburn-bg-1         "#2B2B2B")
      (zenburn-bg-05        "#383838")
      (zenburn-bg           "#3F3F3F")
      (zenburn-bg+05        "#494949")
      (zenburn-bg+1         "#4F4F4F")
      (zenburn-bg+2         "#5F5F5F")
      (zenburn-bg+3         "#6F6F6F")
      (zenburn-red+1        "#DCA3A3")
      (zenburn-red          "#CC9393")
      (zenburn-red-1        "#BC8383")
      (zenburn-red-2        "#AC7373")
      (zenburn-red-3        "#9C6363")
      (zenburn-red-4        "#8C5353")
      (zenburn-orange       "#DFAF8F")
      (zenburn-yellow       "#F0DFAF")
      (zenburn-yellow-1     "#E0CF9F")
      (zenburn-yellow-2     "#D0BF8F")
      (zenburn-green-1      "#5F7F5F")
      (zenburn-green        "#7F9F7F")
      (zenburn-green+1      "#8FB28F")
      (zenburn-green+2      "#9FC59F")
      (zenburn-green+3      "#AFD8AF")
      (zenburn-green+4      "#BFEBBF")
      (zenburn-cyan         "#93E0E3")
      (zenburn-blue+1       "#94BFF3")
      (zenburn-blue         "#8CD0D3")
      (zenburn-blue-1       "#7CB8BB")
      (zenburn-blue-2       "#6CA0A3")
      (zenburn-blue-3       "#5C888B")
      (zenburn-blue-4       "#4C7073")
      (zenburn-blue-5       "#366060")
      (zenburn-magenta      "#DC8CC3"))

  (custom-theme-set-faces
   'rjspotter-new

   `(bold ((t (:bold t))))
   `(button ((t (:foreground, *keywords* :underline t))))
   `(default ((t (:foreground, *normal*))))
   `(header-line ((t (:foreground, *normal*)))) ;; info header
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
   `(linum ((t (:foreground, *line-number*))))
   `(minibuffer-prompt ((t (:foreground, *variable*))))
   `(mode-line ((t (:foreground, *mode-line-fg*))))
   `(mode-line-inactive ((t (:foreground, *mode-inactive-fg*))))
   `(cursor ((t (:background, *cursor-underscore* :foreground, *keywords*))))
   `(text-cursor ((t (:background, *cursor-underscore*))))

   ;; show-paren
   `(show-paren-mismatch ((t (:background, *warning* :foreground, *normal* :weight bold))))
   `(show-paren-match ((t (:background, *keywords* :foreground, *normal* :weight bold))))

   ;; search
   `(isearch ((t (:background, *normal* :foreground, *regexp*))))
   `(isearch-fail ((t (:background, *warning*))))
   `(lazy-highlight ((t (:background, *operators* :foreground, *visual-selection*))))
;;;;; company-mode
   `(company-tooltip ((t (:foreground ,zenburn-fg :background ,zenburn-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,zenburn-orange :background ,zenburn-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,zenburn-orange :background ,zenburn-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,zenburn-fg :background ,zenburn-bg-1))))
   `(company-tooltip-mouse ((t (:background ,zenburn-bg-1))))
   `(company-tooltip-common ((t (:foreground ,zenburn-green+2))))
   `(company-tooltip-common-selection ((t (:foreground ,zenburn-green+2))))
   `(company-scrollbar-fg ((t (:background ,zenburn-bg-1))))
   `(company-scrollbar-bg ((t (:background ,zenburn-bg+2))))
   `(company-preview ((t (:background ,zenburn-green+2))))
   `(company-preview-common ((t (:foreground ,zenburn-green+2 :background ,zenburn-bg-1))))
;;;;; helm
   `(helm-header
     ((t (:foreground ,zenburn-green
                      :background ,zenburn-bg
                      :underline nil
                      :box nil))))
   `(helm-source-header
     ((t (:foreground ,zenburn-yellow
                      :background ,zenburn-bg-1
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)))))
   `(helm-selection ((t (:background ,zenburn-bg+1 :underline nil))))
   `(helm-selection-line ((t (:background ,zenburn-bg+1))))
   `(helm-visible-mark ((t (:foreground ,zenburn-bg :background ,zenburn-yellow-2))))
   `(helm-candidate-number ((t (:foreground ,zenburn-green+4 :background ,zenburn-bg-1))))
   `(helm-separator ((t (:foreground ,zenburn-red))))
   `(helm-time-zone-current ((t (:foreground ,zenburn-green+2))))
   `(helm-time-zone-home ((t (:foreground ,zenburn-red))))
   `(helm-bookmark-addressbook ((t (:foreground ,zenburn-orange))))
   `(helm-bookmark-directory ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus ((t (:foreground ,zenburn-magenta))))
   `(helm-bookmark-info ((t (:foreground ,zenburn-green+2))))
   `(helm-bookmark-man ((t (:foreground ,zenburn-yellow))))
   `(helm-bookmark-w3m ((t (:foreground ,zenburn-magenta))))
   `(helm-buffer-not-saved ((t (:foreground ,zenburn-red))))
   `(helm-buffer-process ((t (:foreground ,zenburn-cyan))))
   `(helm-buffer-saved-out ((t (:foreground ,zenburn-fg))))
   `(helm-buffer-size ((t (:foreground ,zenburn-fg-1))))
   `(helm-ff-directory ((t (:foreground ,zenburn-cyan :background ,zenburn-bg :weight bold))))
   `(helm-ff-file ((t (:foreground ,zenburn-fg :background ,zenburn-bg :weight normal))))
   `(helm-ff-executable ((t (:foreground ,zenburn-green+2 :background ,zenburn-bg :weight normal))))
   `(helm-ff-invalid-symlink ((t (:foreground ,zenburn-red :background ,zenburn-bg :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,zenburn-yellow :background ,zenburn-bg :weight bold))))
   `(helm-ff-prefix ((t (:foreground ,zenburn-bg :background ,zenburn-yellow :weight normal))))
   `(helm-grep-cmd-line ((t (:foreground ,zenburn-cyan))))
   `(helm-grep-file ((t (:foreground ,zenburn-fg))))
   `(helm-grep-finish ((t (:foreground ,zenburn-green+2))))
   `(helm-grep-lineno ((t (:foreground ,zenburn-fg-1))))
   `(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((t (:foreground ,zenburn-red))))
   `(helm-match ((t (:foreground ,zenburn-orange :background ,zenburn-bg-1 :weight bold))))
   `(helm-moccur-buffer ((t (:foreground ,zenburn-cyan))))
   `(helm-mu-contacts-address-face ((t (:foreground ,zenburn-fg-1))))
   `(helm-mu-contacts-name-face ((t (:foreground ,zenburn-fg))))
;;;;; magit
;;;;;; headings and diffs
   `(magit-section-highlight           ((t (:background ,zenburn-bg+05))))
   `(magit-section-heading             ((t (:foreground ,zenburn-yellow :weight bold))))
   `(magit-section-heading-selection   ((t (:foreground ,zenburn-orange :weight bold))))
   `(magit-diff-file-heading           ((t (:weight bold))))
   `(magit-diff-file-heading-highlight ((t (:background ,zenburn-bg+05  :weight bold))))
   `(magit-diff-file-heading-selection ((t (:background ,zenburn-bg+05
                                                        :foreground ,zenburn-orange :weight bold))))
   `(magit-diff-hunk-heading           ((t (:background ,zenburn-bg+1))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,zenburn-bg+2))))
   `(magit-diff-hunk-heading-selection ((t (:background ,zenburn-bg+2
                                                        :foreground ,zenburn-orange))))
   `(magit-diff-lines-heading          ((t (:background ,zenburn-orange
                                                        :foreground ,zenburn-bg+2))))
   `(magit-diff-context-highlight      ((t (:background ,zenburn-bg+05
                                                        :foreground "grey70"))))
   `(magit-diffstat-added   ((t (:foreground ,zenburn-green+4))))
   `(magit-diffstat-removed ((t (:foreground ,zenburn-red))))
;;;;;; popup
   `(magit-popup-heading             ((t (:foreground ,zenburn-yellow  :weight bold))))
   `(magit-popup-key                 ((t (:foreground ,zenburn-green-1 :weight bold))))
   `(magit-popup-argument            ((t (:foreground ,zenburn-green   :weight bold))))
   `(magit-popup-disabled-argument   ((t (:foreground ,zenburn-fg-1    :weight normal))))
   `(magit-popup-option-value        ((t (:foreground ,zenburn-blue-2  :weight bold))))
;;;;;; process
   `(magit-process-ok    ((t (:foreground ,zenburn-green  :weight bold))))
   `(magit-process-ng    ((t (:foreground ,zenburn-red    :weight bold))))
;;;;;; log
   `(magit-log-author    ((t (:foreground ,zenburn-orange))))
   `(magit-log-date      ((t (:foreground ,zenburn-fg-1))))
   `(magit-log-graph     ((t (:foreground ,zenburn-fg+1))))
;;;;;; sequence
   `(magit-sequence-pick ((t (:foreground ,zenburn-yellow-2))))
   `(magit-sequence-stop ((t (:foreground ,zenburn-green))))
   `(magit-sequence-part ((t (:foreground ,zenburn-yellow))))
   `(magit-sequence-head ((t (:foreground ,zenburn-blue))))
   `(magit-sequence-drop ((t (:foreground ,zenburn-red))))
   `(magit-sequence-done ((t (:foreground ,zenburn-fg-1))))
   `(magit-sequence-onto ((t (:foreground ,zenburn-fg-1))))
;;;;;; bisect
   `(magit-bisect-good ((t (:foreground ,zenburn-green))))
   `(magit-bisect-skip ((t (:foreground ,zenburn-yellow))))
   `(magit-bisect-bad  ((t (:foreground ,zenburn-red))))
;;;;;; blame
   `(magit-blame-heading ((t (:background ,zenburn-bg-1 :foreground ,zenburn-blue-2))))
   `(magit-blame-hash    ((t (:background ,zenburn-bg-1 :foreground ,zenburn-blue-2))))
   `(magit-blame-name    ((t (:background ,zenburn-bg-1 :foreground ,zenburn-orange))))
   `(magit-blame-date    ((t (:background ,zenburn-bg-1 :foreground ,zenburn-orange))))
   `(magit-blame-summary ((t (:background ,zenburn-bg-1 :foreground ,zenburn-blue-2
                                          :weight bold))))
;;;;;; references etc
   `(magit-dimmed         ((t (:foreground ,zenburn-bg+3))))
   `(magit-hash           ((t (:foreground ,zenburn-bg+3))))
   `(magit-tag            ((t (:foreground ,zenburn-orange :weight bold))))
   `(magit-branch-remote  ((t (:foreground ,zenburn-green  :weight bold))))
   `(magit-branch-local   ((t (:foreground ,zenburn-blue   :weight bold))))
   `(magit-branch-current ((t (:foreground ,zenburn-blue   :weight bold :box t))))
   `(magit-head           ((t (:foreground ,zenburn-blue   :weight bold))))
   `(magit-refname        ((t (:background ,zenburn-bg+2 :foreground ,zenburn-fg :weight bold))))
   `(magit-refname-stash  ((t (:background ,zenburn-bg+2 :foreground ,zenburn-fg :weight bold))))
   `(magit-refname-wip    ((t (:background ,zenburn-bg+2 :foreground ,zenburn-fg :weight bold))))
   `(magit-signature-good      ((t (:foreground ,zenburn-green))))
   `(magit-signature-bad       ((t (:foreground ,zenburn-red))))
   `(magit-signature-untrusted ((t (:foreground ,zenburn-yellow))))
   `(magit-cherry-unmatched    ((t (:foreground ,zenburn-cyan))))
   `(magit-cherry-equivalent   ((t (:foreground ,zenburn-magenta))))
   `(magit-reflog-commit       ((t (:foreground ,zenburn-green))))
   `(magit-reflog-amend        ((t (:foreground ,zenburn-magenta))))
   `(magit-reflog-merge        ((t (:foreground ,zenburn-green))))
   `(magit-reflog-checkout     ((t (:foreground ,zenburn-blue))))
   `(magit-reflog-reset        ((t (:foreground ,zenburn-red))))
   `(magit-reflog-rebase       ((t (:foreground ,zenburn-magenta))))
   `(magit-reflog-cherry-pick  ((t (:foreground ,zenburn-green))))
   `(magit-reflog-remote       ((t (:foreground ,zenburn-cyan))))
   `(magit-reflog-other        ((t (:foreground ,zenburn-cyan))))

;;;;; web-mode
   `(web-mode-builtin-face ((t (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((t (:inherit ,font-lock-constant-face))))
   `(web-mode-css-at-rule-face ((t (:foreground ,*keywords* ))))
   `(web-mode-css-prop-face ((t (:foreground ,*keywords*))))
   `(web-mode-css-pseudo-class-face ((t (:foreground ,*regexp*))))
   `(web-mode-css-rule-face ((t (:foreground ,*method-declaration*))))
   `(web-mode-doctype-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-folded-face ((t (:underline t))))
   `(web-mode-function-name-face ((t (:foreground ,*method-declaration*))))
   `(web-mode-html-attr-name-face ((t (:foreground ,*keywords*))))
   `(web-mode-html-attr-value-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-html-tag-face ((t (:foreground ,*regexp*))))
   `(web-mode-html-tag-bracket-face ((t (:foreground ,*comments*))))
   `(web-mode-keyword-face ((t (:inherit ,font-lock-keyword-face))))
   `(web-mode-preprocessor-face ((t (:inherit ,font-lock-preprocessor-face))))
   `(web-mode-string-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-type-face ((t (:inherit ,font-lock-type-face))))
   `(web-mode-variable-name-face ((t (:inherit ,font-lock-variable-name-face))))
   `(web-mode-server-comment-face ((t (:inherit web-mode-comment-face))))
   `(web-mode-server-string-face ((t (:inherit web-mode-string-face))))
   `(web-mode-symbol-face ((t (:inherit font-lock-constant-face))))
   `(web-mode-warning-face ((t (:inherit font-lock-warning-face))))
   `(web-mode-whitespaces-face ((t (:background ,*warning*))))

;;;;;;; eat mode
   `(eat-term-color-blue        ((t (:foreground ,zenburn-cyan))))
   `(eat-term-color-red        ((t (:foreground ,zenburn-magenta))))
   `(eat-term-color-bright-blue        ((t (:foreground ,zenburn-cyan))))
   `(eat-term-color-bright-red        ((t (:foreground ,zenburn-magenta))))
   ))
;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'rjspotter-new)

;; Local Variables:
;; no-byte-compile: t
;; End:
