(autoload 'term-check-proc "term")

(defun terminal-eshell-named (&optional name)
  "Get or create eshell buffer with specified name"
  (let ((eshell-buffer-name (or name eshell-buffer-name)))
    (save-window-excursion (eshell))))

(defun terminal-term-named (&optional name)
  "Get or create term buffer with specified name"
  (let ((buffer (get-buffer-create (or name "*term*"))))
    (when (not (term-check-proc buffer))
      (with-current-buffer buffer
        (term-mode)
        (term-exec buffer (or name "*term*") (getenv "SHELL") nil nil)
        (term-char-mode)
        (goto-char (point-max))))
    buffer))

(defvar terminal--kind-alist
  '((eshell terminal-eshell-named eshell-send-input)
    (term terminal-term-named term-send-input)))

(defun terminal--toggle (kind name)
  "Toggle terminal buffer with the name.
hide -> show -> full screen -> hide
inactive -> switch -> full screen -> hide
"
  (let* ((kind-info (assoc-default kind terminal--kind-alist))
         (buffer (funcall (car kind-info) name)))
    (if (eq (current-buffer) buffer)
        (if (eq (length (window-list)) 1)
            ;; full screen
            (switch-to-buffer (other-buffer))
          ;; active, go to full screen
          (delete-other-windows))
      ;; activate the buffer
      (switch-to-buffer-other-window buffer))))

(defun terminal--here (kind name)
  "Get or create in current directory."
  (let* ((dir default-directory)
         (kind-info (assoc-default kind terminal--kind-alist))
         (buffer (funcall (car kind-info) name)))
    (unless (eq (current-buffer) buffer)
      (switch-to-buffer-other-window buffer)
      (goto-char (point-max))
      (insert (format "cd '%s'" dir))
      (funcall (cadr kind-info)))))

(defun eshell-toggle (&optional name)
  (interactive)
  (terminal--toggle 'eshell name))

(defun eshell-here (&optional name)
  (interactive)
  (terminal--here 'eshell name))

(defun term-toggle (&optional name)
  (interactive)
  (terminal--toggle 'term name))

(defun term-here (&optional name)
  (interactive)
  (terminal--here 'term name))

(defun init--term-exec ()
  "Close buffer when terminal exists."
  (let* ((buff (current-buffer))
         (proc (get-buffer-process buff)))
    (lexical-let ((buff buff))
      (set-process-sentinel proc (lambda (process event)
                                   (if (string= event "finished\n")
                                       (kill-buffer buff)))))))

;; Advice `dired-run-shell-command' with asynchronously.
(defadvice dired-run-shell-command (around dired-run-shell-command-async activate)
  "Postfix COMMAND argument of `dired-run-shell-command' with an ampersand.
If there is none yet, so that it is run asynchronously."
  (let* ((cmd (ad-get-arg 0))
         (cmd-length (length cmd))
         (last-cmd-char (substring cmd
                                   (max 0 (- cmd-length 1))
                                   cmd-length)))
    (unless (string= last-cmd-char "&")
      (ad-set-arg 0 (concat cmd "&")))
    (save-window-excursion ad-do-it)))

(defun init--term-mode ()
  (when (fboundp 'yas-minor-mode)
    (yas-minor-mode -1)))

(add-hook 'term-exec-hook 'init--term-exec)
(add-hook 'term-mode-hook 'init--term-mode)

(define-key my-keymap (kbd "t") 'term-toggle)
(define-key my-keymap (kbd "T") 'term-here)
(define-key my-keymap (kbd "e") 'eshell-toggle)
(define-key my-keymap (kbd "E") 'eshell-here)

(provide 'init-term)
