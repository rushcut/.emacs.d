;;; Compiled snippets and support files for `fundamental-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'fundamental-mode
                     '(("alias" "alias ${1:name}       ${2:$$(yas/choose-value '(\"move\" \"corner\"))}   $3" "alias" nil nil nil nil nil nil)
                       ("bower" "{\n  \"directory\": \"vendor/assets/components\"\n}" "bowerrc" nil nil nil nil nil nil)
                       ("gitignore" ".classpath\n.project\n.settings/\ntarget/\n" "gitignore(maven-eclipse)" nil nil nil nil nil nil)
                       ("rvm" "rvm use --create ruby-2.1.1@${1:`(car (last (s-split \"/\" (f-dirname buffer-file-name))))`}" "rvmrc" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Sun Aug 17 12:42:03 2014
