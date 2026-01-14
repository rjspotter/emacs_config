;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "flycheck-indent" "20200129.2046"
  "Indent-lint frontend for flycheck."
  '((emacs       "25.1")
    (indent-lint "1.0.0")
    (flycheck    "31"))
  :url "https://github.com/conao3/indent-lint.el"
  :commit "23ef4bab5509e2e7fb1f4a194895a9510fa7c797"
  :revdesc "23ef4bab5509"
  :keywords '("tools")
  :authors '(("Naoya Yamashita" . "conao3@gmail.com"))
  :maintainers '(("Naoya Yamashita" . "conao3@gmail.com")))
