;;; Compiled snippets and support files for `jde-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'jde-mode
                     '(("cla" "public class ${1:`(replace-regexp-in-string \"_\" \"\" (capitalize (file-name-base)))`} {\n      $0\n}" "class" nil nil nil nil nil nil)
                       ("pp" "System.out.println(\"===============================\");\nSystem.out.println(\"$1\");\n" "println" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sun Aug 17 12:42:03 2014