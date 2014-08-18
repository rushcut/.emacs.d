(require-package 'emacs-eclim)
(require 'eclim)
(require 'eclimd)
(require 'java-mode-indent-annotations)

;; (require-package 'malabar-mode)
;; (require 'malabar-mode)
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
;; (require 'ac-emacs-eclim-source)
;; (ac-emacs-lisp-mode-setup)

(defun project-create-maven-dir-structure (package)
  (interactive "sPackage:")
  (let ((package-dir (replace-in-string package "\\." "/")))
    (shell-command-to-string (concat "mkdir -p " (f-join (project-root) "src/main/java" package-dir)))
    (shell-command-to-string (concat "mkdir -p " (f-join (project-root) "src/main/resources" package-dir)))
    (shell-command-to-string (concat "mkdir -p " (f-join (project-root) "src/test/java" package-dir)))
    (shell-command-to-string (concat "mkdir -p " (f-join (project-root) "src/test/resources" package-dir)))
    )
  )


(setq eclimd-default-workspace "~/code/java"
      eclim-executable "/Applications/eclipse/eclim"
      eclim-eclipse-dirs '("/Applications/eclipse/")
      eclim-auto-save t
      help-at-pt-display-when-idle t
      help-at-pt-timer-delay 0.1
      eclimd-wait-for-process nil
      eclim-print-debug-messages nil
      )


(add-lambda 'java-mode-hook
  (eclim-mode)
  (setq c-basic-offset 2
        tab-width 2
        indent-tabs-mode t
        c-label-offset 0)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'inexpr-class 0)
  (help-at-pt-set-timer)
  (java-mode-indent-annotations-setup)
  (remove-hook 'before-save-hook 'delete-trailing-whitespace)
  ;; company
  ;; (require 'company-emacs-eclim)
  ;; (company-emacs-eclim-setup)

  ;; auto-complete
  )
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

;; (popwin:display-buffer-1 "*eclim: problems*")
;; (require 'company)

(defun eclim-goto-super ()
  "Jump to superclass."
  (interactive)
  (save-excursion
    (re-search-backward "extends \\(\\w+\\)" nil t)
    (if (match-string 1)
        (eclim-java-find-type (match-string 1))
      (re-search-forward "extends \\(\\w+\\)" nil t)
      (when (match-string 1)
        (eclim-java-find-type (match-string 1))))))

;;; This version does not visit file in another buffer
(defun eclim--visit-declaration (line)
  (ring-insert find-tag-marker-ring (point-marker))
  (find-file (assoc-default 'filename line))
  (goto-line (assoc-default 'line line))
  (move-to-column (- (assoc-default 'column line) 1)))

(defun eclim-run-test ()
  (interactive)
  (if (not (string= major-mode "java-mode"))
      (message "Sorry cannot run current buffer."))
  (compile (concat eclim-executable " -command java_junit -p " "sniper -t " (eclim-package-and-class))))

;; (add-lambda 'eclim-problems-mode-hook
;;   (define-key evil-normal-state-local-map (kbd "a") 'eclim-problems-show-all)
;;   (define-key evil-normal-state-local-map (kbd "e") 'eclim-problems-show-errors)
;;   (define-key evil-normal-state-local-map (kbd "g") 'eclim-problems-buffer-refresh)
;;   (define-key evil-normal-state-local-map (kbd "q") 'eclim-quit-window)
;;   (define-key evil-normal-state-local-map (kbd "w") 'eclim-problems-show-warnings)
;;   (define-key evil-normal-state-local-map (kbd "f") 'eclim-problems-toggle-filefilter)
;;   (define-key evil-normal-state-local-map (kbd "c") 'eclim-problems-correct)
;;   (define-key evil-normal-state-local-map (kbd "RET") 'eclim-problems-open-current)
;;   )

(defun ant-compile ()
  "Traveling up the path, find build.xml file and run compile."
  (interactive)
  (with-temp-buffer
    (while (and (not (file-exists-p "build.xml"))
                (not (equal "/" default-directory)))
      (cd ".."))
    (call-interactively 'compile)))

(defun run-current-java-file ()
  "Execute the current file's class with Java.
For example, if the current buffer is the file x.java,
then it'll call “java x” in a shell."
  (interactive)
  (let (fnm prog-name cmd-str)
    (setq fnm (file-name-sans-extension
               (file-name-nondirectory (buffer-file-name))))
    (setq prog-name "java")
    (setq cmd-str (concat prog-name " " fnm " &"))
    (shell-command cmd-str)))

;; (defun eclim-ac-complete ()
;;   "Query eclim for available completions at point."
;;   (interactive)
;;   (auto-complete (list ac-source-emacs-eclim)))

(defadvice ethan-wspace-clean-before-save-hook (around eclim-compat activate)
  "Fix spaces being removed while typing because eclim autosaves
  to get completions and ethan-wspace removes 'trailing
  whitespace'"
  (unless (and (eql major-mode 'java-mode)
               ;; (eql evil-state 'insert)
               )
    ad-do-it))

(defconst custom-java-style
  `((c-recognize-knr-p . nil)
    (c-basic-offset . 4)
    (indent-tabs-mode . nil)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (statement-case-open after)
                               (substatement-open after)))
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)))
    (c-hanging-semi&comma-criteria
     . (c-semi&comma-no-newlines-for-oneline-inliners
        c-semi&comma-inside-parenlist
        c-semi&comma-no-newlines-before-nonblanks))
    (c-indent-comments-syntactically-p . nil)
    (comment-column . 40)
    (c-cleanup-list . (brace-else-brace
                       brace-elseif-brace
                       brace-catch-brace
                       empty-defun-braces
                       defun-close-semi
                       list-close-comma
                       scope-operator))
    (c-offsets-alist . (
                        (func-decl-cont . ++)
                        (member-init-intro . ++)
                        (inher-intro . ++)
                        (comment-intro . 0)
                        (arglist-close . c-lineup-arglist)
                        (topmost-intro . 0)
                        (block-open . 0)
                        (inline-open . 0)
                        (substatement-open . 0)
                        (statement-cont
                         .
                         (,(when (fboundp 'c-no-indent-after-java-annotations)
                             'c-no-indent-after-java-annotations)
                          ,(when (fboundp 'c-lineup-assignments)
                             'c-lineup-assignments)
                          ++))
                        (label . /)
                        (case-label . +)
                        (statement-case-open . +)
                        (statement-case-intro . +) ; case w/o {
                        (access-label . /)
                        (innamespace . 0)
                        (arglist-intro . ++)
                        (arglist-cont-nonempty . ++)
                        (annotation-var-cont . 0)))
    (c-block-comment-prefix . "*"))
  "Custom Java Programming Style")

(defun custom-set-java-style ()
  "Set the current buffer's java-style to my Custom Programming Style. Meant to be added to `java-mode-hook'."
  (interactive)
  (make-local-variable 'c-tab-always-indent)
  (setq c-tab-always-indent t)
  (c-toggle-auto-newline 1)
  (c-add-style "custom-java-style" custom-java-style t))

;; (defun eclim-problems-correct ()
;;   (interactive)
;;   (let ((p (eclim--problems-get-current-problem)))
;;     (if (not (string-match "\.java$" (cdr (assoc 'filename p))))
;;         (error "Not a Java file. Corrections are currently supported only for Java.")
;;       (eclim-java-correct (cdr (assoc 'line p)) (eclim--byte-offset))
;;       (message (buffer-name)))))

;; (defun eclim-java-correct (line offset)
;;   "Must be called with the problematic file opened in the current buffer."
;;   (message "Getting corrections...")
;;   (eclim/with-results correction-info ("java_correct" "-p" "-f" ("-l" line) ("-o" offset))
;;     (let ((window-config (current-window-configuration))
;;           (corrections (cdr (assoc 'corrections correction-info)))
;;           (project (eclim--project-name))) ;; store project name before buffer change
;;       (pop-to-buffer "*corrections*")
;;       (erase-buffer)
;;       (use-local-map eclim-java-correct-map)

;;       (insert "Problem: " (cdr (assoc 'message correction-info)) "\n\n")
;;       (if (eq (length corrections) 0)
;;           (insert "No automatic corrections found. Sorry.")
;;         (insert (substitute-command-keys
;;                  (concat
;;                   "Choose a correction by pressing \\[eclim-java-correct-choose]"
;;                   " on it or typing its index. Press \\[eclim-java-correct-quit] to quit"))))
;;       (insert "\n\n")

;;       (dotimes (i (length corrections))
;;         (let ((correction (aref corrections i)))
;;           (insert "------------------------------------------------------------\n"
;;                   "Correction "
;;                   (int-to-string (cdr (assoc 'index correction)))
;;                   ": " (cdr (assoc 'description correction)) "\n\n"
;;                   "Preview:\n\n"
;;                   (cdr (assoc 'preview correction))
;;                   "\n\n")))
;;       (goto-char (point-min))
;;       (setq eclim-corrections-previous-window-config window-config)
;;       (make-local-variable 'eclim-correction-command-info)
;;       (setq eclim-correction-command-info (list 'project project
;;                                                 'line line
;;                                                 'offset offset)))))
(defun jump-to-reverse-file ()
  (interactive)
  (let ((target "foo"))
    (if (string-match-p "src\/main" (buffer-file-name))
        (setq target (replace-regexp-in-string "\\.java" "Test.java" (replace-regexp-in-string "src/main" "src/test" (buffer-file-name))))
      (setq target (replace-regexp-in-string "Test\\.java" ".java" (replace-regexp-in-string "src/test" "src/main" (buffer-file-name))))
      )
    (ffap target)
    ))

(defun project-java-run-test ()
  (interactive)
  (let ((type (project-type)))
    (cond ((eql type 'maven)
           (eclim-maven-run "test"))
          (t (eclim-run-test))
    )
  )
)

(defun project-java-run ()
  (interactive)
  (let ((type (project-type)))
    (cond ((eql type 'maven)
           (eclim-maven-run "exec:java"))
          (t (eclim-run))
    )
  )
)

(defun eclim-java-format ()
  (interactive)
  )



(define-key eclim-mode-map (kbd "C-c j .") 'eclim-java-find-declaration)
(define-key eclim-mode-map (kbd "C-c j r") 'jump-to-reverse-file)

(define-key eclim-mode-map (kbd "C-c j 9") 'start-eclimd)
(define-key eclim-mode-map (kbd "C-c , v") 'project-java-run-test)
(define-key eclim-mode-map (kbd "C-c , r") 'project-java-run)
(define-key eclim-mode-map (kbd "C-c j g") 'eclim-java-find-declaration)
(define-key eclim-mode-map (kbd "C-c C-c") 'eclim-java-find-declaration)

(define-key eclim-mode-map (kbd "C-c j e") 'eclim-run-class)
(define-key eclim-mode-map (kbd "C-c j q") 'eclim-java-format)
(define-key eclim-mode-map (kbd "C-c j d") 'eclim-run-java-doc)
(define-key eclim-mode-map (kbd "C-c j i") 'eclim-java-import-organize)
(define-key eclim-mode-map (kbd "C-c j I") 'eclim-java-implement)
;; (define-key eclim-mode-map (kbd "C-c j r") 'eclim-java-find-references)
(define-key eclim-mode-map (kbd "C-c j b") 'eclim-project-build)

(define-key eclim-mode-map (kbd "C-c j .") 'eclim-java-file-type)
(define-key eclim-mode-map (kbd "C-c j a") 'eclim-java-find-references)

(define-key eclim-mode-map (kbd "C-c j c") 'eclim-problems-compilation-buffer)

(define-key eclim-mode-map (kbd "C-c j c") 'eclim-problems-correct)
(define-key eclim-mode-map (kbd "C-c j p c") 'eclim-problems-correct)
(define-key eclim-mode-map (kbd "C-c j o") 'eclim-problems-open)
(define-key eclim-mode-map (kbd "C-c j p o") 'eclim-problems-open)
(define-key eclim-mode-map (kbd "C-c j p f") 'eclim-problems-refocus)
(define-key eclim-mode-map (kbd "C-c j p h") 'eclim-problems-highlight)
(define-key eclim-mode-map (kbd "C-c j f") 'eclim-problems-buffer-refresh)

(define-key eclim-mode-map (kbd "C-c j m") 'eclim-maven-run)
(define-key eclim-mode-map (kbd "C-c j l") 'eclim-maven-lifecycle-phase-run)
(define-key eclim-mode-map (kbd "C-c j t") 'eclim-toggle-print-debug-messages)

(define-key eclim-mode-map (kbd "C-c j s") 'eclim-goto-super)
(define-key eclim-mode-map (kbd "C-c j w") 'eclim-java-doc-comment)

;; (define-key eclim-mode-map (kbd "C-.") 'company-emacs-eclim)

(add-hook 'eclim-problems-mode-hook
          (lambda ()
            (setq mode-line-format nil)
            ))

(add-hook 'after-save 'eclim-problems-buffer-refresh)
;; (add-hook 'before-save 'eclim-java-format)


;; (require-package 'emacs-eclim)
;; (require 'company-emacs-eclim)
;; (require 'eclim)
;; (require 'eclim-maven)
;; (require 'eclimd)
;; (require 'java-mode-indent-annotations)

;; (setq eclimd-default-workspace "~/code/java"
;;       eclim-executable "/Applications/eclipse/eclim"
;;       eclim-eclipse-dirs '("/Applications/eclipse/")
;;       eclim-auto-save t
;;       help-at-pt-display-when-idle t
;;       help-at-pt-timer-delay 0.1
;;       eclimd-wait-for-process nil
;;       eclim-print-debug-messages nil
;;       )

;; (add-lambda 'java-mode-hook
;;   (setq c-basic-offset 2
;;         c-label-offset 0)
;;   (c-set-offset 'substatement-open 0)
;;   (c-set-offset 'inexpr-class 0)

;;   (company-emacs-eclim-setup)

;;   (help-at-pt-set-timer)
;;   (java-mode-indent-annotations-setup)
;;   (turn-off-auto-fill)
;;   (longlines-mode-off)
;;   (when eclim-mode
;;     (company-emacs-eclim-setup))
;;   )

;;   (defun display-eclim-buffer ()
;;     (interactive)
;;     (let ((buffer next-error-last-buffer)
;;           list)
;;       (unless (buffer-live-p next-error-last-buffer)
;;         (setq list (buffer-list))
;;         (while (and list (not (buffer-live-p next-error-last-buffer)))
;;           (with-current-buffer (car list)
;;             (and (or (derived-mode-p 'eclim-problems-mode))
;;                  (setq next-error-last-buffer (car list))))
;;           (setq list (cdr list))))
;;       (if (buffer-live-p next-error-last-buffer)
;;           (select-window
;;            (display-buffer next-error-last-buffer))
;;         (eclim-problems)
;;   )))

;; (defun eclim-problems-correct ()
;;   (interactive)
;;   (let ((p (eclim--problems-get-current-problem)))
;;     (if (not (string-match "\.java$" (cdr (assoc 'filename p))))
;;         (error "Not a Java file. Corrections are currently supported only for Java.")
;;       (eclim-java-correct (cdr (assoc 'line p)) (eclim--byte-offset))
;;       (message (buffer-name)))))

;; ;; (defun eclim-java-correct (line offset)
;; ;;   "Must be called with the problematic file opened in the current buffer."
;; ;;   (message "Getting corrections...")
;; ;;   (eclim/with-results correction-info ("java_correct" "-p" "-f" ("-l" line) ("-o" offset))
;; ;;     (let ((window-config (current-window-configuration))
;; ;;           (corrections (cdr (assoc 'corrections correction-info)))
;; ;;           (project (eclim--project-name))) ;; store project name before buffer change
;; ;;       (pop-to-buffer "*corrections*")
;; ;;       (erase-buffer)
;; ;;       (use-local-map eclim-java-correct-map)

;; ;;       (insert "Problem: " (cdr (assoc 'message correction-info)) "\n\n")
;; ;;       (if (eq (length corrections) 0)
;; ;;           (insert "No automatic corrections found. Sorry.")
;; ;;         (insert (substitute-command-keys
;; ;;                  (concat
;; ;;                   "Choose a correction by pressing \\[eclim-java-correct-choose]"
;; ;;                   " on it or typing its index. Press \\[eclim-java-correct-quit] to quit"))))
;; ;;       (insert "\n\n")

;; ;;       (dotimes (i (length corrections))
;; ;;         (let ((correction (aref corrections i)))
;; ;;           (insert "------------------------------------------------------------\n"
;; ;;                   "Correction "
;; ;;                   (int-to-string (cdr (assoc 'index correction)))
;; ;;                   ": " (cdr (assoc 'description correction)) "\n\n"
;; ;;                   "Preview:\n\n"
;; ;;                   (cdr (assoc 'preview correction))
;; ;;                   "\n\n")))
;; ;;       (goto-char (point-min))
;; ;;       (setq eclim-corrections-previous-window-config window-config)
;; ;;       (make-local-variable 'eclim-correction-command-info)
;; ;;       (setq eclim-correction-command-info (list 'project project
;; ;;                                                 'line line
;; ;;                                                 'offset offset)))))

;; ;; ;; (autoload 'start-eclimd "eclimd" nil t)

;; ;; ;; (defun projectile-maybe-turn-on-eclim ()
;; ;; ;;   (when (and buffer-file-name
;; ;; ;;              (file-exists-p (concat (projectile-project-p) ".project"))
;; ;; ;;              (eclim--accepted-p buffer-file-name)
;; ;; ;;              (eclim--project-dir buffer-file-name))
;; ;; ;;     (eclim-mode +1)))
;; ;; ;; (defun init--eclim-mode ()
;; ;; ;;   ;; (when (boundp 'ac-sources)
;; ;; ;;   ;;   (if (eq (car ac-sources) 'ac-source-yasnippet)
;; ;; ;;   ;;       (setq ac-sources (cons 'ac-source-yasnippet (cons 'ac-source-emacs-eclim (cdr ac-sources))))
;; ;; ;;   ;;     (setq ac-sources (cons 'ac-source-emacs-eclim ac-sources))))
;; ;; ;;   ;; (define-key eclim-mode-map (kbd "C-c C-e C-;") 'eclim-problems-correct)
;; ;; ;;   ;; (define-key eclim-mode-map (kbd "C-c C-e C-n") 'eclim-problems-next)
;; ;; ;;   ;; (define-key eclim-mode-map (kbd "C-c C-e C-p") 'eclim-problems-previous)
;; ;; ;;   )

;; ;; ;; (add-hook 'eclim-mode-hook 'init--eclim-mode)

;; ;; ;; (defun eclim-enable ()
;; ;; ;;   (interactive)
;; ;; ;;   (require 'eclim)
;; ;; ;;   ;; (require 'company-emacs-eclim)
;; ;; ;;   ;; (company-emacs-eclim-setup)

;; ;; ;;   (add-hook 'projectile-mode-hook 'projectile-maybe-turn-on-eclim)

;; ;; ;;   (mapc (lambda (buffer)
;; ;; ;;           (with-current-buffer buffer
;; ;; ;;             (when (and buffer-file-name
;; ;; ;;                        (eclim--accepted-p buffer-file-name)
;; ;; ;;                        (eclim--project-dir buffer-file-name))
;; ;; ;;               (eclim-mode +1))))
;; ;; ;;         (buffer-list)))

;; ;; ;; (defun eclim-disable ()
;; ;; ;;   (interactive)
;; ;; ;;   (remove-hook 'projectile-mode-hook 'projectile-maybe-turn-on-eclim)
;; ;; ;;   (mapc (lambda (buffer)
;; ;; ;;           (with-current-buffer buffer
;; ;; ;;             (eclim-mode -1)))
;; ;; ;;         (buffer-list)))

;; ;; (define-key eclim-mode-map (kbd "C-c j r") 'jump-to-reverse-file)

;; ;; (define-key eclim-mode-map (kbd "C-c j 9") 'start-eclimd)
;; ;; (define-key eclim-mode-map (kbd "C-c , v") 'eclim-run-test)

;; ;; (define-key eclim-mode-map (kbd "C-c j e") 'eclim-run-class)
;; ;; (define-key eclim-mode-map (kbd "C-c j q") 'eclim-java-format)
;; ;; (define-key eclim-mode-map (kbd "C-c j d") 'eclim-run-java-doc)
;; ;; (define-key eclim-mode-map (kbd "C-c j i") 'eclim-java-implement)
;; ;; ;; (define-key eclim-mode-map (kbd "C-c j r") 'eclim-java-find-references)
;; ;; (define-key eclim-mode-map (kbd "C-c j b") 'eclim-project-build)

;; ;; (define-key eclim-mode-map (kbd "C-c j .") 'eclim-java-file-type)
;; ;; (define-key eclim-mode-map (kbd "C-c j a") 'eclim-java-find-references)

;; ;; (define-key eclim-mode-map (kbd "C-c j c") 'eclim-problems-compilation-buffer)

;; ;; (define-key eclim-mode-map (kbd "C-c j c") 'eclim-problems-correct)
;; ;; (define-key eclim-mode-map (kbd "C-c j p c") 'eclim-problems-correct)
;; ;; (define-key eclim-mode-map (kbd "C-c j o") 'eclim-problems-open)
;; (define-key eclim-mode-map (kbd "C-c j p o") 'eclim-problems-open)
;; ;; (define-key eclim-mode-map (kbd "C-c j p f") 'eclim-problems-refocus)
;; ;; (define-key eclim-mode-map (kbd "C-c j p h") 'eclim-problems-highlight)
;; ;; (define-key eclim-mode-map (kbd "C-c j f") 'eclim-problems-buffer-refresh)

;; ;; (define-key eclim-mode-map (kbd "C-c j m") 'eclim-maven-run)
;; ;; (define-key eclim-mode-map (kbd "C-c j l") 'eclim-maven-lifecycle-phase-run)
;; ;; (define-key eclim-mode-map (kbd "C-c j t") 'eclim-toggle-print-debug-messages)

;; ;; (define-key eclim-mode-map (kbd "C-c j s") 'eclim-goto-super)
;; ;; (define-key eclim-mode-map (kbd "C-c j w") 'eclim-java-doc-comment)

(add-hook 'after-save 'eclim-problems-buffer-refresh)

(provide 'init-java-mode)
