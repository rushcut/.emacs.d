(custom-set-variables
 '(ruby-deep-indent-paren nil))

(require-package 'ruby-end)
(require-package 'yari)
(defalias 'ri 'yari)

(defun init--ruby-mode ()
  (local-set-key (kbd "M-s /") 'yari)
  (setq ac-auto-start t)
  ;; (ruby-end-mode +1)
  (hs-minor-mode +1)
  ;; (turn-on-auto-fill)

  (setq autopair-extra-pairs '(:code ((?` . ?`)))))

;;https://gist.github.com/dgutov/1274520
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; Only expand when last command is self-insert
(defadvice ruby-end-expand-p (around no-duplicate-end activate)
  (if (eq last-command 'self-insert-command)
      ad-do-it
    (setq ad-return-value nil)))

;; (push 'company-robe company-backends)
;; (defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
;;   (rvm-activate-corresponding-ruby))

;; (require-package 'company-inf-ruby)
;; (require 'company-inf-ruby)
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-inf-ruby))

;;; Inferior ruby
(require-package 'inf-ruby)
(require-package 'ac-inf-ruby)
(after-load 'auto-complete (add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(defun init--inf-ruby-mode ()
  (setq ac-auto-start nil)
  (define-key inf-ruby-mode-map (kbd "TAB") 'auto-complete)
)
(add-hook 'inf-ruby-mode-hook 'init--inf-ruby-mode)

(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.tokamak\\'" . ruby-mode))

(add-hook 'ruby-mode-hook 'init--ruby-mode)

;; feature
(require 'feature-mode)
;;(require-package 'feature-mode)

;; (setq feuature-use-rvm t)

(add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))
(custom-set-variables
 '(feature-default-language "ko")
 '(feature-cucumber-command "rake cucumber CUCUMBER_OPTS=\"{options} -r features\" FEATURE=\"{feature}\"")
 )
(setq feature-default-i18n-file "~/.emacs.d/etc/cucumber_i18n.yml")

(require-package 'rvm)
(rvm-use-default)

(global-set-key (kbd "M-s u") 'rvm-activate-corresponding-ruby)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; RSPEC-MODE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-package 'rspec-mode)
;; (add-hook 'haml-mode-hook 'rspec-mode)
;; (add-hook 'web-mode-hook 'rspec-mode)

;; (modify-syntax-entry ?_ "w" haml-mode-syntax-table)

(setq rspec-use-bundler-when-possible nil)
(setq rspec-use-rake-when-possible nil)

;;; rails

(require-package 'projectile)
(require-package 'projectile-rails)
(require 'projectile)
(require 'projectile-rails)

(defun projectile-rails-root ()
  "Returns rails root directory if this file is a part of a Rails application else nil"
  (ignore-errors
    (let ((root (projectile-project-root)))
      (when (or (file-exists-p (expand-file-name "features/support/env.rb" root))
                (file-exists-p (expand-file-name "config/application.rb" root)))
        root))))

(custom-set-variables
 '(projectile-rails-expand-snippet nil))

(defun projectile-rails-find-steps ()
  (interactive)
  (projectile-rails-find-resource "steps: " '(("features/step_definitions/" "features/step_definitions/\\(.+\\)\\.rb$"))))

(defun projectile-rails-find-config ()
  (interactive)
  (projectile-rails-find-resource "config: " '(("config/" "config/\\(.+\\)\\.rb$"))))

(defun projectile-rails-find-features-support ()
  (interactive)
  (projectile-rails-find-resource "features/support: " '(("features/support/" "features/support/\\(.+\\)\\.*$"))))

(define-key projectile-rails-mode-run-map (kbd "r") nil)
(define-key projectile-rails-command-map (kbd "r") 'alternative-files-find-file) ;; console

(define-key projectile-rails-command-map (kbd "t") 'projectile-rails-find-stylesheet)
(define-key projectile-rails-command-map (kbd "T") 'projectile-rails-find-current-stylesheet)

(define-key projectile-rails-command-map (kbd "s") 'projectile-rails-find-steps)
(define-key projectile-rails-command-map (kbd "2") 'projectile-rails-find-features-support)

(define-key projectile-rails-command-map (kbd "o") 'projectile-rails-find-config)

(define-key projectile-rails-mode-map (kbd "C-c , f") 'feature-verify-all-scenarios-in-project)

(add-hook 'projectile-mode-hook 'projectile-rails-on)


;; TAGS

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

(provide 'init-ruby-mode)
