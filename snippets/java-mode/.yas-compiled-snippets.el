;;; Compiled snippets and support files for `java-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'java-mode
                     '(("pp" "System.out.println(\"==========================\");\nSystem.out.println($1);" "System.out.println" nil nil nil nil nil nil)
                       ("cla" "`(java-support-package-line-string)`public class `(replace-regexp-in-string \".java\" \"\" (file-name-base))` {\n\n      public `(replace-regexp-in-string \".java\" \"\" (file-name-base))`() {\n             $0\n      }\n}" "class" nil nil nil nil nil nil)
                       ("hamcrest" "import org.hamcrest.*;\nimport static org.hamcrest.MatcherAssert.assertThat;\nimport static org.hamcrest.Matchers.*;\n" "import hamcrest" nil nil nil nil nil nil)
                       ("psf" "private static final ${1:String} ${2:NAME};" "private static final" nil nil nil nil nil nil)
                       ("pm" "public ${1:void} ${2:method_name}($3) {\n       $0\n}" "public method" nil nil nil nil nil nil)
                       ("pusf" "public static final ${1:String} ${2:NAME};" "public static final" nil nil nil nil nil nil)
                       ("ccc" "// =============================================================\n//\n// $1\n//\n// =============================================================" "section comment" nil nil nil nil nil nil)
                       ("this" "this.${1:name} = $1;" "this.var = var;" nil nil nil nil nil nil)
                       ("try" "try {\n	$0\n} catch (${1:Exception} e) {\n	e.printStackTrace();\n}" "try-catch" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Fri Aug  8 10:08:47 2014
