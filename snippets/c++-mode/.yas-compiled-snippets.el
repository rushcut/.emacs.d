;;; Compiled snippets and support files for `c++-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c++-mode
                     '(("log" "cout << \"$1: \" << ${1:attr} <<endl;" "cout" nil nil nil nil nil nil)
                       ("cp" "cprintf(\"$1\\n\", $2);" "cprintf" nil nil nil nil nil nil)
                       ("main" "#include <iostream>\n\nusing namespace std;\n\nint main()\n{\n  $0\n  return 0;\n}\n" "main" nil nil nil nil nil nil)
                       ("pp" "${1:t}printf(\"$2: $3\", ${2:var});" "printf" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Aug 21 01:52:44 2014
