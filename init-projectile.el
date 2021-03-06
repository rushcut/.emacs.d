(require-package 'projectile)
(require-package 'ag)
(require-package 'ack)
(require-package 'ack-and-a-half)

(custom-set-variables
 '(projectile-enable-caching t)
 '(projectile-keymap-prefix (kbd "M-s p")))

(defun projectile+-open-project (&optional force)
  (interactive "P")
  (let ((current-prefix-arg (if force 8 4)))
    (call-interactively 'magit-status)))
(defun projectile+-git-grep ()
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (call-interactively 'git-grep)))
(defun projectile+-shell-command ()
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (call-interactively 'shell-command)))

(defun projectile+-eshell-toggle ()
  (interactive)
  (eshell-toggle (ignore-errors (concat "*eshell*<" (projectile-project-name) ">"))))

(defun projectile+-eshell-here ()
  (interactive)
  (eshell-here (ignore-errors (concat "*eshell*<" (projectile-project-name) ">"))))

(defun projectile+-open-session ()
  (interactive)
  (let ((dir (projectile-project-p)))
    (when dir
      (when desktop-save-mode
        (desktop-change-dir dir))
      (dired dir))))

(defun projectile+-org ()
  (interactive)
  (let ((source (concat my-dropbox-dir "Documents/ProjectNotes/" (projectile-project-name) ".org"))
        (link (concat (projectile-project-root) "project.org")))
    (unless (file-exists-p source)
      (with-temp-file source (insert "")))
    (make-symbolic-link source link t)
    (find-file link)))

(defadvice projectile-regenerate-tags (around call-script activate)
  (let* ((project-root (projectile-project-root))
         (default-directory project-root)
         (script (concat project-root ".generate-ctags"))
         (tags-file (expand-file-name projectile-tags-file-name)))
    (if (file-executable-p script)
        (progn
          (call-process script)
          (setq ad-return-value (visit-tags-table tags-file)))
      ad-do-it)))

(projectile-global-mode)
(setq projectile-mode-line-lighter " ")
(define-key projectile-mode-map (kbd "M-s p a") 'projectile-ag)
(define-key projectile-mode-map (kbd "M-s p SPC") 'projectile+-org)
(define-key projectile-mode-map (kbd "M-s p A") 'projectile-ack)
(define-key projectile-mode-map (kbd "M-s p x") 'projectile-test-project)
(define-key projectile-mode-map (kbd "M-s p p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "M-s p P") 'projectile+-open-project)
(define-key projectile-mode-map (kbd "M-s p e") 'projectile+-eshell-toggle)
(define-key projectile-mode-map (kbd "M-s p E") 'projectile+-eshell-here)
(define-key projectile-mode-map (kbd "M-s p r") 'projectile-recentf)
(define-key projectile-mode-map (kbd "M-s p <f2>") 'projectile-recentf)
(define-key projectile-mode-map (kbd "M-s p G") 'projectile+-git-grep)
(define-key projectile-mode-map (kbd "M-s p !") 'projectile+-shell-command)
(define-key projectile-mode-map (kbd "M-s p s") 'projectile+-open-session)

(global-set-key (kbd "C-c C-f") 'projectile-find-file)

(provide 'init-projectile)
