(global-set-key (kbd "C-x C-r") 'mf-rename-current-buffer-file)
(global-set-key (kbd "C-x M-f") 'mf-find-alternative-file-with-sudo)

(when (locate-file "gpicker" exec-path)
  (define-key my-keymap "g" 'gpicker-find-file)
  (define-key my-keymap (kbd "M-g") 'gpicker-find-file))

(provide 'init-files)
