(require 'etags-select)
(setq tags-revert-without-query 1)

(defun ruby-build-ctags ()
  (interactive)
  (message "building project tags")
  (let ((root (project-root)))
    (shell-command (concat "ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f " root "TAGS " root)))
  (ruby-visit-project-tags)
  (message "tags built successfully"))

(defun ruby-visit-project-tags ()
  (interactive)
  (let ((tags-file (concat (project-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

(defun my-find-ruby-tag ()
  (interactive)
  (if (file-exists-p (concat (project-root) "TAGS"))
      (ruby-visit-project-tags)
    (ruby-build-ctags))
  (etags-select-find-tag-at-point))

(defun my-find-ruby-tag-with-rebuild()
  (interactive)
  (ruby-build-ctags)
  (my-find-ruby-tag)
  )

(define-key ruby-mode-map (kbd "M-.") 'my-find-ruby-tag-with-rebuild)

(provide 'init-tags)
