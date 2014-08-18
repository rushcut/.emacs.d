;;; Compiled snippets and support files for `coffee-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'coffee-mode
                     '((",," "$(${1:\"${2:#id}\"})" "$()" nil nil nil nil nil nil)
                       ("th" "$(${1:this})" "$(this)" nil nil nil nil nil nil)
                       ("asb" "expect($1).toBe($2)\n" "asb" nil nil nil nil nil nil)
                       ("asne" "expect($1).not.toBeNull($2)" "assert" nil nil nil nil nil nil)
                       ("ase" "expect($1).toEqual($2)" "assertEquals" nil nil nil nil nil nil)
                       ("before" "beforeEach ->" "beforeEach" nil nil nil nil nil nil)
                       ("ccc" "# ==================================================\n# $1\n# ==================================================" "ccc" nil nil nil nil nil nil)
                       ("cla" "class $1\n  constructor: ${2:(${3:params})} ->\n\n@$1 = $1" "class" nil nil nil nil nil nil)
                       ("log" "console.log" "console.log" nil nil nil nil nil nil)
                       ("de" "describe '$1', ->" "describe" nil nil nil nil nil nil)
                       ("doc" "$(document).ready ->\n" "document.ready" nil nil nil nil nil nil)
                       ("ea" "each (index, ${1:element}) ->\n     $0" "each" nil nil nil nil nil nil)
                       ("ex" "expect($1).to${2:Be}($3)" "exepect().toBe" nil nil nil nil nil nil)
                       ("af" "affix '$1'" "fixture (jasime-fixture)" nil nil nil nil nil nil)
                       ("me" "${1:method_name}: ${2:(${3:params}) }->\n                  $0" "instance_method" nil nil nil nil nil nil)
                       ("it" "it '$1', ->" "it" nil nil nil nil nil nil)
                       ("this" "@${1:name} = $1" "this" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Mon Aug 18 20:11:30 2014
