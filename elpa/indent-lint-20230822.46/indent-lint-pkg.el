;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "indent-lint" "20230822.46"
  "Async indentation checker."
  '((emacs       "25.1")
    (async-await "1.0")
    (async       "1.9.4")
    (promise     "1.1"))
  :url "https://github.com/conao3/indent-lint.el"
  :commit "aee76faf54a55e0bcb5dc07a667d7f5999299c9b"
  :revdesc "aee76faf54a5"
  :keywords '("tools")
  :authors '(("Naoya Yamashita" . "conao3@gmail.com"))
  :maintainers '(("Naoya Yamashita" . "conao3@gmail.com")))
