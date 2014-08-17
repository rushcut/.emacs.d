;;; Compiled snippets and support files for `js-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'js-mode
                     '(("this" "$(this)" "$(this)" nil nil nil nil nil nil)
                       ("bower" "{\n    \"name\": \"${1:app_name}\",\n    \"version\": \"0.0.1\",\n    \"authors\": [\n    ],\n    \"description\": \"rails\",\n    \"license\": \"MIT\",\n    \"ignore\": [\n        \"**/.*\",\n        \"node_modules\",\n        \"bower_components\",\n        \"vendor/assets/components\",\n        \"test\",\n        \"tests\"\n    ],\n    \"dependencies\": {\n        // \"marked\": \"~ 3.0\"\n    }\n}\n" "bower" nil nil nil nil nil nil)
                       ("log" "console.log($1);" "console.log" nil nil nil nil nil nil)
                       ("doc" "$(document).ready(function(){\n  $0\n});" "document.ready" nil nil nil nil nil nil)
                       ("get" "document.getElementById('$1')" "getElementById" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sun Aug 17 12:42:03 2014
