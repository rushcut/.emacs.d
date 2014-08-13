(require-package 'popwin)
(require 'popwin)
(popwin-mode 1)

(push '("*Help*" :width 0.3 :position right) popwin:special-display-config)

(provide 'init-popwin)
