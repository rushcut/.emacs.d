(add-to-list 'load-path "~/.emacs.d")

(require 'init-utils)
(require 'init-elpa)

(require-package 'diminish)

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
(require 'init-company)
(require 'init-yasnippet)
(require 'init-windows)
(require 'init-files)
;; (require 'init-term)

(require 'init-special-buffers)
