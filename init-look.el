;; FONT
(setq fixed-width-use-QuickDraw-for-ascii t)
(setq mac-allow-anti-aliasing t)

(when *is-cocoa-emacs*
  (set-face-attribute 'default nil :family "Menlo" :height 150)
  (setq-default line-spacing 1)
  (set-fontset-font (frame-parameter nil 'font)
                    '(#x1100 . #xffdc)
                    '("Apple SD Gothic Neo" . "iso10646-1"))
  )

;; THEME
(setq custom-theme-directory (expand-file-name "themes" user-emacs-directory))
(load (concat custom-theme-directory "/zenburn-theme.el"))

(defun init--theme () (load-theme 'zenburn t)
  ;; (set-frame-font my-frame-font)
  ;; (set-fontset-font "fontset-default" 'chinese-gbk my-frame-font-chinese)
)

(provide 'init-look)
