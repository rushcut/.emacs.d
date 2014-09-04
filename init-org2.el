(add-to-list 'load-path "~/.emacs.d/site-lisp/org-8.2.4/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-8.2.4/contrib/lisp")

(require 'org)
(setq org-modules '(org-clock org-timer))

(setq org-directory (concat my-dropbox-dir "g/org"))

;;----------------------------------------------------------------------------
;; 프로젝트별로 다른 ORG 파일을 만들어 관리한다
;;----------------------------------------------------------------------------
(defun org-project-task-file ()
  "ORG 디렉토리의 프로젝트 테스크 파일 경로를 리턴한다"
  (-when-let (proj (ignore-errors (replace-regexp-in-string "^\\." "" (project-name))))
    (f-join org-directory "projects" (concat proj ".org"))))

(defun org-open-project-task-file ()
  (interactive)
  (find-file-other-window (org-project-task-file)))

(global-set-key (kbd "C-c o t") 'org-open-project-task-file)


;;----------------------------------------------------------------------------
;; 뽀모도로
;;----------------------------------------------------------------------------
(require-package 'org-pomodoro)
(require 'init-pomodoro)

(define-key my-keymap (kbd "'") 'org-pomodoro-record-interuptions)
(add-hook 'org-load-hook 'org-pomodoro-on-org-load)
(add-hook 'org-agenda-mode-hook 'org-pomodoro-on-org-agenda-load)

(setq org-src-fontify-natively t)

(provide 'init-org2)
