;;; Compiled snippets and support files for `js2-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'js2-mode
                     '(("log" "console.log($1);" "console.log" nil nil nil nil nil nil)
                       ("get" "get('$1')$0" "get" nil nil nil nil nil nil)
                       ("require" "//= require jquery-fileupload" "jquery-fileupload" nil nil nil nil nil nil)
                       ("me" "$1: function(${2:params}) {\n  $0\n}" "method" nil nil nil nil nil nil)
                       ("set" "set('$1', ${2:$1})$0" "set" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Sep  4 12:59:22 2014
