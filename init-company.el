(require-package 'company)
(require 'company)
;; (require 'company-abbrev)
;; (require 'company-dabbrev)

(setq company-auto-complete nil)

(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)
(setq company-show-numbers t)
(setq company-tooltip-limit 20)

(setq company-dabbrev-downcase nil)
(setq company-dabbrev-ignore-case nil)

(define-key company-mode-map (kbd "C-l") 'company-complete)

(when (executable-find "tern")
  (after "company-tern-autoloads"
         (add-to-list 'company-backends 'company-tern)))
(setq company-global-modes
      '(not
        eshell-mode comint-mode org-mode))

(set-face-attribute 'company-tooltip nil :background "black" :foreground "gray40")
(set-face-attribute 'company-tooltip-selection nil :inherit 'company-tooltip :background "gray15")
(set-face-attribute 'company-preview nil :background "black")
(set-face-attribute 'company-preview-common nil :inherit 'company-preview :foreground "gray40")
(set-face-attribute 'company-scrollbar-bg nil :inherit 'company-tooltip :background "gray20")
(set-face-attribute 'company-scrollbar-fg nil :background "gray40")

(global-company-mode t)

(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)
