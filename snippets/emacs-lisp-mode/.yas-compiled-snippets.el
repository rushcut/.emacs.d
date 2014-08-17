;;; Compiled snippets and support files for `emacs-lisp-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'emacs-lisp-mode
                     '(("ase" "(should (equal ${1:actual} ${2:expected}))" "ase" nil nil nil nil nil nil)
                       ("ccc" ";; ======================================================================\n;;\n;; ${1:comment}\n;;\n;; ======================================================================" "ccc" nil nil nil nil nil nil)
                       ("cc" ";;----------------------------------------------------------------------------\n;; $1\n;;----------------------------------------------------------------------------" "comment" nil nil nil nil nil nil)
                       ("dk" "(define-key ${1:org}-mode-map (kbd \"${2:C-c o}\") ${3:nil})" "define-key" nil nil nil nil nil nil)
                       ("def" "(defun $1 ($2)\n       $0)\n" "defun" nil nil nil nil nil nil)
                       ("gsk" "(global-set-key (kbd \"${1:C-c}\") '$2)" "global-set-key" nil nil nil nil nil nil)
                       ("guk" "(global-unset-key (kbd \"${1:C-c}\"))" "global-unset-key" nil nil nil nil nil nil)
                       ("spec" "(require 'el-expectations)\n(require 'el-mock)\n(require '${1:project-name})\n\n(expectations\n\n  $0\n\n  )" "initialize test" nil nil nil nil nil nil)
                       ("let" "(let (($1 $2))\n     $0)\n" "let" nil nil nil nil nil nil)
                       ("pr" "(provide '${1:`(file-name-base (buffer-name))`})" "provide" nil nil nil nil nil nil)
                       ("it" "(desc \"${1:description}\")\n(expect ${2:expected}\n        $0)" "spec" nil nil nil nil nil nil)
                       ("specr" "require 'spec_helper'\n\ndescribe ${1:`(replace-regexp-in-string \"_\" \"\" (capitalize (replace-regexp-in-string \"_spec$\" \"\" (file-name-base))))`} do\n         $0\nend\n" "spec(rails)" nil nil nil nil nil nil)
                       ("test" "(ert-deftest ${1:method}-test ()\n             $0)" "test" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sun Aug 17 12:42:03 2014
