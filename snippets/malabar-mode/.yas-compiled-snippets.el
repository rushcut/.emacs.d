;;; Compiled snippets and support files for `malabar-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'malabar-mode
                     '(("cla" "public class ${1:`(replace-in-string (file-name-base) \"\\.java\" \"\")`} {\n      $0\n}\n" "class" nil nil nil nil nil nil)
                       ("psf" "public static final ${1:String}" "public static final String" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Aug 21 01:52:44 2014
