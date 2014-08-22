;;; Compiled snippets and support files for `erlang-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'erlang-mode
                     '(("[" "[{$1, $2}$0]." "[" nil nil nil nil nil nil)
                       ("clc" "-module(${1:`(file-name-base)`}, [Req]).\n-compile(export_all).\n\n${2:index}('GET', []) ->\n    ${3:{output, \"<strong>Hello Chicago Boss!</strong>\"}.}" "chicago boss controller" nil nil nil nil nil nil)
                       ("clm" "-module(${1:`(file-name-base)`}, [Id, $2]).\n-compile(export_all)." "chicago boss model" nil nil nil nil nil nil)
                       ("ex" "-export([$1/${2:1}])." "export" nil nil nil nil nil nil)
                       (nil "{$1, $2}$0" "hash" nil nil nil nil "C-c C-p" nil)
                       ("mo" "-module(${1:`(file-name-base)`}).\n" "module" nil nil nil nil nil nil)
                       ("{" "{$1, $2}$0" "{" nil nil nil nil nil nil)
                       ("}," "}, ${$1, $2}$0" "}," nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Aug 21 01:52:44 2014
