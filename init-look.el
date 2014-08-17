;; FONT
(setq fixed-width-use-QuickDraw-for-ascii t)
(setq mac-allow-anti-aliasing t)

(when *is-cocoa-emacs*
  (set-face-attribute 'default nil :family "Menlo" :height 140)
  (setq-default line-spacing 1)
  (set-fontset-font (frame-parameter nil 'font)
                    '(#x1100 . #xffdc)
                    '("Apple SD Gothic Neo" . "iso10646-1"))
  )

;; THEME
(setq custom-theme-directory (expand-file-name "themes" user-emacs-directory))
(load (concat custom-theme-directory "/zenburn-theme.el"))
(defun init--theme ()
  (load-theme 'zenburn t)
  ;; (set-frame-font my-frame-font)
  ;; (set-fontset-font "fontset-default" 'chinese-gbk my-frame-font-chinese)
  )

(init--theme)
(setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

;; prefer fringe
(setq next-error-highlight 'fringe-arrow)

(defvar after-make-console-frame-hooks '()
  "Hooks to run after creating a new TTY frame")
(defvar after-make-window-system-frame-hooks '()
  "Hooks to run after creating a new window-system frame")

(defun run-after-make-frame-hooks (frame)
  "Selectively run either `after-make-console-frame-hooks' or
  `after-make-window-system-frame-hooks'"
  (select-frame frame)
  (run-hooks (if window-system
                 'after-make-window-system-frame-hooks
               'after-make-console-frame-hooks)))

(add-hook 'after-make-frame-functions 'run-after-make-frame-hooks)
(add-hook 'after-make-window-system-frame-hooks 'init--theme)

(provide 'init-look)
