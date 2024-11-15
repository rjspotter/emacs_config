;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "lsp-julia" "0.7.2"
  "Julia support for lsp-mode."
  '((emacs      "25.1")
    (lsp-mode   "6.3")
    (julia-mode "0.3"))
  :url "https://github.com/gdkrmr/lsp-julia"
  :commit "c584f79c7fee6176bbb6120f4cb0f1001bcf8113"
  :revdesc "c584f79c7fee"
  :keywords '("languages" "tools")
  :authors '(("Martin Wolke" . "vibhavp@gmail.com")
             ("Adam Beckmeyer" . "adam_git@thebeckmeyers.xyz")
             ("Guido Kraemer" . "gdkrmr@users.noreply.github.com"))
  :maintainers '(("Guido Kraemer" . "gdkrmr@users.noreply.github.com")))
