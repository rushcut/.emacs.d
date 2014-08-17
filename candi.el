(define-module files-commands
  (global-set-key (kbd "C-x C-r") 'mf-rename-current-buffer-file)
  (global-set-key (kbd "C-x M-f") 'mf-find-alternative-file-with-sudo)
  (when (locate-file "gpicker" exec-path)
    (define-key my-keymap "g" 'gpicker-find-file)
    (define-key my-keymap (kbd "M-g") 'gpicker-find-file)))

(define-module isearch
  ;; Activate occur easily inside isearch
  (define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

  ;; http://www.emacswiki.org/emacs/ZapToISearch
  (defun isearch-exit-other-end (rbeg rend)
    "Exit isearch, but at the other end of the search string.
This is useful when followed by an immediate kill."
    (interactive "r")
    (isearch-exit)
    (goto-char isearch-other-end))

  (define-key isearch-mode-map [(control return)] 'isearch-exit-other-end)

  (defvar isearch-initial-string nil)

  (defun isearch-set-initial-string ()
    (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
    (setq isearch-string isearch-initial-string)
    (isearch-search-and-update))

  (defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
    "Interactive search forward for the symbol at point."
    (interactive "P\np")
    (if regexp-p (isearch-forward regexp-p no-recursive-edit)
      (let* ((end (progn (skip-syntax-forward "w_") (point)))
             (begin (progn (skip-syntax-backward "w_") (point))))
        (if (eq begin end)
            (isearch-forward regexp-p no-recursive-edit)
          (setq isearch-initial-string (buffer-substring begin end))
          (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
          (isearch-forward regexp-p no-recursive-edit)))))

  (define-key my-keymap "*" 'isearch-forward-at-point)
  (define-key my-keymap "8" 'isearch-forward-at-point))

()

(define-module compile-and-run
  (require-package 'quickrun)

  (custom-set-variables
   '(compilation-auto-jump-to-first-error nil)
   '(compilation-context-lines 5)
   '(compilation-scroll-output (quote first-error)))

  (defun init--compile-load (&rest ignore)
    (require 'ansi-color)
    (define-key compilation-mode-map "l" 'compilation-restore-mode-line)
    (define-key compilation-mode-map "c" 'compilation-clear-screen)
    (remove-hook 'compilation-start-hook 'init--compile-load))
  (add-hook 'compilation-start-hook 'init--compile-load)

  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region (point-min) (point-max))
    (toggle-read-only))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

  (defcustom compilation-defualt-mode-line-background "#1e2320"
    "Default mode line background"
    :group 'compilation)
  (defcustom compilation-error-mode-line-background "#310602"
    "Error mode line background"
    :group 'compilation)

  (defun compilation-notify-result (buffer message)
    (unless (member major-mode '(ag-mode))
      (setq message (s-trim message))
      (let ((pass (string= message "finished")))
        (notify mode-name message
                :icon (if pass "dialog-ok" "dialog-error"))
        (if pass
            (set-face-attribute 'mode-line nil :background compilation-defualt-mode-line-background)
          (set-face-attribute 'mode-line nil :background compilation-error-mode-line-background)))))

  (defun compilation-restore-mode-line ()
    (interactive)
    (setq compilation-in-progress nil)
    (set-face-attribute 'mode-line nil :background compilation-defualt-mode-line-background))

  (defun compilation-clear-screen ()
    (interactive)
    (toggle-read-only)
    (erase-buffer)
    (toggle-read-only))

  ;; (when (fboundp 'notify)
  ;;  (add-hook 'compilation-finish-functions 'compilation-notify-result))

  (defvar run-or-replace-template-history nil "History for `run-or-replace-template'")
  (defun run-or-replace-template-fill (command &optional src)
    (let* ((case-fold-search  nil)
           (path (expand-file-name (or src (buffer-file-name) default-directory)))
           (info `(("%f" . ,(file-name-nondirectory path))
                   ("%F" . ,path)
                   ("%p" . ,path)
                   ("%n" . ,(file-name-sans-extension (file-name-nondirectory path)))
                   ("%d" . ,(file-name-directory path))
                   ("%e" . ,(file-name-extension path))))
           (str command))
      (mapc (lambda (holder)
              (setq str (replace-regexp-in-string (car holder) (cdr holder) str t)))
            info)
      str))

  (defun run-or-replace-template (command &optional remember)
    (interactive (list (if (minibufferp)
                           (buffer-substring (minibuffer-prompt-end) (point-max))
                         (read-from-minibuffer "Shell command: "
                                               (car run-or-replace-template-history) nil nil
                                               '(run-or-replace-template-history . 1)))
                       current-prefix-arg))
    (if (minibufferp)
        (progn
          (delete-minibuffer-contents)
          (goto-char (minibuffer-prompt-end))
          (insert (with-current-buffer (window-buffer (minibuffer-selected-window))
                    (run-or-replace-template-fill command))))
      (setq command (run-or-replace-template-fill command))
      (when remember
        (let ((map (make-sparse-keymap))
              (dir default-directory))
          (define-key map (kbd "r") (eval `(lambda () (interactive)
                                             (let ((default-directory ,dir))
                                               (compile ,command)))))
          (global-set-key (kbd "M-s v") map)))
      (compile command)))

  (defadvice quickrun (around init--quick-run)
    (init--quick-run)
    ad-do-it
    (ad-disable-advice 'quickrun 'around 'init--quick-run)
    (ad-activate 'quickrun))
  (ad-enable-advice 'quickrun 'around 'init--quick-run)
  (ad-activate 'quickrun)

  (defvar mono-bin-dir "/usr/local/bin" "Binary directory containing mcs and mono.")

  (defun init--quick-run ()
    (quickrun-add-command
     "objc" '((:command . "gcc")
              (:exec    . ((lambda ()
                             (if (eq system-type 'darwin)
                                 "%c -x objective-c %o -o %e %s -framework foundation"
                               "%c -x objective-c %o -o %e %s `gnustep-config --objc-flags` `gnustep-config --base-libs`"))
                           "%e %a"))
              (:remove  . ("%e"))
              (:description . "Compile Objective-C file with gcc and execute"))
     :override t)
    (quickrun-add-command
     "csharp/mono" `((:command . ,(concat mono-bin-dir "/mcs"))
              (:exec    . ("%c %o -out:%e %s"
                           ,(concat mono-bin-dir "/mono %e %a")))
              (:remove  . ("%e"))
              (:description . "Compile Objective-C file with gcc and execute")))
    (setq quickrun/major-mode-alist (cons
                                     '(csharp-mode . "csharp/mono")
                                     quickrun/major-mode-alist)))

  (defun init--new-scratch (&optional extension)
    "Create a temporary file with given EXTENSION."
    (interactive "sextension: ")
    (find-file-other-window (make-temp-file "scratch-" nil
                                            (concat "." (or extension "txt")))))

  (global-set-key [f5] 'compile)
  (define-key my-keymap (kbd "5") 'compile)
  (define-key my-keymap (kbd "M-c") 'recompile)

  (define-key my-keymap (kbd "c") 'quickrun-compile-only)
  (define-key my-keymap (kbd "x") 'quickrun)
  (define-key my-keymap (kbd "M-x") 'init--new-scratch)
  (global-set-key (kbd "C-1") 'run-or-replace-template)
  (define-key my-keymap (kbd "1") 'run-or-replace-template)
  (global-set-key (kbd "C-`") 'next-error)
  (global-set-key (kbd "C-~") 'previous-error))

(define-module whitespace
  (custom-set-variables
   '(whitespace-action nil)
   '(whitespace-global-modes nil)
   '(whitespace-line-column nil)
   '(whitespace-style (quote (face tabs trailing newline indentation space-before-tab tab-mark newline-mark)))
   '(coffee-cleanup-whitespace nil)
   '(recentf-save-file (expand-file-name ".recentf" user-emacs-directory)))
  (add-hook 'prog-mode-hook 'whitespace-mode)
  (defun whitespace-cleanup-and-save ()
    (interactive)
    (whitespace-cleanup)
    (call-interactively (key-binding (kbd "C-x C-s"))))
  (define-key my-keymap (kbd "SPC") 'whitespace-cleanup-and-save))

(define-module bookmark
  (custom-set-variables
   '(bookmark-use-annotations nil))

  (global-set-key (kbd "C-x j SPC") 'jump-to-register))

(define-module spell
  (custom-set-variables
   '(flyspell-use-meta-tab nil))

  (defun init--flyspell-mode ()
    (define-key flyspell-mode-map [(control ?\,)] nil)
    (define-key flyspell-mode-map [(control ?\.)] nil))

  (add-hook 'flyspell-mode-hook 'init--flyspell-mode)

  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'message-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'flyspell-mode)

  (global-set-key (kbd "C-4") 'ispell-word))

(define-module tab-fix
  (defun tab-fix-keymap (map)
    (let ((binding (assoc 'tab map)))
      (when binding
        (setcar binding 9))))

  (defun tab-fix-org-mode ()
    (tab-fix-keymap org-mode-map)
    (remove-hook 'org-mode-hook 'tab-fix-org-mode))
  (add-hook 'org-mode-hook 'tab-fix-org-mode)

  (defun tab-fix-markdown-mode ()
    (tab-fix-keymap markdown-mode-map)
    (remove-hook 'markdown-mode-hook 'tab-fix-org-mode))
  (add-hook 'markdown-mode-hook 'tab-fix-org-mode))


(define-module yasnippet
  (require-package 'yasnippet)
  (require-package 'popup)
  (require 'popup nil t)
  (when (featurep 'popup)

    (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
    (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
    (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
    (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
    (define-key popup-menu-keymap (kbd "M-p") 'popup-previous))

  (custom-set-variables
   '(yas-trigger-key "M-RET")
   ;; Add yas-expand itself, so when auto-complete completes and retry, yas-expand can work.
   ;; '(yas-expand-only-for-last-commands '(self-insert-command org-self-insert-command yas-expand ac-next ac-previous ac-expand))
   '(yas-choose-keys-first nil)
   ;; '(yas-prompt-functions (quote (yas-popup-isearch-prompt
   ;;                                yas-ido-prompt
   ;;                                yas-x-prompt
   ;;                                yas-no-prompt)))
   '(yas-wrap-around-region nil)
   '(yas-use-menu nil)
   '(yas-triggers-in-field t)
   '(yas/indent-line 'fixed)
   )

  (add-hook 'yas-minor-mode-hook
            (lambda ()
              (define-key yas-minor-mode-map (kbd "TAB") nil)
              (define-key yas-minor-mode-map [(tab)] nil)))

  (global-unset-key (kbd "M-RET"))
  (define-key global-map (kbd "M-RET") 'yas-expand)

  (yas-global-mode t)

  (global-set-key (kbd "C-c y n") `yas-new-snippet)
  (global-set-key (kbd "C-c y v") `yas-visit-snippet-file)
  (global-set-key (kbd "C-c y f") `yas-find-snippets)
  (global-set-key (kbd "C-c y r") `yas-reload-all)

  (defun yas/popup-isearch-prompt (prompt choices &optional display-fn)
    (when (featurep 'popup)
      (popup-menu*
       (mapcar
        (lambda (choice)
          (popup-make-item
           (or (and display-fn (funcall display-fn choice))
               choice)
           :value choice))
        choices)
       :prompt prompt
       ;; start isearch mode immediately
       :isearch t
       )))

  (setq yas/prompt-functions '(yas/popup-isearch-prompt yas/no-prompt))
  (setq ac-source-yasnippet nil)

  (defun yas-buffer-name-stub ()
    (let ((name (or (buffer-file-name)
                    (buffer-name))))
      (replace-regexp-in-string
       "^t_\\|_?\\(test\\|spec\\)$" ""
       (file-name-sans-extension (file-name-nondirectory name)))))

  (defun yas-safer-expand ()
    (let ((yas-fallback-behavior 'return-nil))
      (call-interactively 'yas-expand)))

  (defun yas-ido-insert-snippets (&optional no-condition)
    (interactive "P")
    (let ((yas-prompt-functions '(yas-ido-prompt)))
      (yas-insert-snippet)))

  (defvar yas-popup-remember-pattern nil)
  (defadvice popup-isearch-prompt (after remember-pattern (popup pattern) activate)
    (setq yas-popup-remember-pattern pattern))

  (defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
    (when (featurep 'popup)
      (setq yas-popup-remember-pattern nil)
      (or
       (popup-menu*
        (mapcar
         (lambda (choice)
           (popup-make-item
            (or (and display-fn (funcall display-fn choice))
                choice)
            :value choice))
         choices)
        :prompt prompt
        :isearch t
        ) yas-popup-remember-pattern)))

  (defadvice yas--menu-keymap-get-create (around ignore (mode &optional parents) activate)
    (setq ad-return-value (make-sparse-keymap)))

  (define-key my-keymap (kbd "<tab>") 'yas-insert-snippet)

  (let ((map (make-sparse-keymap)))
    ;; (define-key map (kbd "M-/") 'yas-ido-insert-snippets)
    ;; (define-key map (kbd "/") 'yas-ido-insert-snippets)
    ;; (define-key map (kbd "n") 'yas-new-snippet)
    ;; (define-key map (kbd "o") 'yas-visit-snippet-file)
    ;; (define-key map (kbd "i") 'auto-insert)
    (define-key map (kbd "RET") 'zencoding-expand-yas)
    ;; (define-key my-keymap (kbd "M-/") map)
  )

  (setq yas-snippet-dirs (list (expand-file-name "snippets" user-emacs-directory)))
  (yas-global-mode +1)
  (defadvice yas-reload-all (before yas-recompile-all-before-reload activate)
    (yas-recompile-all)))
(define-module auto-insert
  (require 'autoinsert)
  (define-key my-keymap (kbd "C-n") 'auto-insert)

  (custom-set-variables
   '(auto-insert-directory (expand-file-name "insert/" user-emacs-directory)))

  (defvar auto-insert-alist-default auto-insert-alist)

  (setq auto-insert-alist
        (append
         '((("\\.erl\\'" . "Erlang Module")
            nil
            "-module("
            (file-name-nondirectory
             (file-name-sans-extension buffer-file-name))
            ")." \n
            "-export([" _ "]).\n"))
         auto-insert-alist-default)))
(define-module search-files
  (require-package 'ag)
  (require-package 'wgrep-ag)

  (define-key my-keymap (kbd "o") 'occur)
  (define-key my-keymap (kbd "O") 'multi-occur)
  (define-key my-keymap (kbd "C-o") 'multi-occur-in-matching-buffers)
  (global-set-key (kbd "<f9>") 'rgrep)
  (global-set-key (kbd "<f10>") 'find-dired)
  (global-set-key (kbd "<f11>") 'find-grep-dired))
