(defun alternative-files-factories-finder (&optional file)
  (let ((file (or file (alternative-files--detect-file-name))))
    (cond
     ((string-match "^\\(.*\\)/app/models/\\(.+\\)\\.rb$" file)
      (let ((root (match-string 1 file))
            (name (match-string 2 file)))
        (list
         (concat root "/spec/factories/" (alternative-files--pluralize-string name) ".rb"))))

     ((string-match "^\\(.*\\)/spec/factories/\\(.+\\)\\.rb$" file)
      (let* ((root (match-string 1 file))
             (name (match-string 2 file))
             (singular-name (alternative-files--singularize-string name)))
        (list
         (concat root "/app/models/" singular-name ".rb")
         (concat root "/spec/models/" singular-name "_spec.rb")
         (concat root "/app/controllers/" name "_controller.rb")
         (concat root "/spec/controllers/" name "_controller.rb")
         (concat root "/app/helpers/" name "_helper.rb")
         (concat root "/spec/helpers/" name "_helper.rb")
         (concat root "/db/seeds/" name "_spec.rb")
         (concat root "/app/views/" name "/"))))))
  )

(defun alternative-files-go-finder (&optional file)
  (let ((file (or file (alternative-files--detect-file-name))))
    (cond
     ((string-match "^\\(.+\\)_test\\.go$" file)
      (let ((base (match-string 1 file)))
        (list
         (concat base ".go"))))

     ((string-match "^\\(.*\\)\\.go$" file)
      (let* ((base (match-string 1 file)))
        (list
         (concat base "_test.go")))))))

(defun alternative-files-maven-finder (&optional file)
  (let ((file (or file (alternative-files--detect-file-name))))
    (cond
     ((string-match "^\\(.+\\)/\\(?:app\\|main\\)/\\(.+\\)\\.\\(java\\|scala\\)$" file)
      (let ((root (match-string 1 file))
            (name (match-string 2 file))
            (ext (match-string 3 file)))
        (list
         (concat root "/test/" name "Test." ext)
         (concat root "/test/" name "Spec." ext)
         (concat root "/test/" name "Suite." ext))))
     ((string-match "^\\(.+\\)/test/\\(.+\\)\\(?:Test\\|Spec\\|Suite\\)\\.\\(java\\|scala\\)$" file)
      (let ((root (match-string 1 file))
            (name (match-string 2 file))
            (ext (match-string 3 file)))
        (list
         (concat root "/main/" name "." ext)
         (concat root "/app/" name "." ext)))))))

(setq alternative-files-user-functions
      '(alternative-files-factories-finder
        alternative-files-go-finder
        alternative-files-maven-finder))
(setq alternative-files-root-dir-function 'projectile-project-p)

(define-key my-keymap "a" 'alternative-files-find-file)
(define-key my-keymap (kbd "M-a") 'alternative-files-find-file)
(define-key my-keymap (kbd "A") 'alternative-files-create-file)
(global-set-key (kbd "C-c r r") 'alternative-files-find-file)
(global-set-key (kbd "C-c r k") 'alternative-files-create-file)


(provide 'init-alternative-files)
