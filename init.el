(add-to-list 'load-path "~/.emacs.d")

(require 'init-utils)
(require 'init-elpa)

(require-package 'diminish)
(require-package 'f)
(require 'f)
(require-package 's)

(require 'init-preference)
(require 'init-look)
(require 'init-git)
(require 'init-ido)
(require 'init-editing)
(require 'init-popwin)
(require 'init-guide-key)

(require 'init-site-lisp)

(require 'init-projectile)
(require 'init-alternative-files)
(require 'init-smartparens)

;; (require 'init-company)
(require 'init-auto-complete)
(require 'init-hippie)
(require 'init-debug)

(require 'init-yasnippet)
(require 'init-windows)
(require 'init-files)
(require 'init-quickrun)
(require 'init-anzu)
;; (require 'init-term)

(require 'init-moz)
(require 'init-special-buffers)

;; modes
(require 'init-java-mode)
(require 'init-ruby-mode)


;; alias
(require 'init-alias)
