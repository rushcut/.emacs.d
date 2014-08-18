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
(global-set-key (kbd "C-~") 'previous-error)

(provide 'init-quickrun)
