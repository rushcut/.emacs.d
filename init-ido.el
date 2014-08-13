(ido-mode +1)
(ido-load-history)

(define-key ido-file-completion-map [(meta ?l)] nil)
(setq completion-ignored-extensions (cons ".meta" completion-ignored-extensions))
(custom-set-variables
 '(ido-save-directory-list-file
   (expand-file-name ".ido.last" user-emacs-directory))
 '(ido-default-file-method 'selected-window)
 '(ido-default-buffer-method 'selected-window))

(custom-set-variables
 '(ido-enable-regexp nil)
 '(ido-enable-flex-matching nil)
 '(ido-everywhere t)
 '(ido-read-file-name-as-directory-commands nil)
 '(ido-use-filename-at-point nil)
 '(flx-ido-threshhold 8000))

(require-package 'flx)
(require-package 'flx-ido)
(require-package 'ido-hacks)
(require-package 'ido-complete-space-or-hyphen)
(put 'bookmark-set 'ido 'ignore)
(put 'ido-exit-minibuffer 'ido 'ignore)

(ido-complete-space-or-hyphen-enable)

(require 'ido-hacks)
(ido-hacks-mode +1)
;; Use flx in flex matching
(ad-disable-advice 'ido-set-matches-1 'around 'ido-hacks-ido-set-matches-1)
(ad-activate 'ido-set-matches-1)
(mapc (lambda (s) (put s 'ido-hacks-fix-default t))
      '(bookmark-set))

(require 'flx-ido)
(setq ido-use-faces nil)
(flx-ido-mode +1)

(defun init--ido-setup ()
  (define-key ido-completion-map (kbd "M-m") 'ido-merge-work-directories)
  (define-key ido-completion-map "\C-c" 'ido-toggle-case))

(add-hook 'ido-setup-hook 'init--ido-setup)

(require-package 'smex)
(global-set-key (kbd "M-x") 'smex)

(require-package 'ido-vertical-mode)
(ido-vertical-mode +1)

(provide 'init-ido)
