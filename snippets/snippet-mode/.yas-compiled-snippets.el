;;; Compiled snippets and support files for `snippet-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'snippet-mode
                     '(("del" "`(delete-char (- (skip-chars-backward \" \")))`$0" "delete-back" nil nil nil nil nil nil)
                       ("flash"
                        (error
                         (error-message-string
                          (invalid-read-syntax "#")))
                        "flash" nil nil
                        ((some-var some-value))
                        nil "direct-keybinding" nil)
                       ("pl" "\\$\\{${1:1}:$(pluralize-string text)\\}\n" "pluralize-string" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Sep  4 12:59:22 2014
