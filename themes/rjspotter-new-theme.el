;;; darklime-theme.el 

;; Copyright (C) 2017 Randall Potter

;; Author: R. Potter <rjspotter@gmail.com>
;; URL: none
;; Version: 0.1

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

;;; Commentary:

;; using the layout of a well defined theme to upgrade my personal theme

;;; Credits:

;; 

;;; Code:

(deftheme darklime "The Darklime color theme")

;;; Color Palette
(defvar darklime-default-colors-alist
  '(("darklime-fg+1"     . "#FFFFFF")
    ("darklime-fg"       . "#eeeeee")
    ("darklime-fg-1"     . "#656555")
    ("darklime-bg-2"     . "#000000")
    ("darklime-bg-1"     . "#2B2B2B")
    ("darklime-bg-05"    . "#383838")
    ("darklime-bg"       . "#3F3F3F")
    ("darklime-bg+05"    . "#494949")
    ("darklime-bg+1"     . "#4F4F4F")
    ("darklime-bg+2"     . "#5F5F5F")
    ("darklime-bg+3"     . "#6F6F6F")
    ("darklime-red+1"    . "#DCA3A3")
    ("darklime-red"      . "#CC9393")
    ("darklime-red-1"    . "#BC8383")
    ("darklime-red-2"    . "#AC7373")
    ("darklime-red-3"    . "#9C6363")
    ("darklime-red-4"    . "#8C5353")
    ("darklime-orange"   . "#DFAF8F")
    ("darklime-yellow"   . "#F0DFAF")
    ("darklime-yellow-1" . "#E0CF9F")
    ("darklime-yellow-2" . "#D0BF8F")
    ("darklime-green-1"  . "#5F7F5F")
    ("darklime-green"    . "#7F9F7F")
    ("darklime-green+1"  . "#8FB28F")
    ("darklime-green+2"  . "#9FC59F")
    ("darklime-green+3"  . "#AFD8AF")
    ("darklime-green+4"  . "#BFEBBF")
    ("darklime-cyan"     . "#93E0E3")
    ("darklime-blue+1"   . "#94BFF3")
    ("darklime-blue"     . "#8CD0D3")
    ("darklime-blue-1"   . "#7CB8BB")
    ("darklime-blue-2"   . "#6CA0A3")
    ("darklime-blue-3"   . "#5C888B")
    ("darklime-blue-4"   . "#4C7073")
    ("darklime-blue-5"   . "#366060")
    ("darklime-magenta"  . "#DC8CC3"))
  "List of Darklime colors.
Each element has the form (NAME . HEX).

`+N' suffixes indicate a color is lighter.
`-N' suffixes indicate a color is darker.")

(defvar darklime-override-colors-alist
  '()
  "Place to override default theme colors.

You can override a subset of the theme's default colors by
defining them in this alist before loading the theme.")

(defvar darklime-colors-alist
  (append darklime-default-colors-alist darklime-override-colors-alist))

(defmacro darklime-with-color-variables (&rest body)
  "`let' bind all colors defined in `darklime-colors-alist' around BODY.
Also bind `class' to ((class color) (min-colors 89))."
  (declare (indent 0))
  `(let ((class '((class color) (min-colors 89)))
         ,@(mapcar (lambda (cons)
                     (list (intern (car cons)) (cdr cons)))
                   darklime-colors-alist))
     ,@body))

;;; Theme Faces
(darklime-with-color-variables
  (custom-theme-set-faces
   'darklime
;;;; Built-in
;;;;; basic coloring
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,darklime-yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,darklime-yellow-2 :underline t :weight normal))))
   `(default ((t (:foreground ,darklime-fg))))
   `(cursor ((t (:foreground ,darklime-fg :background ,darklime-fg+1))))
   `(escape-glyph ((t (:foreground ,darklime-yellow :weight bold))))
   `(fringe ((t (:foreground ,darklime-fg+1))))
   `(header-line ((t (:foreground ,darklime-yellow
                                 -1
                                  :box (:line-width -1 :style released-button)))))
   `(highlight ((t (:background ,darklime-bg-05))))
   `(success ((t (:foreground ,darklime-green :weight bold))))
   `(warning ((t (:foreground ,darklime-orange :weight bold))))
   `(tooltip ((t (:foreground ,darklime-fg+1))))
;;;;; compilation
   `(compilation-column-face ((t (:foreground ,darklime-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,darklime-green))))
   `(compilation-error-face ((t (:foreground ,darklime-red-1 :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,darklime-fg))))
   `(compilation-info-face ((t (:foreground ,darklime-blue))))
   `(compilation-info ((t (:foreground ,darklime-green+4 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,darklime-green))))
   `(compilation-line-face ((t (:foreground ,darklime-yellow))))
   `(compilation-line-number ((t (:foreground ,darklime-yellow))))
   `(compilation-message-face ((t (:foreground ,darklime-blue))))
   `(compilation-warning-face ((t (:foreground ,darklime-orange :weight bold :underline t))))
   `(compilation-mode-line-exit ((t (:foreground ,darklime-green+2 :weight bold))))
   `(compilation-mode-line-fail ((t (:foreground ,darklime-red :weight bold))))
   `(compilation-mode-line-run ((t (:foreground ,darklime-yellow :weight bold))))
;;;;; completions
   `(completions-annotations ((t (:foreground ,darklime-fg-1))))
;;;;; grep
   `(grep-context-face ((t (:foreground ,darklime-fg))))
   `(grep-error-face ((t (:foreground ,darklime-red-1 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,darklime-blue))))
   `(grep-match-face ((t (:foreground ,darklime-orange :weight bold))))
   `(match ((t (:background ,darklime-bg-1 :foreground ,darklime-orange :weight bold))))
;;;;; hi-lock
   `(hi-blue    ((t (:background ,darklime-cyan    :foreground ,darklime-bg-1))))
   `(hi-green   ((t (:background ,darklime-green+4 :foreground ,darklime-bg-1))))
   `(hi-pink    ((t (:background ,darklime-magenta :foreground ,darklime-bg-1))))
   `(hi-yellow  ((t (:background ,darklime-yellow  :foreground ,darklime-bg-1))))
   `(hi-blue-b  ((t (:foreground ,darklime-blue    :weight     bold))))
   `(hi-green-b ((t (:foreground ,darklime-green+2 :weight     bold))))
   `(hi-red-b   ((t (:foreground ,darklime-red     :weight     bold))))
;;;;; info
   `(Info-quoted ((t (:inherit font-lock-constant-face))))
;;;;; isearch
   `(isearch ((t (:foreground ,darklime-yellow-2 :weight bold+2))))
   `(isearch-fail ((t (:foreground ,darklime-fg :background ,darklime-red-4))))
   `(lazy-highlight ((t (:foreground ,darklime-yellow-2 :weight bold-05))))

   `(menu ((t (:foreground ,darklime-fg))))
   `(minibuffer-prompt ((t (:foreground ,darklime-yellow))))
   `(mode-line
     ((,class (:foreground ,darklime-green+1
                          -1
                           :box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,darklime-yellow :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,darklime-green-1
                     -05
                      :box (:line-width -1 :style released-button)))))
   `(region ((,class (:background ,darklime-bg-1))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,darklime-bg+2))))
   `(trailing-whitespace ((t (:background ,darklime-red))))
   `(vertical-border ((t (:foreground ,darklime-fg))))
;;;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,darklime-fg :weight bold))))
   `(font-lock-comment-face ((t (:foreground ,darklime-green))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,darklime-green-1))))
   `(font-lock-constant-face ((t (:foreground ,darklime-green+4))))
   `(font-lock-doc-face ((t (:foreground ,darklime-green+2))))
   `(font-lock-function-name-face ((t (:foreground ,darklime-cyan))))
   `(font-lock-keyword-face ((t (:foreground ,darklime-yellow :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,darklime-yellow :weight bold))))
   `(font-lock-preprocessor-face ((t (:foreground ,darklime-blue+1))))
   `(font-lock-regexp-grouping-construct ((t (:foreground ,darklime-yellow :weight bold))))
   `(font-lock-regexp-grouping-backslash ((t (:foreground ,darklime-green :weight bold))))
   `(font-lock-string-face ((t (:foreground ,darklime-red))))
   `(font-lock-type-face ((t (:foreground ,darklime-blue-1))))
   `(font-lock-variable-name-face ((t (:foreground ,darklime-orange))))
   `(font-lock-warning-face ((t (:foreground ,darklime-yellow-2 :weight bold))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))
;;;;; man
   '(Man-overstrike ((t (:inherit font-lock-keyword-face))))
   '(Man-underline  ((t (:inherit (font-lock-string-face underline)))))
;;;;; newsticker
   `(newsticker-date-face ((t (:foreground ,darklime-fg))))
   `(newsticker-default-face ((t (:foreground ,darklime-fg))))
   `(newsticker-enclosure-face ((t (:foreground ,darklime-green+3))))
   `(newsticker-extra-face ((t (:foreground ,darklime-bg+2 :height 0.8))))
   `(newsticker-feed-face ((t (:foreground ,darklime-fg))))
   `(newsticker-immortal-item-face ((t (:foreground ,darklime-green))))
   `(newsticker-new-item-face ((t (:foreground ,darklime-blue))))
   `(newsticker-obsolete-item-face ((t (:foreground ,darklime-red))))
   `(newsticker-old-item-face ((t (:foreground ,darklime-bg+3))))
   `(newsticker-statistics-face ((t (:foreground ,darklime-fg))))
   `(newsticker-treeview-face ((t (:foreground ,darklime-fg))))
   `(newsticker-treeview-immortal-face ((t (:foreground ,darklime-green))))
   `(newsticker-treeview-listwindow-face ((t (:foreground ,darklime-fg))))
   `(newsticker-treeview-new-face ((t (:foreground ,darklime-blue :weight bold))))
   `(newsticker-treeview-obsolete-face ((t (:foreground ,darklime-red))))
   `(newsticker-treeview-old-face ((t (:foreground ,darklime-bg+3))))
   `(newsticker-treeview-selection-face ((t (:background ,darklime-bg-1 :foreground ,darklime-yellow))))
;;;;; woman
   '(woman-bold   ((t (:inherit font-lock-keyword-face))))
   '(woman-italic ((t (:inherit (font-lock-string-face italic)))))
;;;; Third-party
;;;;; ace-jump
   `(ace-jump-face-background
     ((t (:foreground ,darklime-fg-1 :inverse-video nil))))
   `(ace-jump-face-foreground
     ((t (:foreground ,darklime-green+2 :inverse-video nil))))
;;;;; ace-window
   `(aw-background-face
     ((t (:foreground ,darklime-fg-1 :inverse-video nil))))
   `(aw-leading-char-face ((t (:inherit aw-mode-line-face))))
;;;;; android mode
   `(android-mode-debug-face ((t (:foreground ,darklime-green+1))))
   `(android-mode-error-face ((t (:foreground ,darklime-orange :weight bold))))
   `(android-mode-info-face ((t (:foreground ,darklime-fg))))
   `(android-mode-verbose-face ((t (:foreground ,darklime-green))))
   `(android-mode-warning-face ((t (:foreground ,darklime-yellow))))
;;;;; anzu
   `(anzu-mode-line ((t (:foreground ,darklime-cyan :weight bold))))
   `(anzu-mode-line-no-match ((t (:foreground ,darklime-red :weight bold))))
   `(anzu-match-1 ((t (:foreground ,darklime-bg :background ,darklime-green))))
   `(anzu-match-2 ((t (:foreground ,darklime-bg :background ,darklime-orange))))
   `(anzu-match-3 ((t (:foreground ,darklime-bg :background ,darklime-blue))))
   `(anzu-replace-to ((t (:inherit anzu-replace-highlight :foreground ,darklime-yellow))))
;;;;; auctex
   `(font-latex-bold-face ((t (:inherit bold))))
   `(font-latex-warning-face ((t (:foreground nil :inherit font-lock-warning-face))))
   `(font-latex-sectioning-5-face ((t (:foreground ,darklime-red :weight bold ))))
   `(font-latex-sedate-face ((t (:foreground ,darklime-yellow))))
   `(font-latex-italic-face ((t (:foreground ,darklime-cyan :slant italic))))
   `(font-latex-string-face ((t (:inherit ,font-lock-string-face))))
   `(font-latex-math-face ((t (:foreground ,darklime-orange))))
;;;;; agda-mode
   `(agda2-highlight-keyword-face ((t (:foreground ,darklime-yellow :weight bold))))
   `(agda2-highlight-string-face ((t (:foreground ,darklime-red))))
   `(agda2-highlight-symbol-face ((t (:foreground ,darklime-orange))))
   `(agda2-highlight-primitive-type-face ((t (:foreground ,darklime-blue-1))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,darklime-fg))))
   `(agda2-highlight-coinductive-constructor-face ((t (:foreground ,darklime-fg))))
   `(agda2-highlight-datatype-face ((t (:foreground ,darklime-blue))))
   `(agda2-highlight-function-face ((t (:foreground ,darklime-blue))))
   `(agda2-highlight-module-face ((t (:foreground ,darklime-blue-1))))
   `(agda2-highlight-error-face ((t (:foreground ,darklime-bg :background ,darklime-magenta))))
   `(agda2-highlight-unsolved-meta-face ((t (:foreground ,darklime-bg :background ,darklime-magenta))))
   `(agda2-highlight-unsolved-constraint-face ((t (:foreground ,darklime-bg :background ,darklime-magenta))))
   `(agda2-highlight-termination-problem-face ((t (:foreground ,darklime-bg :background ,darklime-magenta))))
   `(agda2-highlight-incomplete-pattern-face ((t (:foreground ,darklime-bg :background ,darklime-magenta))))
   `(agda2-highlight-typechecks-face ((t (:background ,darklime-red-4))))
;;;;; auto-complete
   `(ac-candidate-face ((t (:background ,darklime-bg+3 :foreground ,darklime-bg-2))))
   `(ac-selection-face ((t (:background ,darklime-blue-4 :foreground ,darklime-fg))))
   `(popup-tip-face ((t (:background ,darklime-yellow-2 :foreground ,darklime-bg-2))))
   `(popup-menu-mouse-face ((t (:background ,darklime-yellow-2 :foreground ,darklime-bg-2))))
   `(popup-summary-face ((t (:background ,darklime-bg+3 :foreground ,darklime-bg-2))))
   `(popup-scroll-bar-foreground-face ((t (:background ,darklime-blue-5))))
   `(popup-scroll-bar-background-face ((t (:background ,darklime-bg-1))))
   `(popup-isearch-match ((t (:background ,darklime-bg :foreground ,darklime-fg))))
;;;;; avy
   `(avy-background-face
     ((t (:foreground ,darklime-fg-1 :inverse-video nil))))
   `(avy-lead-face-0
     ((t (:foreground ,darklime-green+3 :inverse-video nil :weight bold))))
   `(avy-lead-face-1
     ((t (:foreground ,darklime-yellow :inverse-video nil :weight bold))))
   `(avy-lead-face-2
     ((t (:foreground ,darklime-red+1 :inverse-video nil :weight bold))))
   `(avy-lead-face
     ((t (:foreground ,darklime-cyan :inverse-video nil :weight bold))))
;;;;; company-mode
   `(company-tooltip ((t (:foreground ,darklime-fg+1))))
   `(company-tooltip-annotation ((t (:foreground ,darklime-orange+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,darklime-orange-1))))
   `(company-tooltip-selection ((t (:foreground ,darklime-fg-1))))
   `(company-tooltip-mouse ((t (:background ,darklime-bg-1))))
   `(company-tooltip-common ((t (:foreground ,darklime-green+2))))
   `(company-tooltip-common-selection ((t (:foreground ,darklime-green+2))))
   `(company-scrollbar-fg ((t (:background ,darklime-bg-1))))
   `(company-scrollbar-bg ((t (:background ,darklime-bg+2))))
   `(company-preview ((t (:background ,darklime-green+2))))
   `(company-preview-common ((t (:foreground ,darklime-green+2-1))))
;;;;; bm
   `(bm-face ((t (:background ,darklime-yellow-1 :foreground ,darklime-bg))))
   `(bm-fringe-face ((t (:background ,darklime-yellow-1 :foreground ,darklime-bg))))
   `(bm-fringe-persistent-face ((t (:background ,darklime-green-1 :foreground ,darklime-bg))))
   `(bm-persistent-face ((t (:background ,darklime-green-1 :foreground ,darklime-bg))))
;;;;; calfw
   `(cfw:face-annotation ((t (:foreground ,darklime-red :inherit cfw:face-day-title))))
   `(cfw:face-day-title ((t nil)))
   `(cfw:face-default-content ((t (:foreground ,darklime-green))))
   `(cfw:face-default-day ((t (:weight bold))))
   `(cfw:face-disable ((t (:foreground ,darklime-fg-1))))
   `(cfw:face-grid ((t (:inherit shadow))))
   `(cfw:face-header ((t (:inherit font-lock-keyword-face))))
   `(cfw:face-holiday ((t (:inherit cfw:face-sunday))))
   `(cfw:face-periods ((t (:foreground ,darklime-cyan))))
   `(cfw:face-saturday ((t (:foreground ,darklime-blue :weight bold))))
   `(cfw:face-select ((t (:background ,darklime-blue-5))))
   `(cfw:face-sunday ((t (:foreground ,darklime-red :weight bold))))
   `(cfw:face-title ((t (:height 2.0 :inherit (variable-pitch font-lock-keyword-face)))))
   `(cfw:face-today ((t (:foreground ,darklime-cyan :weight bold))))
   `(cfw:face-today-title ((t (:inherit highlight bold))))
   `(cfw:face-toolbar ((t (:background ,darklime-blue-5))))
   `(cfw:face-toolbar-button-off ((t (:underline nil :inherit link))))
   `(cfw:face-toolbar-button-on ((t (:underline nil :inherit link-visited))))
;;;;; cider
   `(cider-result-overlay-face ((t (:background unspecified))))
   `(cider-enlightened-face ((t (:box (:color ,darklime-orange :line-width -1)))))
   `(cider-enlightened-local-face ((t (:weight bold :foreground ,darklime-green+1))))
   `(cider-deprecated-face ((t (:background ,darklime-yellow-2))))
   `(cider-instrumented-face ((t (:box (:color ,darklime-red :line-width -1)))))
   `(cider-traced-face ((t (:box (:color ,darklime-cyan :line-width -1)))))
   `(cider-test-failure-face ((t (:background ,darklime-red-4))))
   `(cider-test-error-face ((t (:background ,darklime-magenta))))
   `(cider-test-success-face ((t (:background ,darklime-green-1))))
   `(cider-fringe-good-face ((t (:foreground ,darklime-green+4))))
;;;;; circe
   `(circe-highlight-nick-face ((t (:foreground ,darklime-cyan))))
   `(circe-my-message-face ((t (:foreground ,darklime-fg))))
   `(circe-fool-face ((t (:foreground ,darklime-red+1))))
   `(circe-topic-diff-removed-face ((t (:foreground ,darklime-red :weight bold))))
   `(circe-originator-face ((t (:foreground ,darklime-fg))))
   `(circe-server-face ((t (:foreground ,darklime-green))))
   `(circe-topic-diff-new-face ((t (:foreground ,darklime-orange :weight bold))))
   `(circe-prompt-face ((t (:foreground ,darklime-orange :weight bold))))
;;;;; context-coloring
   `(context-coloring-level-0-face ((t :foreground ,darklime-fg)))
   `(context-coloring-level-1-face ((t :foreground ,darklime-cyan)))
   `(context-coloring-level-2-face ((t :foreground ,darklime-green+4)))
   `(context-coloring-level-3-face ((t :foreground ,darklime-yellow)))
   `(context-coloring-level-4-face ((t :foreground ,darklime-orange)))
   `(context-coloring-level-5-face ((t :foreground ,darklime-magenta)))
   `(context-coloring-level-6-face ((t :foreground ,darklime-blue+1)))
   `(context-coloring-level-7-face ((t :foreground ,darklime-green+2)))
   `(context-coloring-level-8-face ((t :foreground ,darklime-yellow-2)))
   `(context-coloring-level-9-face ((t :foreground ,darklime-red+1)))
;;;;; coq
   `(coq-solve-tactics-face ((t (:foreground nil :inherit font-lock-constant-face))))
;;;;; ctable
   `(ctbl:face-cell-select ((t (:background ,darklime-blue :foreground ,darklime-bg))))
   `(ctbl:face-continue-bar ((t (:background ,darklime-bg-05 :foreground ,darklime-bg))))
   `(ctbl:face-row-select ((t (:background ,darklime-cyan :foreground ,darklime-bg))))
;;;;; debbugs
   `(debbugs-gnu-done ((t (:foreground ,darklime-fg-1))))
   `(debbugs-gnu-handled ((t (:foreground ,darklime-green))))
   `(debbugs-gnu-new ((t (:foreground ,darklime-red))))
   `(debbugs-gnu-pending ((t (:foreground ,darklime-blue))))
   `(debbugs-gnu-stale ((t (:foreground ,darklime-orange))))
   `(debbugs-gnu-tagged ((t (:foreground ,darklime-red))))
;;;;; diff
   `(diff-added          ((t (:background "#335533" :foreground ,darklime-green))))
   `(diff-changed        ((t (:background "#555511" :foreground ,darklime-yellow-1))))
   `(diff-removed        ((t (:background "#553333" :foreground ,darklime-red-2))))
   `(diff-refine-added   ((t (:background "#338833" :foreground ,darklime-green+4))))
   `(diff-refine-change  ((t (:background "#888811" :foreground ,darklime-yellow))))
   `(diff-refine-removed ((t (:background "#883333" :foreground ,darklime-red))))
   `(diff-header ((,class (:background ,darklime-bg+2))
                  (t (:background ,darklime-fg :foreground ,darklime-bg))))
   `(diff-file-header
     ((,class (:background ,darklime-bg+2 :foreground ,darklime-fg :weight bold))
      (t (:background ,darklime-fg :foreground ,darklime-bg :weight bold))))
;;;;; diff-hl
   `(diff-hl-change ((,class (:foreground ,darklime-blue :background ,darklime-blue-2))))
   `(diff-hl-delete ((,class (:foreground ,darklime-red+1 :background ,darklime-red-1))))
   `(diff-hl-insert ((,class (:foreground ,darklime-green+1 :background ,darklime-green-1))))
;;;;; dim-autoload
   `(dim-autoload-cookie-line ((t :foreground ,darklime-bg+1)))
;;;;; dired+
   `(diredp-display-msg ((t (:foreground ,darklime-blue))))
   `(diredp-compressed-file-suffix ((t (:foreground ,darklime-orange))))
   `(diredp-date-time ((t (:foreground ,darklime-magenta))))
   `(diredp-deletion ((t (:foreground ,darklime-yellow))))
   `(diredp-deletion-file-name ((t (:foreground ,darklime-red))))
   `(diredp-dir-heading ((t (:foreground ,darklime-blue-1))))
   `(diredp-dir-priv ((t (:foreground ,darklime-cyan))))
   `(diredp-exec-priv ((t (:foreground ,darklime-red))))
   `(diredp-executable-tag ((t (:foreground ,darklime-green+1))))
   `(diredp-file-name ((t (:foreground ,darklime-blue))))
   `(diredp-file-suffix ((t (:foreground ,darklime-green))))
   `(diredp-flag-mark ((t (:foreground ,darklime-yellow))))
   `(diredp-flag-mark-line ((t (:foreground ,darklime-orange))))
   `(diredp-ignored-file-name ((t (:foreground ,darklime-red))))
   `(diredp-link-priv ((t (:foreground ,darklime-yellow))))
   `(diredp-mode-line-flagged ((t (:foreground ,darklime-yellow))))
   `(diredp-mode-line-marked ((t (:foreground ,darklime-orange))))
   `(diredp-no-priv ((t (:foreground ,darklime-fg))))
   `(diredp-number ((t (:foreground ,darklime-green+1))))
   `(diredp-other-priv ((t (:foreground ,darklime-yellow-1))))
   `(diredp-rare-priv ((t (:foreground ,darklime-red-1))))
   `(diredp-read-priv ((t (:foreground ,darklime-green-1))))
   `(diredp-symlink ((t (:foreground ,darklime-yellow))))
   `(diredp-write-priv ((t (:foreground ,darklime-magenta))))
;;;;; dired-async
   `(dired-async-failures ((t (:foreground ,darklime-red :weight bold))))
   `(dired-async-message ((t (:foreground ,darklime-yellow :weight bold))))
   `(dired-async-mode-message ((t (:foreground ,darklime-yellow))))
;;;;; ediff
   `(ediff-current-diff-A ((t (:foreground ,darklime-fg :background ,darklime-red-4))))
   `(ediff-current-diff-Ancestor ((t (:foreground ,darklime-fg :background ,darklime-red-4))))
   `(ediff-current-diff-B ((t (:foreground ,darklime-fg :background ,darklime-green-1))))
   `(ediff-current-diff-C ((t (:foreground ,darklime-fg :background ,darklime-blue-5))))
   `(ediff-even-diff-A ((t (:background ,darklime-bg+1))))
   `(ediff-even-diff-Ancestor ((t (:background ,darklime-bg+1))))
   `(ediff-even-diff-B ((t (:background ,darklime-bg+1))))
   `(ediff-even-diff-C ((t (:background ,darklime-bg+1))))
   `(ediff-fine-diff-A ((t (:foreground ,darklime-fg :background ,darklime-red-2 :weight bold))))
   `(ediff-fine-diff-Ancestor ((t (:foreground ,darklime-fg :background ,darklime-red-2 weight bold))))
   `(ediff-fine-diff-B ((t (:foreground ,darklime-fg :background ,darklime-green :weight bold))))
   `(ediff-fine-diff-C ((t (:foreground ,darklime-fg :background ,darklime-blue-3 :weight bold ))))
   `(ediff-odd-diff-A ((t (:background ,darklime-bg+2))))
   `(ediff-odd-diff-Ancestor ((t (:background ,darklime-bg+2))))
   `(ediff-odd-diff-B ((t (:background ,darklime-bg+2))))
   `(ediff-odd-diff-C ((t (:background ,darklime-bg+2))))
;;;;; egg
   `(egg-text-base ((t (:foreground ,darklime-fg))))
   `(egg-help-header-1 ((t (:foreground ,darklime-yellow))))
   `(egg-help-header-2 ((t (:foreground ,darklime-green+3))))
   `(egg-branch ((t (:foreground ,darklime-yellow))))
   `(egg-branch-mono ((t (:foreground ,darklime-yellow))))
   `(egg-term ((t (:foreground ,darklime-yellow))))
   `(egg-diff-add ((t (:foreground ,darklime-green+4))))
   `(egg-diff-del ((t (:foreground ,darklime-red+1))))
   `(egg-diff-file-header ((t (:foreground ,darklime-yellow-2))))
   `(egg-section-title ((t (:foreground ,darklime-yellow))))
   `(egg-stash-mono ((t (:foreground ,darklime-green+4))))
;;;;; elfeed
   `(elfeed-log-error-level-face ((t (:foreground ,darklime-red))))
   `(elfeed-log-info-level-face ((t (:foreground ,darklime-blue))))
   `(elfeed-log-warn-level-face ((t (:foreground ,darklime-yellow))))
   `(elfeed-search-date-face ((t (:foreground ,darklime-yellow-1 :underline t
                                              :weight bold))))
   `(elfeed-search-tag-face ((t (:foreground ,darklime-green))))
   `(elfeed-search-feed-face ((t (:foreground ,darklime-cyan))))
;;;;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,darklime-yellow :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,darklime-yellow-2
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,darklime-red-1 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,darklime-yellow
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,darklime-green+2))))
   `(w3m-lnum-match ((t (:background ,darklime-bg-1
                                     :foreground ,darklime-orange
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,darklime-yellow))))
;;;;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,darklime-blue :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning-face))))
   `(erc-default-face ((t (:foreground ,darklime-fg))))
   `(erc-direct-msg-face ((t (:inherit erc-default-face))))
   `(erc-error-face ((t (:inherit font-lock-warning-face))))
   `(erc-fool-face ((t (:inherit erc-default-face))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,darklime-yellow))))
   `(erc-keyword-face ((t (:foreground ,darklime-blue :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,darklime-yellow :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,darklime-red :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default-face))))
   `(erc-notice-face ((t (:foreground ,darklime-green))))
   `(erc-pal-face ((t (:foreground ,darklime-orange :weight bold))))
   `(erc-prompt-face ((t (:foreground ,darklime-orange :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,darklime-green+4))))
   `(erc-underline-face ((t (:underline t))))
;;;;; eros
   `(eros-result-overlay-face ((t (:background unspecified))))
;;;;; ert
   `(ert-test-result-expected ((t (:foreground ,darklime-green+4))))
   `(ert-test-result-unexpected ((t (:foreground ,darklime-red))))
;;;;; eshell
   `(eshell-prompt ((t (:foreground ,darklime-yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,darklime-red-1 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment-face))))
   `(eshell-ls-directory ((t (:foreground ,darklime-blue+1 :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,darklime-red+1 :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,darklime-fg))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning-face))))
   `(eshell-ls-product ((t (:inherit font-lock-doc-face))))
   `(eshell-ls-special ((t (:foreground ,darklime-yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,darklime-cyan :weight bold))))
;;;;; flx
   `(flx-highlight-face ((t (:foreground ,darklime-green+2 :weight bold))))
;;;;; flycheck
   `(flycheck-error
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-red-1) :inherit unspecified))
      (t (:foreground ,darklime-red-1 :weight bold :underline t))))
   `(flycheck-warning
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-yellow) :inherit unspecified))
      (t (:foreground ,darklime-yellow :weight bold :underline t))))
   `(flycheck-info
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-cyan) :inherit unspecified))
      (t (:foreground ,darklime-cyan :weight bold :underline t))))
   `(flycheck-fringe-error ((t (:foreground ,darklime-red-1 :weight bold))))
   `(flycheck-fringe-warning ((t (:foreground ,darklime-yellow :weight bold))))
   `(flycheck-fringe-info ((t (:foreground ,darklime-cyan :weight bold))))
;;;;; flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-red)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,darklime-red-1 :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-orange)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,darklime-orange :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-green)
                   :inherit unspecified :foreground unspecified :background unspecified))
      (t (:foreground ,darklime-green-1 :weight bold :underline t))))
;;;;; flyspell
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-orange) :inherit unspecified))
      (t (:foreground ,darklime-orange :weight bold :underline t))))
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-red) :inherit unspecified))
      (t (:foreground ,darklime-red-1 :weight bold :underline t))))
;;;;; full-ack
   `(ack-separator ((t (:foreground ,darklime-fg))))
   `(ack-file ((t (:foreground ,darklime-blue))))
   `(ack-line ((t (:foreground ,darklime-yellow))))
   `(ack-match ((t (:foreground ,darklime-orange-1 :weight bold))))
;;;;; git-commit
   `(git-commit-comment-action  ((,class (:foreground ,darklime-green+1 :weight bold))))
   `(git-commit-comment-branch  ((,class (:foreground ,darklime-blue+1  :weight bold))))
   `(git-commit-comment-heading ((,class (:foreground ,darklime-yellow  :weight bold))))
;;;;; git-gutter
   `(git-gutter:added ((t (:foreground ,darklime-green :weight bold :inverse-video t))))
   `(git-gutter:deleted ((t (:foreground ,darklime-red :weight bold :inverse-video t))))
   `(git-gutter:modified ((t (:foreground ,darklime-magenta :weight bold :inverse-video t))))
   `(git-gutter:unchanged ((t (:foreground ,darklime-fg :weight bold :inverse-video t))))
;;;;; git-gutter-fr
   `(git-gutter-fr:added ((t (:foreground ,darklime-green  :weight bold))))
   `(git-gutter-fr:deleted ((t (:foreground ,darklime-red :weight bold))))
   `(git-gutter-fr:modified ((t (:foreground ,darklime-magenta :weight bold))))
;;;;; git-rebase
   `(git-rebase-hash ((t (:foreground, darklime-orange))))
;;;;; gnus
   `(gnus-group-mail-1 ((t (:weight bold :inherit gnus-group-mail-1-empty))))
   `(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
   `(gnus-group-mail-2 ((t (:weight bold :inherit gnus-group-mail-2-empty))))
   `(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
   `(gnus-group-mail-3 ((t (:weight bold :inherit gnus-group-mail-3-empty))))
   `(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
   `(gnus-group-mail-4 ((t (:weight bold :inherit gnus-group-mail-4-empty))))
   `(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
   `(gnus-group-mail-5 ((t (:weight bold :inherit gnus-group-mail-5-empty))))
   `(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
   `(gnus-group-mail-6 ((t (:weight bold :inherit gnus-group-mail-6-empty))))
   `(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
   `(gnus-group-mail-low ((t (:weight bold :inherit gnus-group-mail-low-empty))))
   `(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))
   `(gnus-group-news-1 ((t (:weight bold :inherit gnus-group-news-1-empty))))
   `(gnus-group-news-2 ((t (:weight bold :inherit gnus-group-news-2-empty))))
   `(gnus-group-news-3 ((t (:weight bold :inherit gnus-group-news-3-empty))))
   `(gnus-group-news-4 ((t (:weight bold :inherit gnus-group-news-4-empty))))
   `(gnus-group-news-5 ((t (:weight bold :inherit gnus-group-news-5-empty))))
   `(gnus-group-news-6 ((t (:weight bold :inherit gnus-group-news-6-empty))))
   `(gnus-group-news-low ((t (:weight bold :inherit gnus-group-news-low-empty))))
   `(gnus-header-content ((t (:inherit message-header-other))))
   `(gnus-header-from ((t (:inherit message-header-to))))
   `(gnus-header-name ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups ((t (:inherit message-header-other))))
   `(gnus-header-subject ((t (:inherit message-header-subject))))
   `(gnus-server-opened ((t (:foreground ,darklime-green+2 :weight bold))))
   `(gnus-server-denied ((t (:foreground ,darklime-red+1 :weight bold))))
   `(gnus-server-closed ((t (:foreground ,darklime-blue :slant italic))))
   `(gnus-server-offline ((t (:foreground ,darklime-yellow :weight bold))))
   `(gnus-server-agent ((t (:foreground ,darklime-blue :weight bold))))
   `(gnus-summary-cancelled ((t (:foreground ,darklime-orange))))
   `(gnus-summary-high-ancient ((t (:foreground ,darklime-blue))))
   `(gnus-summary-high-read ((t (:foreground ,darklime-green :weight bold))))
   `(gnus-summary-high-ticked ((t (:foreground ,darklime-orange :weight bold))))
   `(gnus-summary-high-unread ((t (:foreground ,darklime-fg :weight bold))))
   `(gnus-summary-low-ancient ((t (:foreground ,darklime-blue))))
   `(gnus-summary-low-read ((t (:foreground ,darklime-green))))
   `(gnus-summary-low-ticked ((t (:foreground ,darklime-orange :weight bold))))
   `(gnus-summary-low-unread ((t (:foreground ,darklime-fg))))
   `(gnus-summary-normal-ancient ((t (:foreground ,darklime-blue))))
   `(gnus-summary-normal-read ((t (:foreground ,darklime-green))))
   `(gnus-summary-normal-ticked ((t (:foreground ,darklime-orange :weight bold))))
   `(gnus-summary-normal-unread ((t (:foreground ,darklime-fg))))
   `(gnus-summary-selected ((t (:foreground ,darklime-yellow :weight bold))))
   `(gnus-cite-1 ((t (:foreground ,darklime-blue))))
   `(gnus-cite-10 ((t (:foreground ,darklime-yellow-1))))
   `(gnus-cite-11 ((t (:foreground ,darklime-yellow))))
   `(gnus-cite-2 ((t (:foreground ,darklime-blue-1))))
   `(gnus-cite-3 ((t (:foreground ,darklime-blue-2))))
   `(gnus-cite-4 ((t (:foreground ,darklime-green+2))))
   `(gnus-cite-5 ((t (:foreground ,darklime-green+1))))
   `(gnus-cite-6 ((t (:foreground ,darklime-green))))
   `(gnus-cite-7 ((t (:foreground ,darklime-red))))
   `(gnus-cite-8 ((t (:foreground ,darklime-red-1))))
   `(gnus-cite-9 ((t (:foreground ,darklime-red-2))))
   `(gnus-group-news-1-empty ((t (:foreground ,darklime-yellow))))
   `(gnus-group-news-2-empty ((t (:foreground ,darklime-green+3))))
   `(gnus-group-news-3-empty ((t (:foreground ,darklime-green+1))))
   `(gnus-group-news-4-empty ((t (:foreground ,darklime-blue-2))))
   `(gnus-group-news-5-empty ((t (:foreground ,darklime-blue-3))))
   `(gnus-group-news-6-empty ((t (:foreground ,darklime-bg+2))))
   `(gnus-group-news-low-empty ((t (:foreground ,darklime-bg+2))))
   `(gnus-signature ((t (:foreground ,darklime-yellow))))
   `(gnus-x ((t (:background ,darklime-fg :foreground ,darklime-bg))))
   `(mm-uu-extract ((t (:background ,darklime-bg-05 :foreground ,darklime-green+1))))
;;;;; guide-key
   `(guide-key/highlight-command-face ((t (:foreground ,darklime-blue))))
   `(guide-key/key-face ((t (:foreground ,darklime-green))))
   `(guide-key/prefix-command-face ((t (:foreground ,darklime-green+1))))
;;;;; helm
   `(helm-header
     ((t (:foreground ,darklime-green
                     
                      :underline nil
                      :box nil))))
   `(helm-source-header
     ((t (:foreground ,darklime-yellow
                     -1
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)))))
   `(helm-selection ((t (:background ,darklime-bg+1 :underline nil))))
   `(helm-selection-line ((t (:background ,darklime-bg+1))))
   `(helm-visible-mark ((t (:foreground ,darklime-bg :background ,darklime-yellow-2))))
   `(helm-candidate-number ((t (:foreground ,darklime-green+4-1))))
   `(helm-separator ((t (:foreground ,darklime-red))))
   `(helm-time-zone-current ((t (:foreground ,darklime-green+2))))
   `(helm-time-zone-home ((t (:foreground ,darklime-red))))
   `(helm-bookmark-addressbook ((t (:foreground ,darklime-orange))))
   `(helm-bookmark-directory ((t (:foreground nil :background nil :inherit helm-ff-directory))))
   `(helm-bookmark-file ((t (:foreground nil :background nil :inherit helm-ff-file))))
   `(helm-bookmark-gnus ((t (:foreground ,darklime-magenta))))
   `(helm-bookmark-info ((t (:foreground ,darklime-green+2))))
   `(helm-bookmark-man ((t (:foreground ,darklime-yellow))))
   `(helm-bookmark-w3m ((t (:foreground ,darklime-magenta))))
   `(helm-buffer-not-saved ((t (:foreground ,darklime-red))))
   `(helm-buffer-process ((t (:foreground ,darklime-cyan))))
   `(helm-buffer-saved-out ((t (:foreground ,darklime-fg))))
   `(helm-buffer-size ((t (:foreground ,darklime-fg-1))))
   `(helm-ff-directory ((t (:foreground ,darklime-cyan :weight bold))))
   `(helm-ff-file ((t (:foreground ,darklime-fg :weight normal))))
   `(helm-ff-executable ((t (:foreground ,darklime-green+2 :weight normal))))
   `(helm-ff-invalid-symlink ((t (:foreground ,darklime-red :weight bold))))
   `(helm-ff-symlink ((t (:foreground ,darklime-yellow :weight bold))))
   `(helm-ff-prefix ((t (:foreground ,darklime-bg :background ,darklime-yellow :weight normal))))
   `(helm-grep-cmd-line ((t (:foreground ,darklime-cyan))))
   `(helm-grep-file ((t (:foreground ,darklime-fg))))
   `(helm-grep-finish ((t (:foreground ,darklime-green+2))))
   `(helm-grep-lineno ((t (:foreground ,darklime-fg-1))))
   `(helm-grep-match ((t (:foreground nil :background nil :inherit helm-match))))
   `(helm-grep-running ((t (:foreground ,darklime-red))))
   `(helm-match ((t (:foreground ,darklime-orange-1 :weight bold))))
   `(helm-moccur-buffer ((t (:foreground ,darklime-cyan))))
   `(helm-mu-contacts-address-face ((t (:foreground ,darklime-fg-1))))
   `(helm-mu-contacts-name-face ((t (:foreground ,darklime-fg))))
;;;;; helm-swoop
   `(helm-swoop-target-line-face ((t (:foreground ,darklime-fg+1))))
   `(helm-swoop-target-word-face ((t (:foreground ,darklime-yellow+2 :weight bold))))
;;;;; hl-line-mode
   `(hl-line-face ((,class (:background ,darklime-bg-05))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,darklime-bg-05)) ; old emacsen
              (t :weight bold)))
;;;;; hl-sexp
   `(hl-sexp-face ((,class (:background ,darklime-bg+1))
                   (t :weight bold)))
;;;;; hydra
   `(hydra-face-red ((t (:foreground ,darklime-red-1))))
   `(hydra-face-amaranth ((t (:foreground ,darklime-red-3))))
   `(hydra-face-blue ((t (:foreground ,darklime-blue))))
   `(hydra-face-pink ((t (:foreground ,darklime-magenta))))
   `(hydra-face-teal ((t (:foreground ,darklime-cyan))))
;;;;; info+
   `(info-command-ref-item ((t (:background ,darklime-bg-1 :foreground ,darklime-orange))))
   `(info-constant-ref-item ((t (:background ,darklime-bg-1 :foreground ,darklime-magenta))))
   `(info-double-quoted-name ((t (:inherit font-lock-comment-face))))
   `(info-file ((t (:background ,darklime-bg-1 :foreground ,darklime-yellow))))
   `(info-function-ref-item ((t (:background ,darklime-bg-1 :inherit font-lock-function-name-face))))
   `(info-macro-ref-item ((t (:background ,darklime-bg-1 :foreground ,darklime-yellow))))
   `(info-menu ((t (:foreground ,darklime-yellow))))
   `(info-quoted-name ((t (:inherit font-lock-constant-face))))
   `(info-reference-item ((t (:background ,darklime-bg-1))))
   `(info-single-quote ((t (:inherit font-lock-keyword-face))))
   `(info-special-form-ref-item ((t (:background ,darklime-bg-1 :foreground ,darklime-yellow))))
   `(info-string ((t (:inherit font-lock-string-face))))
   `(info-syntax-class-item ((t (:background ,darklime-bg-1 :foreground ,darklime-blue+1))))
   `(info-user-option-ref-item ((t (:background ,darklime-bg-1 :foreground ,darklime-red))))
   `(info-variable-ref-item ((t (:background ,darklime-bg-1 :foreground ,darklime-orange))))
;;;;; irfc
   `(irfc-head-name-face ((t (:foreground ,darklime-red :weight bold))))
   `(irfc-head-number-face ((t (:foreground ,darklime-red :weight bold))))
   `(irfc-reference-face ((t (:foreground ,darklime-blue-1 :weight bold))))
   `(irfc-requirement-keyword-face ((t (:inherit font-lock-keyword-face))))
   `(irfc-rfc-link-face ((t (:inherit link))))
   `(irfc-rfc-number-face ((t (:foreground ,darklime-cyan :weight bold))))
   `(irfc-std-number-face ((t (:foreground ,darklime-green+4 :weight bold))))
   `(irfc-table-item-face ((t (:foreground ,darklime-green+3))))
   `(irfc-title-face ((t (:foreground ,darklime-yellow
                                      :underline t :weight bold))))
;;;;; ivy
   `(ivy-confirm-face ((t (:foreground ,darklime-green))))
   `(ivy-current-match ((t (:foreground ,darklime-yellow :weight bold :underline t))))
   `(ivy-cursor ((t (:foreground ,darklime-bg :background ,darklime-fg))))
   `(ivy-match-required-face ((t (:foreground ,darklime-red))))
   `(ivy-minibuffer-match-face-1 ((t (:background ,darklime-bg+1))))
   `(ivy-minibuffer-match-face-2 ((t (:background ,darklime-green-1))))
   `(ivy-minibuffer-match-face-3 ((t (:background ,darklime-green))))
   `(ivy-minibuffer-match-face-4 ((t (:background ,darklime-green+1))))
   `(ivy-remote ((t (:foreground ,darklime-blue))))
   `(ivy-subdir ((t (:foreground ,darklime-yellow))))
;;;;; ido-mode
   `(ido-first-match ((t (:foreground ,darklime-yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,darklime-orange :weight bold))))
   `(ido-subdir ((t (:foreground ,darklime-yellow))))
   `(ido-indicator ((t (:foreground ,darklime-yellow :background ,darklime-red-4))))
;;;;; iedit-mode
   `(iedit-occurrence ((t (:background ,darklime-bg+2 :weight bold))))
;;;;; jabber-mode
   `(jabber-roster-user-away ((t (:foreground ,darklime-green+2))))
   `(jabber-roster-user-online ((t (:foreground ,darklime-blue-1))))
   `(jabber-roster-user-dnd ((t (:foreground ,darklime-red+1))))
   `(jabber-roster-user-xa ((t (:foreground ,darklime-magenta))))
   `(jabber-roster-user-chatty ((t (:foreground ,darklime-orange))))
   `(jabber-roster-user-error ((t (:foreground ,darklime-red+1))))
   `(jabber-rare-time-face ((t (:foreground ,darklime-green+1))))
   `(jabber-chat-prompt-local ((t (:foreground ,darklime-blue-1))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,darklime-red+1))))
   `(jabber-chat-prompt-system ((t (:foreground ,darklime-green+3))))
   `(jabber-activity-face((t (:foreground ,darklime-red+1))))
   `(jabber-activity-personal-face ((t (:foreground ,darklime-blue+1))))
   `(jabber-title-small ((t (:height 1.1 :weight bold))))
   `(jabber-title-medium ((t (:height 1.2 :weight bold))))
   `(jabber-title-large ((t (:height 1.3 :weight bold))))
;;;;; js2-mode
   `(js2-warning ((t (:underline ,darklime-orange))))
   `(js2-error ((t (:foreground ,darklime-red :weight bold))))
   `(js2-jsdoc-tag ((t (:foreground ,darklime-green-1))))
   `(js2-jsdoc-type ((t (:foreground ,darklime-green+2))))
   `(js2-jsdoc-value ((t (:foreground ,darklime-green+3))))
   `(js2-function-param ((t (:foreground, darklime-orange))))
   `(js2-external-variable ((t (:foreground ,darklime-orange))))
;;;;; additional js2 mode attributes for better syntax highlighting
   `(js2-instance-member ((t (:foreground ,darklime-green-1))))
   `(js2-jsdoc-html-tag-delimiter ((t (:foreground ,darklime-orange))))
   `(js2-jsdoc-html-tag-name ((t (:foreground ,darklime-red-1))))
   `(js2-object-property ((t (:foreground ,darklime-blue+1))))
   `(js2-magic-paren ((t (:foreground ,darklime-blue-5))))
   `(js2-private-function-call ((t (:foreground ,darklime-cyan))))
   `(js2-function-call ((t (:foreground ,darklime-cyan))))
   `(js2-private-member ((t (:foreground ,darklime-blue-1))))
   `(js2-keywords ((t (:foreground ,darklime-magenta))))
;;;;; ledger-mode
   `(ledger-font-payee-uncleared-face ((t (:foreground ,darklime-red-1 :weight bold))))
   `(ledger-font-payee-cleared-face ((t (:foreground ,darklime-fg :weight normal))))
   `(ledger-font-payee-pending-face ((t (:foreground ,darklime-red :weight normal))))
   `(ledger-font-xact-highlight-face ((t (:background ,darklime-bg+1))))
   `(ledger-font-auto-xact-face ((t (:foreground ,darklime-yellow-1 :weight normal))))
   `(ledger-font-periodic-xact-face ((t (:foreground ,darklime-green :weight normal))))
   `(ledger-font-pending-face ((t (:foreground ,darklime-orange weight: normal))))
   `(ledger-font-other-face ((t (:foreground ,darklime-fg))))
   `(ledger-font-posting-date-face ((t (:foreground ,darklime-orange :weight normal))))
   `(ledger-font-posting-account-face ((t (:foreground ,darklime-blue-1))))
   `(ledger-font-posting-account-cleared-face ((t (:foreground ,darklime-fg))))
   `(ledger-font-posting-account-pending-face ((t (:foreground ,darklime-orange))))
   `(ledger-font-posting-amount-face ((t (:foreground ,darklime-orange))))
   `(ledger-occur-narrowed-face ((t (:foreground ,darklime-fg-1 :invisible t))))
   `(ledger-occur-xact-face ((t (:background ,darklime-bg+1))))
   `(ledger-font-comment-face ((t (:foreground ,darklime-green))))
   `(ledger-font-reconciler-uncleared-face ((t (:foreground ,darklime-red-1 :weight bold))))
   `(ledger-font-reconciler-cleared-face ((t (:foreground ,darklime-fg :weight normal))))
   `(ledger-font-reconciler-pending-face ((t (:foreground ,darklime-orange :weight normal))))
   `(ledger-font-report-clickable-face ((t (:foreground ,darklime-orange :weight normal))))
;;;;; linum-mode
   `(linum ((t (:foreground ,darklime-green+2))))
;;;;; lispy
   `(lispy-command-name-face ((t (:background ,darklime-bg-05 :inherit font-lock-function-name-face))))
   `(lispy-cursor-face ((t (:foreground ,darklime-bg :background ,darklime-fg))))
   `(lispy-face-hint ((t (:inherit highlight :foreground ,darklime-yellow))))
;;;;; ruler-mode
   `(ruler-mode-column-number ((t (:inherit 'ruler-mode-default :foreground ,darklime-fg))))
   `(ruler-mode-fill-column ((t (:inherit 'ruler-mode-default :foreground ,darklime-yellow))))
   `(ruler-mode-goal-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-comment-column ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-tab-stop ((t (:inherit 'ruler-mode-fill-column))))
   `(ruler-mode-current-column ((t (:foreground ,darklime-yellow :box t))))
   `(ruler-mode-default ((t (:foreground ,darklime-green+2))))

;;;;; lui
   `(lui-time-stamp-face ((t (:foreground ,darklime-blue-1))))
   `(lui-hilight-face ((t (:foreground ,darklime-green+2))))
   `(lui-button-face ((t (:inherit hover-highlight))))
;;;;; macrostep
   `(macrostep-gensym-1
     ((t (:foreground ,darklime-green+2-1))))
   `(macrostep-gensym-2
     ((t (:foreground ,darklime-red+1-1))))
   `(macrostep-gensym-3
     ((t (:foreground ,darklime-blue+1-1))))
   `(macrostep-gensym-4
     ((t (:foreground ,darklime-magenta-1))))
   `(macrostep-gensym-5
     ((t (:foreground ,darklime-yellow-1))))
   `(macrostep-expansion-highlight-face
     ((t (:inherit highlight))))
   `(macrostep-macro-face
     ((t (:underline t))))
;;;;; magit
;;;;;; headings and diffs
   `(magit-section-highlight           ((t (:background ,darklime-bg+05))))
   `(magit-section-heading             ((t (:foreground ,darklime-yellow :weight bold))))
   `(magit-section-heading-selection   ((t (:foreground ,darklime-orange :weight bold))))
   `(magit-diff-file-heading           ((t (:weight bold))))
   `(magit-diff-file-heading-highlight ((t (:background ,darklime-bg+05  :weight bold))))
   `(magit-diff-file-heading-selection ((t (:background ,darklime-bg+05
                                                        :foreground ,darklime-orange :weight bold))))
   `(magit-diff-hunk-heading           ((t (:background ,darklime-bg+1))))
   `(magit-diff-hunk-heading-highlight ((t (:background ,darklime-bg+2))))
   `(magit-diff-hunk-heading-selection ((t (:background ,darklime-bg+2
                                                        :foreground ,darklime-orange))))
   `(magit-diff-lines-heading          ((t (:background ,darklime-orange
                                                        :foreground ,darklime-bg+2))))
   `(magit-diff-context-highlight      ((t (:background ,darklime-bg+05
                                                        :foreground "grey70"))))
   `(magit-diffstat-added   ((t (:foreground ,darklime-green+4))))
   `(magit-diffstat-removed ((t (:foreground ,darklime-red))))
;;;;;; popup
   `(magit-popup-heading             ((t (:foreground ,darklime-yellow  :weight bold))))
   `(magit-popup-key                 ((t (:foreground ,darklime-green-1 :weight bold))))
   `(magit-popup-argument            ((t (:foreground ,darklime-green   :weight bold))))
   `(magit-popup-disabled-argument   ((t (:foreground ,darklime-fg-1    :weight normal))))
   `(magit-popup-option-value        ((t (:foreground ,darklime-blue-2  :weight bold))))
;;;;;; process
   `(magit-process-ok    ((t (:foreground ,darklime-green  :weight bold))))
   `(magit-process-ng    ((t (:foreground ,darklime-red    :weight bold))))
;;;;;; log
   `(magit-log-author    ((t (:foreground ,darklime-orange))))
   `(magit-log-date      ((t (:foreground ,darklime-fg-1))))
   `(magit-log-graph     ((t (:foreground ,darklime-fg+1))))
;;;;;; sequence
   `(magit-sequence-pick ((t (:foreground ,darklime-yellow-2))))
   `(magit-sequence-stop ((t (:foreground ,darklime-green))))
   `(magit-sequence-part ((t (:foreground ,darklime-yellow))))
   `(magit-sequence-head ((t (:foreground ,darklime-blue))))
   `(magit-sequence-drop ((t (:foreground ,darklime-red))))
   `(magit-sequence-done ((t (:foreground ,darklime-fg-1))))
   `(magit-sequence-onto ((t (:foreground ,darklime-fg-1))))
;;;;;; bisect
   `(magit-bisect-good ((t (:foreground ,darklime-green))))
   `(magit-bisect-skip ((t (:foreground ,darklime-yellow))))
   `(magit-bisect-bad  ((t (:foreground ,darklime-red))))
;;;;;; blame
   `(magit-blame-heading ((t (:background ,darklime-bg-1 :foreground ,darklime-blue-2))))
   `(magit-blame-hash    ((t (:background ,darklime-bg-1 :foreground ,darklime-blue-2))))
   `(magit-blame-name    ((t (:background ,darklime-bg-1 :foreground ,darklime-orange))))
   `(magit-blame-date    ((t (:background ,darklime-bg-1 :foreground ,darklime-orange))))
   `(magit-blame-summary ((t (:background ,darklime-bg-1 :foreground ,darklime-blue-2
                                          :weight bold))))
;;;;;; references etc
   `(magit-dimmed         ((t (:foreground ,darklime-bg+3))))
   `(magit-hash           ((t (:foreground ,darklime-bg+3))))
   `(magit-tag            ((t (:foreground ,darklime-orange :weight bold))))
   `(magit-branch-remote  ((t (:foreground ,darklime-green  :weight bold))))
   `(magit-branch-local   ((t (:foreground ,darklime-blue   :weight bold))))
   `(magit-branch-current ((t (:foreground ,darklime-blue   :weight bold :box t))))
   `(magit-head           ((t (:foreground ,darklime-blue   :weight bold))))
   `(magit-refname        ((t (:background ,darklime-bg+2 :foreground ,darklime-fg :weight bold))))
   `(magit-refname-stash  ((t (:background ,darklime-bg+2 :foreground ,darklime-fg :weight bold))))
   `(magit-refname-wip    ((t (:background ,darklime-bg+2 :foreground ,darklime-fg :weight bold))))
   `(magit-signature-good      ((t (:foreground ,darklime-green))))
   `(magit-signature-bad       ((t (:foreground ,darklime-red))))
   `(magit-signature-untrusted ((t (:foreground ,darklime-yellow))))
   `(magit-cherry-unmatched    ((t (:foreground ,darklime-cyan))))
   `(magit-cherry-equivalent   ((t (:foreground ,darklime-magenta))))
   `(magit-reflog-commit       ((t (:foreground ,darklime-green))))
   `(magit-reflog-amend        ((t (:foreground ,darklime-magenta))))
   `(magit-reflog-merge        ((t (:foreground ,darklime-green))))
   `(magit-reflog-checkout     ((t (:foreground ,darklime-blue))))
   `(magit-reflog-reset        ((t (:foreground ,darklime-red))))
   `(magit-reflog-rebase       ((t (:foreground ,darklime-magenta))))
   `(magit-reflog-cherry-pick  ((t (:foreground ,darklime-green))))
   `(magit-reflog-remote       ((t (:foreground ,darklime-cyan))))
   `(magit-reflog-other        ((t (:foreground ,darklime-cyan))))
;;;;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment-face))))
   `(message-header-name ((t (:foreground ,darklime-green+1))))
   `(message-header-other ((t (:foreground ,darklime-green))))
   `(message-header-to ((t (:foreground ,darklime-yellow :weight bold))))
   `(message-header-cc ((t (:foreground ,darklime-yellow :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,darklime-yellow :weight bold))))
   `(message-header-subject ((t (:foreground ,darklime-orange :weight bold))))
   `(message-header-xheader ((t (:foreground ,darklime-green))))
   `(message-mml ((t (:foreground ,darklime-yellow :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment-face))))
;;;;; mew
   `(mew-face-header-subject ((t (:foreground ,darklime-orange))))
   `(mew-face-header-from ((t (:foreground ,darklime-yellow))))
   `(mew-face-header-date ((t (:foreground ,darklime-green))))
   `(mew-face-header-to ((t (:foreground ,darklime-red))))
   `(mew-face-header-key ((t (:foreground ,darklime-green))))
   `(mew-face-header-private ((t (:foreground ,darklime-green))))
   `(mew-face-header-important ((t (:foreground ,darklime-blue))))
   `(mew-face-header-marginal ((t (:foreground ,darklime-fg :weight bold))))
   `(mew-face-header-warning ((t (:foreground ,darklime-red))))
   `(mew-face-header-xmew ((t (:foreground ,darklime-green))))
   `(mew-face-header-xmew-bad ((t (:foreground ,darklime-red))))
   `(mew-face-body-url ((t (:foreground ,darklime-orange))))
   `(mew-face-body-comment ((t (:foreground ,darklime-fg :slant italic))))
   `(mew-face-body-cite1 ((t (:foreground ,darklime-green))))
   `(mew-face-body-cite2 ((t (:foreground ,darklime-blue))))
   `(mew-face-body-cite3 ((t (:foreground ,darklime-orange))))
   `(mew-face-body-cite4 ((t (:foreground ,darklime-yellow))))
   `(mew-face-body-cite5 ((t (:foreground ,darklime-red))))
   `(mew-face-mark-review ((t (:foreground ,darklime-blue))))
   `(mew-face-mark-escape ((t (:foreground ,darklime-green))))
   `(mew-face-mark-delete ((t (:foreground ,darklime-red))))
   `(mew-face-mark-unlink ((t (:foreground ,darklime-yellow))))
   `(mew-face-mark-refile ((t (:foreground ,darklime-green))))
   `(mew-face-mark-unread ((t (:foreground ,darklime-red-2))))
   `(mew-face-eof-message ((t (:foreground ,darklime-green))))
   `(mew-face-eof-part ((t (:foreground ,darklime-yellow))))
;;;;; mic-paren
   `(paren-face-match ((t (:foreground ,darklime-cyan :weight bold))))
   `(paren-face-mismatch ((t (:foreground ,darklime-bg :background ,darklime-magenta :weight bold))))
   `(paren-face-no-match ((t (:foreground ,darklime-bg :background ,darklime-red :weight bold))))
;;;;; mingus
   `(mingus-directory-face ((t (:foreground ,darklime-blue))))
   `(mingus-pausing-face ((t (:foreground ,darklime-magenta))))
   `(mingus-playing-face ((t (:foreground ,darklime-cyan))))
   `(mingus-playlist-face ((t (:foreground ,darklime-cyan ))))
   `(mingus-mark-face ((t (:bold t :foreground ,darklime-magenta))))
   `(mingus-song-file-face ((t (:foreground ,darklime-yellow))))
   `(mingus-artist-face ((t (:foreground ,darklime-cyan))))
   `(mingus-album-face ((t (:underline t :foreground ,darklime-red+1))))
   `(mingus-album-stale-face ((t (:foreground ,darklime-red+1))))
   `(mingus-stopped-face ((t (:foreground ,darklime-red))))
;;;;; nav
   `(nav-face-heading ((t (:foreground ,darklime-yellow))))
   `(nav-face-button-num ((t (:foreground ,darklime-cyan))))
   `(nav-face-dir ((t (:foreground ,darklime-green))))
   `(nav-face-hdir ((t (:foreground ,darklime-red))))
   `(nav-face-file ((t (:foreground ,darklime-fg))))
   `(nav-face-hfile ((t (:foreground ,darklime-red-4))))
;;;;; merlin
   `(merlin-type-face ((t (:inherit highlight))))
   `(merlin-compilation-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-orange)))
      (t
       (:underline ,darklime-orange))))
   `(merlin-compilation-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-red)))
      (t
       (:underline ,darklime-red))))
;;;;; mu4e
   `(mu4e-cited-1-face ((t (:foreground ,darklime-blue    :slant italic))))
   `(mu4e-cited-2-face ((t (:foreground ,darklime-green+2 :slant italic))))
   `(mu4e-cited-3-face ((t (:foreground ,darklime-blue-2  :slant italic))))
   `(mu4e-cited-4-face ((t (:foreground ,darklime-green   :slant italic))))
   `(mu4e-cited-5-face ((t (:foreground ,darklime-blue-4  :slant italic))))
   `(mu4e-cited-6-face ((t (:foreground ,darklime-green-1 :slant italic))))
   `(mu4e-cited-7-face ((t (:foreground ,darklime-blue    :slant italic))))
   `(mu4e-replied-face ((t (:foreground ,darklime-bg+3))))
   `(mu4e-trashed-face ((t (:foreground ,darklime-bg+3 :strike-through t))))
;;;;; mumamo
   `(mumamo-background-chunk-major ((t (:background nil))))
   `(mumamo-background-chunk-submode1 ((t (:background ,darklime-bg-1))))
   `(mumamo-background-chunk-submode2 ((t (:background ,darklime-bg+2))))
   `(mumamo-background-chunk-submode3 ((t (:background ,darklime-bg+3))))
   `(mumamo-background-chunk-submode4 ((t (:background ,darklime-bg+1))))
;;;;; neotree
   `(neo-banner-face ((t (:foreground ,darklime-blue+1 :weight bold))))
   `(neo-header-face ((t (:foreground ,darklime-fg))))
   `(neo-root-dir-face ((t (:foreground ,darklime-blue+1 :weight bold))))
   `(neo-dir-link-face ((t (:foreground ,darklime-blue))))
   `(neo-file-link-face ((t (:foreground ,darklime-fg))))
   `(neo-expand-btn-face ((t (:foreground ,darklime-blue))))
   `(neo-vc-default-face ((t (:foreground ,darklime-fg+1))))
   `(neo-vc-user-face ((t (:foreground ,darklime-red :slant italic))))
   `(neo-vc-up-to-date-face ((t (:foreground ,darklime-fg))))
   `(neo-vc-edited-face ((t (:foreground ,darklime-magenta))))
   `(neo-vc-needs-merge-face ((t (:foreground ,darklime-red+1))))
   `(neo-vc-unlocked-changes-face ((t (:foreground ,darklime-red :background ,darklime-blue-5))))
   `(neo-vc-added-face ((t (:foreground ,darklime-green+1))))
   `(neo-vc-conflict-face ((t (:foreground ,darklime-red+1))))
   `(neo-vc-missing-face ((t (:foreground ,darklime-red+1))))
   `(neo-vc-ignored-face ((t (:foreground ,darklime-fg-1))))
;;;;; org-mode
   `(org-agenda-date-today
     ((t (:foreground ,darklime-fg+1 :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,darklime-fg :weight bold))))
   `(org-checkbox ((t (:background ,darklime-bg+2 :foreground ,darklime-fg+1
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,darklime-blue :underline t))))
   `(org-deadline-announce ((t (:foreground ,darklime-red-1))))
   `(org-done ((t (:weight bold :weight bold :foreground ,darklime-green+3))))
   `(org-formula ((t (:foreground ,darklime-yellow-2))))
   `(org-headline-done ((t (:foreground ,darklime-green+3))))
   `(org-hide ((t (:foreground ,darklime-bg-1))))
   `(org-level-1 ((t (:foreground ,darklime-orange))))
   `(org-level-2 ((t (:foreground ,darklime-green+4))))
   `(org-level-3 ((t (:foreground ,darklime-blue-1))))
   `(org-level-4 ((t (:foreground ,darklime-yellow-2))))
   `(org-level-5 ((t (:foreground ,darklime-cyan))))
   `(org-level-6 ((t (:foreground ,darklime-green+2))))
   `(org-level-7 ((t (:foreground ,darklime-red-4))))
   `(org-level-8 ((t (:foreground ,darklime-blue-4))))
   `(org-link ((t (:foreground ,darklime-yellow-2 :underline t))))
   `(org-scheduled ((t (:foreground ,darklime-green+4))))
   `(org-scheduled-previously ((t (:foreground ,darklime-red))))
   `(org-scheduled-today ((t (:foreground ,darklime-blue+1))))
   `(org-sexp-date ((t (:foreground ,darklime-blue+1 :underline t))))
   `(org-special-keyword ((t (:inherit font-lock-comment-face))))
   `(org-table ((t (:foreground ,darklime-green+2))))
   `(org-tag ((t (:weight bold :weight bold))))
   `(org-time-grid ((t (:foreground ,darklime-orange))))
   `(org-todo ((t (:weight bold :foreground ,darklime-red :weight bold))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:weight bold :foreground ,darklime-red :weight bold :underline nil))))
   `(org-column ((t (:background ,darklime-bg-1))))
   `(org-column-title ((t (:background ,darklime-bg-1 :underline t :weight bold))))
   `(org-mode-line-clock ((t (:foreground ,darklime-fg-1))))
   `(org-mode-line-clock-overrun ((t (:foreground ,darklime-bg :background ,darklime-red-1))))
   `(org-ellipsis ((t (:foreground ,darklime-yellow-1 :underline t))))
   `(org-footnote ((t (:foreground ,darklime-cyan :underline t))))
   `(org-document-title ((t (:foreground ,darklime-blue))))
   `(org-document-info ((t (:foreground ,darklime-blue))))
   `(org-habit-ready-face ((t :background ,darklime-green)))
   `(org-habit-alert-face ((t :background ,darklime-yellow-1 :foreground ,darklime-bg)))
   `(org-habit-clear-face ((t :background ,darklime-blue-3)))
   `(org-habit-overdue-face ((t :background ,darklime-red-3)))
   `(org-habit-clear-future-face ((t :background ,darklime-blue-4)))
   `(org-habit-ready-future-face ((t :background ,darklime-green-1)))
   `(org-habit-alert-future-face ((t :background ,darklime-yellow-2 :foreground ,darklime-bg)))
   `(org-habit-overdue-future-face ((t :background ,darklime-red-4)))
;;;;; outline
   `(outline-1 ((t (:foreground ,darklime-orange))))
   `(outline-2 ((t (:foreground ,darklime-green+4))))
   `(outline-3 ((t (:foreground ,darklime-blue-1))))
   `(outline-4 ((t (:foreground ,darklime-yellow-2))))
   `(outline-5 ((t (:foreground ,darklime-cyan))))
   `(outline-6 ((t (:foreground ,darklime-green+2))))
   `(outline-7 ((t (:foreground ,darklime-red-4))))
   `(outline-8 ((t (:foreground ,darklime-blue-4))))
;;;;; p4
   `(p4-depot-added-face ((t :inherit diff-added)))
   `(p4-depot-branch-op-face ((t :inherit diff-changed)))
   `(p4-depot-deleted-face ((t :inherit diff-removed)))
   `(p4-depot-unmapped-face ((t :inherit diff-changed)))
   `(p4-diff-change-face ((t :inherit diff-changed)))
   `(p4-diff-del-face ((t :inherit diff-removed)))
   `(p4-diff-file-face ((t :inherit diff-file-header)))
   `(p4-diff-head-face ((t :inherit diff-header)))
   `(p4-diff-ins-face ((t :inherit diff-added)))
;;;;; perspective
   `(persp-selected-face ((t (:foreground ,darklime-yellow-2 :inherit mode-line))))
;;;;; powerline
   `(powerline-active1 ((t (:background ,darklime-bg-05 :inherit mode-line))))
   `(powerline-active2 ((t (:background ,darklime-bg+2 :inherit mode-line))))
   `(powerline-inactive1 ((t (:background ,darklime-bg+1 :inherit mode-line-inactive))))
   `(powerline-inactive2 ((t (:background ,darklime-bg+3 :inherit mode-line-inactive))))
;;;;; proofgeneral
   `(proof-active-area-face ((t (:underline t))))
   `(proof-boring-face ((t (:foreground ,darklime-fg+2))))
   `(proof-command-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-debug-message-face ((t (:inherit proof-boring-face))))
   `(proof-declaration-name-face ((t (:inherit font-lock-keyword-face :foreground nil))))
   `(proof-eager-annotation-face ((t (:foreground ,darklime-bg :background ,darklime-orange))))
   `(proof-error-face ((t (:foreground ,darklime-fg :background ,darklime-red-4))))
   `(proof-highlight-dependency-face ((t (:foreground ,darklime-bg :background ,darklime-yellow-1))))
   `(proof-highlight-dependent-face ((t (:foreground ,darklime-bg :background ,darklime-orange))))
   `(proof-locked-face ((t (:background ,darklime-blue-5))))
   `(proof-mouse-highlight-face ((t (:foreground ,darklime-bg :background ,darklime-orange))))
   `(proof-queue-face ((t (:background ,darklime-red-4))))
   `(proof-region-mouse-highlight-face ((t (:inherit proof-mouse-highlight-face))))
   `(proof-script-highlight-error-face ((t (:background ,darklime-red-2))))
   `(proof-tacticals-name-face ((t (:inherit font-lock-constant-face :foreground nil))))
   `(proof-tactics-name-face ((t (:inherit font-lock-constant-face :foreground nil))))
   `(proof-warning-face ((t (:foreground ,darklime-bg :background ,darklime-yellow-1))))
;;;;; racket-mode
   `(racket-keyword-argument-face ((t (:inherit font-lock-constant-face))))
   `(racket-selfeval-face ((t (:inherit font-lock-type-face))))
;;;;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,darklime-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,darklime-green+4))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,darklime-yellow-2))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,darklime-cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,darklime-green+2))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,darklime-blue+1))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,darklime-yellow-1))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,darklime-green+1))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,darklime-blue-2))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,darklime-orange))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,darklime-green))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,darklime-blue-5))))
;;;;; rcirc
   `(rcirc-my-nick ((t (:foreground ,darklime-blue))))
   `(rcirc-other-nick ((t (:foreground ,darklime-orange))))
   `(rcirc-bright-nick ((t (:foreground ,darklime-blue+1))))
   `(rcirc-dim-nick ((t (:foreground ,darklime-blue-2))))
   `(rcirc-server ((t (:foreground ,darklime-green))))
   `(rcirc-server-prefix ((t (:foreground ,darklime-green+1))))
   `(rcirc-timestamp ((t (:foreground ,darklime-green+2))))
   `(rcirc-nick-in-message ((t (:foreground ,darklime-yellow))))
   `(rcirc-nick-in-message-full-line ((t (:weight bold))))
   `(rcirc-prompt ((t (:foreground ,darklime-yellow :weight bold))))
   `(rcirc-track-nick ((t (:inverse-video t))))
   `(rcirc-track-keyword ((t (:weight bold))))
   `(rcirc-url ((t (:weight bold))))
   `(rcirc-keyword ((t (:foreground ,darklime-yellow :weight bold))))
;;;;; re-builder
   `(reb-match-0 ((t (:foreground ,darklime-bg :background ,darklime-magenta))))
   `(reb-match-1 ((t (:foreground ,darklime-bg :background ,darklime-blue))))
   `(reb-match-2 ((t (:foreground ,darklime-bg :background ,darklime-orange))))
   `(reb-match-3 ((t (:foreground ,darklime-bg :background ,darklime-red))))
;;;;; regex-tool
   `(regex-tool-matched-face ((t (:background ,darklime-blue-4 :weight bold))))
;;;;; rpm-mode
   `(rpm-spec-dir-face ((t (:foreground ,darklime-green))))
   `(rpm-spec-doc-face ((t (:foreground ,darklime-green))))
   `(rpm-spec-ghost-face ((t (:foreground ,darklime-red))))
   `(rpm-spec-macro-face ((t (:foreground ,darklime-yellow))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground ,darklime-red))))
   `(rpm-spec-package-face ((t (:foreground ,darklime-red))))
   `(rpm-spec-section-face ((t (:foreground ,darklime-yellow))))
   `(rpm-spec-tag-face ((t (:foreground ,darklime-blue))))
   `(rpm-spec-var-face ((t (:foreground ,darklime-red))))
;;;;; rst-mode
   `(rst-level-1-face ((t (:foreground ,darklime-orange))))
   `(rst-level-2-face ((t (:foreground ,darklime-green+1))))
   `(rst-level-3-face ((t (:foreground ,darklime-blue-1))))
   `(rst-level-4-face ((t (:foreground ,darklime-yellow-2))))
   `(rst-level-5-face ((t (:foreground ,darklime-cyan))))
   `(rst-level-6-face ((t (:foreground ,darklime-green-1))))
;;;;; sh-mode
   `(sh-heredoc     ((t (:foreground ,darklime-yellow :weight bold))))
   `(sh-quoted-exec ((t (:foreground ,darklime-red))))
;;;;; show-paren
   `(show-paren-mismatch ((t (:foreground ,darklime-red+1+3 :weight bold))))
   `(show-paren-match ((t (:background ,darklime-bg+3 :weight bold))))
;;;;; smart-mode-line
   ;; use (setq sml/theme nil) to enable Darklime for sml
   `(sml/global ((,class (:foreground ,darklime-fg :weight bold))))
   `(sml/modes ((,class (:foreground ,darklime-yellow :weight bold))))
   `(sml/minor-modes ((,class (:foreground ,darklime-fg-1 :weight bold))))
   `(sml/filename ((,class (:foreground ,darklime-yellow :weight bold))))
   `(sml/line-number ((,class (:foreground ,darklime-blue :weight bold))))
   `(sml/col-number ((,class (:foreground ,darklime-blue+1 :weight bold))))
   `(sml/position-percentage ((,class (:foreground ,darklime-blue-1 :weight bold))))
   `(sml/prefix ((,class (:foreground ,darklime-orange))))
   `(sml/git ((,class (:foreground ,darklime-green+3))))
   `(sml/process ((,class (:weight bold))))
   `(sml/sudo ((,class  (:foreground ,darklime-orange :weight bold))))
   `(sml/read-only ((,class (:foreground ,darklime-red-2))))
   `(sml/outside-modified ((,class (:foreground ,darklime-orange))))
   `(sml/modified ((,class (:foreground ,darklime-red))))
   `(sml/vc-edited ((,class (:foreground ,darklime-green+2))))
   `(sml/charging ((,class (:foreground ,darklime-green+4))))
   `(sml/discharging ((,class (:foreground ,darklime-red+1))))
;;;;; smartparens
   `(sp-show-pair-mismatch-face ((t (:foreground ,darklime-red+1+3 :weight bold))))
   `(sp-show-pair-match-face ((t (:background ,darklime-bg+3 :weight bold))))
;;;;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))
;;;;; SLIME
   `(slime-repl-output-face ((t (:foreground ,darklime-red))))
   `(slime-repl-inputed-output-face ((t (:foreground ,darklime-green))))
   `(slime-error-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-red)))
      (t
       (:underline ,darklime-red))))
   `(slime-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-orange)))
      (t
       (:underline ,darklime-orange))))
   `(slime-style-warning-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-yellow)))
      (t
       (:underline ,darklime-yellow))))
   `(slime-note-face
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,darklime-green)))
      (t
       (:underline ,darklime-green))))
   `(slime-highlight-face ((t (:inherit highlight))))
;;;;; speedbar
   `(speedbar-button-face ((t (:foreground ,darklime-green+2))))
   `(speedbar-directory-face ((t (:foreground ,darklime-cyan))))
   `(speedbar-file-face ((t (:foreground ,darklime-fg))))
   `(speedbar-highlight-face ((t (:foreground ,darklime-bg :background ,darklime-green+2))))
   `(speedbar-selected-face ((t (:foreground ,darklime-red))))
   `(speedbar-separator-face ((t (:foreground ,darklime-bg :background ,darklime-blue-1))))
   `(speedbar-tag-face ((t (:foreground ,darklime-yellow))))
;;;;; tabbar
   `(tabbar-button ((t (:foreground ,darklime-fg
                                   ))))
   `(tabbar-selected ((t (:foreground ,darklime-fg
                                     
                                      :box (:line-width -1 :style pressed-button)))))
   `(tabbar-unselected ((t (:foreground ,darklime-fg
                                       +1
                                        :box (:line-width -1 :style released-button)))))
;;;;; term
   `(term-color-black ((t (:foreground ,darklime-bg
                                      -1))))
   `(term-color-red ((t (:foreground ,darklime-red-2
                                     :background ,darklime-red-4))))
   `(term-color-green ((t (:foreground ,darklime-green
                                       :background ,darklime-green+2))))
   `(term-color-yellow ((t (:foreground ,darklime-orange
                                        :background ,darklime-yellow))))
   `(term-color-blue ((t (:foreground ,darklime-blue-1
                                      :background ,darklime-blue-4))))
   `(term-color-magenta ((t (:foreground ,darklime-magenta
                                         :background ,darklime-red))))
   `(term-color-cyan ((t (:foreground ,darklime-cyan
                                      :background ,darklime-blue))))
   `(term-color-white ((t (:foreground ,darklime-fg
                                       :background ,darklime-fg-1))))
   '(term-default-fg-color ((t (:inherit term-color-white))))
   '(term-default-bg-color ((t (:inherit term-color-black))))
;;;;; undo-tree
   `(undo-tree-visualizer-active-branch-face ((t (:foreground ,darklime-fg+1 :weight bold))))
   `(undo-tree-visualizer-current-face ((t (:foreground ,darklime-red-1 :weight bold))))
   `(undo-tree-visualizer-default-face ((t (:foreground ,darklime-fg))))
   `(undo-tree-visualizer-register-face ((t (:foreground ,darklime-yellow))))
   `(undo-tree-visualizer-unmodified-face ((t (:foreground ,darklime-cyan))))
;;;;; visual-regexp
   `(vr/group-0 ((t (:foreground ,darklime-bg :background ,darklime-green :weight bold))))
   `(vr/group-1 ((t (:foreground ,darklime-bg :background ,darklime-orange :weight bold))))
   `(vr/group-2 ((t (:foreground ,darklime-bg :background ,darklime-blue :weight bold))))
   `(vr/match-0 ((t (:inherit isearch))))
   `(vr/match-1 ((t (:foreground ,darklime-yellow-2-1 :weight bold))))
   `(vr/match-separator-face ((t (:foreground ,darklime-red :weight bold))))
;;;;; volatile-highlights
   `(vhl/default-face ((t (:background ,darklime-bg-05))))
;;;;; web-mode
   `(web-mode-builtin-face ((t (:inherit ,font-lock-builtin-face))))
   `(web-mode-comment-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-constant-face ((t (:inherit ,font-lock-constant-face))))
   `(web-mode-css-at-rule-face ((t (:foreground ,darklime-orange ))))
   `(web-mode-css-prop-face ((t (:foreground ,darklime-orange))))
   `(web-mode-css-pseudo-class-face ((t (:foreground ,darklime-green+3 :weight bold))))
   `(web-mode-css-rule-face ((t (:foreground ,darklime-blue))))
   `(web-mode-doctype-face ((t (:inherit ,font-lock-comment-face))))
   `(web-mode-folded-face ((t (:underline t))))
   `(web-mode-function-name-face ((t (:foreground ,darklime-blue))))
   `(web-mode-html-attr-name-face ((t (:foreground ,darklime-orange))))
   `(web-mode-html-attr-value-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-html-tag-face ((t (:foreground ,darklime-cyan))))
   `(web-mode-keyword-face ((t (:inherit ,font-lock-keyword-face))))
   `(web-mode-preprocessor-face ((t (:inherit ,font-lock-preprocessor-face))))
   `(web-mode-string-face ((t (:inherit ,font-lock-string-face))))
   `(web-mode-type-face ((t (:inherit ,font-lock-type-face))))
   `(web-mode-variable-name-face ((t (:inherit ,font-lock-variable-name-face))))
   `(web-mode-server-background-face ((t (:background ,darklime-bg))))
   `(web-mode-server-comment-face ((t (:inherit web-mode-comment-face))))
   `(web-mode-server-string-face ((t (:inherit web-mode-string-face))))
   `(web-mode-symbol-face ((t (:inherit font-lock-constant-face))))
   `(web-mode-warning-face ((t (:inherit font-lock-warning-face))))
   `(web-mode-whitespaces-face ((t (:background ,darklime-red))))
;;;;; whitespace-mode
   `(whitespace-space ((t (:background ,darklime-bg+1 :foreground ,darklime-bg+1))))
   `(whitespace-hspace ((t (:background ,darklime-bg+1 :foreground ,darklime-bg+1))))
   `(whitespace-tab ((t (:background ,darklime-red-1))))
   `(whitespace-newline ((t (:foreground ,darklime-bg+1))))
   `(whitespace-trailing ((t (:background ,darklime-red))))
   `(whitespace-line ((t (:background ,darklime-bg :foreground ,darklime-magenta))))
   `(whitespace-space-before-tab ((t (:background ,darklime-orange :foreground ,darklime-orange))))
   `(whitespace-indentation ((t (:background ,darklime-yellow :foreground ,darklime-red))))
   `(whitespace-empty ((t (:background ,darklime-yellow))))
   `(whitespace-space-after-tab ((t (:background ,darklime-yellow :foreground ,darklime-red))))
;;;;; wanderlust
   `(wl-highlight-folder-few-face ((t (:foreground ,darklime-red-2))))
   `(wl-highlight-folder-many-face ((t (:foreground ,darklime-red-1))))
   `(wl-highlight-folder-path-face ((t (:foreground ,darklime-orange))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,darklime-blue))))
   `(wl-highlight-folder-zero-face ((t (:foreground ,darklime-fg))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,darklime-blue))))
   `(wl-highlight-message-citation-header ((t (:foreground ,darklime-red-1))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,darklime-red))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,darklime-green+2))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,darklime-blue))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,darklime-blue+1))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,darklime-green))))
   `(wl-highlight-message-headers-face ((t (:foreground ,darklime-red+1))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,darklime-green+2))))
   `(wl-highlight-message-header-contents ((t (:foreground ,darklime-green+1))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,darklime-green+2))))
   `(wl-highlight-message-signature ((t (:foreground ,darklime-green))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,darklime-fg))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,darklime-blue))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,darklime-fg
                                                         :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,darklime-blue))))
   `(wl-highlight-summary-normal-face ((t (:foreground ,darklime-fg))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,darklime-yellow))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,darklime-magenta))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,darklime-fg))))
   `(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))
;;;;; which-func-mode
   `(which-func ((t (:foreground ,darklime-green+4))))
;;;;; xcscope
   `(cscope-file-face ((t (:foreground ,darklime-yellow :weight bold))))
   `(cscope-function-face ((t (:foreground ,darklime-cyan :weight bold))))
   `(cscope-line-number-face ((t (:foreground ,darklime-red :weight bold))))
   `(cscope-mouse-face ((t (:foreground ,darklime-bg :background ,darklime-blue+1))))
   `(cscope-separator-face ((t (:foreground ,darklime-red :weight bold
                                            :underline t :overline t))))
;;;;; yascroll
   `(yascroll:thumb-text-area ((t (:background ,darklime-bg-1))))
   `(yascroll:thumb-fringe ((t (:background ,darklime-bg-1 :foreground ,darklime-bg-1))))
   ))

;;; Theme Variables
(darklime-with-color-variables
  (custom-theme-set-variables
   'darklime
;;;;; ansi-color
   `(ansi-color-names-vector [,darklime-bg ,darklime-red ,darklime-green ,darklime-yellow
                                          ,darklime-blue ,darklime-magenta ,darklime-cyan ,darklime-fg])
;;;;; fill-column-indicator
   `(fci-rule-color ,darklime-bg-05)
;;;;; nrepl-client
   `(nrepl-message-colors
     '(,darklime-red ,darklime-orange ,darklime-yellow ,darklime-green ,darklime-green+4
                    ,darklime-cyan ,darklime-blue+1 ,darklime-magenta))
;;;;; pdf-tools
   `(pdf-view-midnight-colors '(,darklime-fg . ,darklime-bg-05))
;;;;; vc-annotate
   `(vc-annotate-color-map
     '(( 20. . ,darklime-red-1)
       ( 40. . ,darklime-red)
       ( 60. . ,darklime-orange)
       ( 80. . ,darklime-yellow-2)
       (100. . ,darklime-yellow-1)
       (120. . ,darklime-yellow)
       (140. . ,darklime-green-1)
       (160. . ,darklime-green)
       (180. . ,darklime-green+1)
       (200. . ,darklime-green+2)
       (220. . ,darklime-green+3)
       (240. . ,darklime-green+4)
       (260. . ,darklime-cyan)
       (280. . ,darklime-blue-2)
       (300. . ,darklime-blue-1)
       (320. . ,darklime-blue)
       (340. . ,darklime-blue+1)
       (360. . ,darklime-magenta)))
   `(vc-annotate-very-old-color ,darklime-magenta)
   `(vc-annotate-background ,darklime-bg-1)
   ))

;;; Rainbow Support

(declare-function rainbow-mode 'rainbow-mode)
(declare-function rainbow-colorize-by-assoc 'rainbow-mode)

(defvar darklime-add-font-lock-keywords nil
  "Whether to add font-lock keywords for darklime color names.
In buffers visiting library `darklime-theme.el' the darklime
specific keywords are always added.  In all other Emacs-Lisp
buffers this variable controls whether this should be done.
This requires library `rainbow-mode'.")

(defvar darklime-colors-font-lock-keywords nil)

;; (defadvice rainbow-turn-on (after darklime activate)
;;   "Maybe also add font-lock keywords for darklime colors."
;;   (when (and (derived-mode-p 'emacs-lisp-mode)
;;              (or darklime-add-font-lock-keywords
;;                  (equal (file-name-nondirectory (buffer-file-name))
;;                         "darklime-theme.el")))
;;     (unless darklime-colors-font-lock-keywords
;;       (setq darklime-colors-font-lock-keywords
;;             `((,(regexp-opt (mapcar 'car darklime-colors-alist) 'words)
;;                (0 (rainbow-colorize-by-assoc darklime-colors-alist))))))
;;     (font-lock-add-keywords nil darklime-colors-font-lock-keywords)))

;; (defadvice rainbow-turn-off (after darklime activate)
;;   "Also remove font-lock keywords for darklime colors."
;;   (font-lock-remove-keywords nil darklime-colors-font-lock-keywords))

;;; Footer

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'darklime)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (require 'rainbow-mode nil t) (rainbow-mode 1))
;; End:
;;; darklime-theme.el ends here
