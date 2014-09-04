;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '(("code" "#+BEGIN_SRC ${1:ruby}\n#+END_SRC" "code" nil nil nil nil nil nil)
                       ("mod" "** ${1:module-name}\n#+BEGIN_SRC $1\n(define-module $1\n$0\n)\n#+END_SRC\n" "emacs-module" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Sep  4 12:59:22 2014
