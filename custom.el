(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-interval 300)
 '(auto-save-timeout 10)
 '(backup-by-copying t)
 '(backup-directory-alist (list (cons "." (expand-file-name "backups" user-emacs-directory))))
 '(delete-by-moving-to-trash t)
 '(delete-old-versions t)
 '(flx-ido-threshhold 8000)
 '(grep-find-ignored-directories (quote ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "tmp" "log" "vendor")))
 '(ido-default-buffer-method (quote selected-window))
 '(ido-default-file-method (quote selected-window))
 '(ido-enable-flex-matching nil)
 '(ido-enable-regexp nil)
 '(ido-everywhere t)
 '(ido-read-file-name-as-directory-commands nil)
 '(ido-save-directory-list-file (expand-file-name ".ido.last" user-emacs-directory))
 '(ido-use-filename-at-point nil)
 '(kept-new-versions 30)
 '(kept-old-versions 5)
 '(kill-ring-max 500)
 '(projectile-enable-caching t)
 '(projectile-keymap-prefix (kbd "M-s p"))
 '(vc-make-backup-files t)
 '(version-control t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ensime-errline-highlight ((t (:inherit flymake-errline :underline "red"))) t)
 '(font-lock-comment-face ((t (:foreground "#666"))))
 '(font-lock-string-face ((t (:foreground "#099"))))
 '(mmm-code-submode-face ((t (:background "#444"))) t)
 '(mode-line ((t (:background "#2D6B61" :foreground "black"))))
 '(powerline-active1 ((t (:background "#49525A"))) t)
 '(powerline-active2 ((t (:background "#6A9F2F" :foreground "#004E00"))) t))
