(require-package 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)
(setq mmm-parse-when-idle t)

(require 'mmm-erb)
;; (mmm-add-mode-ext-class 'html-erb-mode "\\.html\\.erb\\'" 'erb)
;; (mmm-add-mode-ext-class 'html-erb-mode "\\.rhtml\\'" 'erb)
;; (mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-js)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-css)

(mmm-add-group
 'haml-js
 '((js-script
    :submode js2-mode
    :face mmm-code-submode-face
    :front "^:javascript[ \t]*\n?"
    :back "^[-:]")
   (coffeescript-mode
    :submode coffee-mode
    :face mmm-code-submode-face
    :front "^:coffee\\(script\\)?[ \t]*\n?"
    :back "^[-:]")))

(mmm-add-mode-ext-class 'haml-mode nil 'haml-js)

(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . html-erb-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . html-erb-mode))
(add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'"  . html-erb-mode))

(mmm-add-group
 'org-emacs-lisp
 '((emacs-lisp
    :submode emacs-lisp-mode
    :face mmm-code-submode-face
    :front "^#\\+BEGIN_SRC emacs-lisp[ \t]*\n?"
    :back "^#\\+END_SRC")
  ))
(mmm-add-mode-ext-class 'org-mode nil 'org-emacs-lisp)

(provide 'init-mmm)
