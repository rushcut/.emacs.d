;;; Compiled snippets and support files for `less-css-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'less-css-mode
                     '(("font" "@font-face {\n    font-family: ${1:Bitstream};\n    src: url(\"/assets/${2:Vera}.${3:ttf}\") format(\"${4:truetype}\"); /* For IE */\n    src: local(\"$1\"), url(\"/assets/$2.$3\") format(\"$4\"); /* For non-IE */\n    font-size: ${5:12}px;\n}" "font-face" nil nil nil nil nil nil)
                       ("list" "list-style-type: none;\n" "list-style-type" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Mon Aug 18 20:11:30 2014
