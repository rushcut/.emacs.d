(require-package 'popwin)
(require 'popwin)
(popwin-mode 1)

(global-set-key (kbd "C-x C-p") popwin:keymap)
(setq display-buffer-function 'popwin:display-buffer)
(push '(dired-mode :position top) popwin:special-display-config)

(setq popwin:close-popup-window-timer-interval 0.05)

(setq display-buffer-function 'popwin:display-buffer)

(push '("*rspec-compilation*" :width 120 :position right :stick t :noselect t) popwin:special-display-config)
(push '("*compilation*" :width 120 :position right :stick t :noselect t) popwin:special-display-config)
(push '("*auto-async-byte-compile*" :height 14 :position bottom :noselect t) popwin:special-display-config)
(push '(" *auto-async-byte-compile*" :height 14 :position bottom :noselect t) popwin:special-display-config)
(push '("  *auto-async-byte-compile*" :height 14 :position bottom :noselect t) popwin:special-display-config)
(push '(" *Compile-Log*" :height 14 :position bottom :noselect t) popwin:special-display-config)
(push '("*Compile-Log*" :height 14 :position bottom :noselect t) popwin:special-display-config)
(push '("*VC-log*" :height 10 :position bottom) popwin:special-display-config)
(push '("*Backtrace*" :height 10 :position bottom :noselect t) popwin:special-display-config)
(push '("*scratch*") popwin:special-display-config)
(push '(dired-mode :position bottom) popwin:special-display-config) ; dired-jump-other-window (C-x 4 C-j)
(push '("*Warnings*") popwin:special-display-config)
(push '("*Remember*" :height 30 :position bottom) popwin:special-display-config)
(push '("*Process List*" :height 10 :position bottom :noselect t) popwin:special-display-config)
(push '("*git-gutter:diff*" :height 10 :position bottom :noselect 1) popwin:special-display-config)
(push '("*quickrun*" :height 10 :position bottom :noselect 1) popwin:special-display-config)
(push '("*el-get packages*" :position bottom) popwin:special-display-config)
(push '("*Selection Ring: `kill-ring'*" :position right) popwin:special-display-config)
(push '("*motion-rake*" :position bottom :height 10) popwin:special-display-config)
(push '("*Bundler*" :position bottom :height 10) popwin:special-display-config)
(push '(eclim-problems-mode :height 10 :position bottom :stick t) popwin:special-display-config)

(generate-new-buffer "special-buffer")

(setq eab/special-buffer-displaedp nil)
(setq eab/special-buffer "special-buffer")

(add-to-list 'popwin:special-display-config
             `(,eab/special-buffer :width 80 :position left :stick t))

(defun eab/special-buffer-toggle ()
  (interactive)
  (if eab/special-buffer-displaedp
      (progn
      (popwin:close-popup-window)
      (setq eab/special-buffer-displaedp nil))
    (progn
      (ignore-errors (popwin:display-buffer eab/special-buffer))
      (setq eab/special-buffer-displaedp 't))))

(global-set-key (kbd "<f3>") 'eab/special-buffer-toggle)

(provide 'init-popwin)
