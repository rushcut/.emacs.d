(require-package 'yasnippet)
(require-package 'popup)
(require 'popup nil t)
(when (featurep 'popup)
  (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
  (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
  (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
  (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
  (define-key popup-menu-keymap (kbd "M-p") 'popup-previous))

(custom-set-variables
 '(yas-trigger-key "M-RET")
 ;; Add yas-expand itself, so when auto-complete completes and retry, yas-expand can work.
 ;; '(yas-expand-only-for-last-commands '(self-insert-command org-self-insert-command yas-expand ac-next ac-previous ac-expand))
 '(yas-choose-keys-first nil)
 ;; '(yas-prompt-functions (quote (yas-popup-isearch-prompt
 ;;                                yas-ido-prompt
 ;;                                yas-x-prompt
 ;;                                yas-no-prompt)))
 '(yas-wrap-around-region nil)
 '(yas-use-menu nil)
 '(yas-triggers-in-field t)
 '(yas/indent-line 'fixed)
 )

(add-hook 'yas-minor-mode-hook
          (lambda ()
            (define-key yas-minor-mode-map (kbd "TAB") nil)
            (define-key yas-minor-mode-map [(tab)] nil)))

(global-unset-key (kbd "M-RET"))
(define-key global-map (kbd "M-RET") 'yas-expand)

(yas-global-mode t)

(global-set-key (kbd "C-c y n") `yas-new-snippet)
(global-set-key (kbd "C-c y v") `yas-visit-snippet-file)
(global-set-key (kbd "C-c y f") `yas-find-snippets)
(global-set-key (kbd "C-c y r") `yas-reload-all)

(defun yas/popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas/prompt-functions '(yas/popup-isearch-prompt yas/no-prompt))
(setq ac-source-yasnippet nil)

(defun yas-buffer-name-stub ()
  (let ((name (or (buffer-file-name)
                  (buffer-name))))
    (replace-regexp-in-string
     "^t_\\|_?\\(test\\|spec\\)$" ""
     (file-name-sans-extension (file-name-nondirectory name)))))

(defun yas-safer-expand ()
  (let ((yas-fallback-behavior 'return-nil))
    (call-interactively 'yas-expand)))

(defun yas-ido-insert-snippets (&optional no-condition)
  (interactive "P")
  (let ((yas-prompt-functions '(yas-ido-prompt)))
    (yas-insert-snippet)))

(defvar yas-popup-remember-pattern nil)
(defadvice popup-isearch-prompt (after remember-pattern (popup pattern) activate)
  (setq yas-popup-remember-pattern pattern))

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (setq yas-popup-remember-pattern nil)
    (or
     (popup-menu*
      (mapcar
       (lambda (choice)
         (popup-make-item
          (or (and display-fn (funcall display-fn choice))
              choice)
          :value choice))
       choices)
      :prompt prompt
      :isearch t
      ) yas-popup-remember-pattern)))

(defadvice yas--menu-keymap-get-create (around ignore (mode &optional parents) activate)
  (setq ad-return-value (make-sparse-keymap)))

(define-key my-keymap (kbd "<tab>") 'yas-insert-snippet)

(let ((map (make-sparse-keymap)))
  ;; (define-key map (kbd "M-/") 'yas-ido-insert-snippets)
  ;; (define-key map (kbd "/") 'yas-ido-insert-snippets)
  ;; (define-key map (kbd "n") 'yas-new-snippet)
  ;; (define-key map (kbd "o") 'yas-visit-snippet-file)
  ;; (define-key map (kbd "i") 'auto-insert)
  (define-key map (kbd "RET") 'zencoding-expand-yas)
  ;; (define-key my-keymap (kbd "M-/") map)
  )

(setq yas-snippet-dirs (list (expand-file-name "snippets" user-emacs-directory)))
(yas-global-mode +1)
(defadvice yas-reload-all (before yas-recompile-all-before-reload activate)
  (yas-recompile-all))

(provide 'init-yasnippet)
