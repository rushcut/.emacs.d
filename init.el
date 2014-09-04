(add-to-list 'load-path "~/.emacs.d")

(require 'init-site-lisp)
(require 'init-benchmark)

(require 'init-utils)
(require 'init-elpa)
(require-package 'diminish)

(require 'init-preference)
(require 'init-look)
(require 'init-ido)
(require 'init-editing)
(require 'init-popwin)
(require 'init-auto-complete)
(require 'init-hippie)
(require 'init-files)
(require 'init-anzu)
(require 'init-yasnippet)
(require 'init-projectile)
(require 'init-git)
(require 'init-windows)
(require 'init-mmm)
(require 'init-smartparens)
(require 'init-alias)
(require 'init-guide-key)

;; (require-package 'f)
;; (require 'f)
;; (require-package 's)

(require 'init-alternative-files)

;; (require 'init-company)
;; (require 'init-debug)

(require 'init-quickrun)
(require 'init-term)

(require 'init-moz)
(require 'init-special-buffers)

;; modes
;; (require 'init-java-mode)
(require 'init-ruby-mode)
(require 'init-coffee-mode)
(require 'init-yaml-mode)

;; ;; (require 'init-org2)

(benchmark-init/show-durations-tree)
