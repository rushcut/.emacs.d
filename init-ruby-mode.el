(custom-set-variables
 '(ruby-deep-indent-paren nil))

(require-package 'ruby-end)
(require-package 'yari)
(defalias 'ri 'yari)

(defun init--ruby-mode ()
  (local-set-key (kbd "M-s /") 'yari)

  (ruby-end-mode +1)
  (hs-minor-mode +1)
  (turn-on-auto-fill)

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


;;; rails

(require-package 'projectile)
(require-package 'projectile-rails)
(require 'projectile)
(require 'projectile-rails)

(custom-set-variables
 '(projectile-rails-expand-snippet nil))

(defun projectile-rails-find-steps ()
  (interactive)
  (projectile-rails-find-resource "steps: " '(("features/step_definitions/" "features/step_definitions/\\(.+\\)\\.rb$"))))

(define-key projectile-rails-mode-run-map (kbd "r") nil)

(define-key projectile-rails-command-map (kbd "t") 'projectile-rails-find-stylesheet)
(define-key projectile-rails-command-map (kbd "T") 'projectile-rails-find-current-stylesheet)

(define-key projectile-rails-command-map (kbd "s") 'projectile-rails-find-steps)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

(provide 'init-ruby-mode)
