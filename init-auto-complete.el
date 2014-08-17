(require-package 'auto-complete)
(require 'auto-complete-config)
;; ;; (global-auto-complete-mode nil)

(setq ac-auto-show-menu t)
(setq ac-auto-start t)
(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
(setq ac-quick-help-delay 0.3)
(setq ac-quick-help-height 30)
(setq ac-show-menu-immediately-on-auto-complete t)
(setq ac-ignore-case nil)

(set-default 'ac-sources
             '(ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-imenu
               ac-source-dictionary
               ac-source-words-in-all-buffer))

(define-key ac-completing-map (kbd "C-g") 'ac-stop)
(define-key ac-completing-map (kbd "C-s") 'ac-isearch)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)

;; (fill-keymap ac-completing-map
;;              ;; "C-[" 'ac-exit-to-normal-state
;;              ;; "C-g" 'ac-stop
;;              ;; "ESC" 'ac-stop
;;              "C-l" 'ac-expand-common
;;              "C-n" 'ac-next
;;              "C-s" 'ac-isearch
;;              "C-p" 'ac-previous)

(ac-config-default)

;; (require-package 'ac-etags)
;; (setq ac-etags-requires 1)
;; (ac-etags-setup)

(provide 'init-auto-complete)
