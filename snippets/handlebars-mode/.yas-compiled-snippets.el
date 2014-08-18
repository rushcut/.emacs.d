;;; Compiled snippets and support files for `handlebars-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'handlebars-mode
                     '(("ba" "{{bindAttr ${1:x}=\"$2\"}}" "bindAttr" nil nil nil nil nil nil)
                       ("ea" "{{#each$1}}\n$0\n{{/each}}" "each" nil nil nil nil nil nil)
                       ("outlet" "{{outlet}}" "outlet" nil nil nil nil nil nil)
                       ("." "{{$0}}" "{{}}" nil nil nil nil nil nil)
                       ("," "{{#$1${2: $3}}}$0{{/$1}}" "{{}}{{}}" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Mon Aug 18 20:11:30 2014
