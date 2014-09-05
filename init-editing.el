;;----------------------------------------------------------------------------
;; Undo Tree
;;----------------------------------------------------------------------------
(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

(define-key undo-tree-map (kbd "C-/") nil) ;; disable not works in TERM
(define-key undo-tree-map (kbd "C-?") nil) ;; disable not works in TERM

(require-package 'ace-jump-mode)

(global-set-key (kbd "C-ㅌ C-ㄴ") 'save-buffer)
(global-set-key (kbd "C-ㅜ") 'next-line)
(global-set-key (kbd "C-ㅔ") 'previous-line)

(global-set-key (kbd "M-g l") 'ace-jump-line-mode)
(global-set-key (kbd "M-g w") 'ace-jump-word-mode)
;; (define-key my-keymap (kbd "M-g") 'what-line)
;; (global-set-key (kbd "M-g L") 'move-to-window-line-top-bottom)

;;----------------------------------------------------------------------------
;; Expand region
;;----------------------------------------------------------------------------
(require-package 'expand-region)
(global-set-key (kbd "M-l") 'er/expand-region)

;;----------------------------------------------------------------------------
;; Cut/copy the current line if no region is active
;;----------------------------------------------------------------------------
(require-package 'whole-line-or-region)
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)

;; (require 'key-chord)
;; (key-chord-mode 1)
;; (key-chord-define-global "fj" 'ace-jump-word-mode)


;;----------------------------------------------------------------------------
;; Drag Stuff
;;----------------------------------------------------------------------------
(require-package 'drag-stuff)
(drag-stuff-global-mode t)

(global-set-key (kbd "ESC <up>") 'drag-stuff-up)
(global-set-key (kbd "ESC <down>") 'drag-stuff-down)
(global-set-key (kbd "M-<up>") 'drag-stuff-up)
(global-set-key (kbd "M-<down>") 'drag-stuff-down)

(global-set-key (kbd "M-p") 'drag-stuff-up)
(global-set-key (kbd "M-n") 'drag-stuff-down)


;;----------------------------------------------------------------------------
;; Textmate Shift
;;----------------------------------------------------------------------------
(defun textmate-shift-right (&optional arg)
  "Shift the line or region to the ARG places to the right.
A place is considered `tab-width' character columns."
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning))
                 (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position))))
    (indent-rigidly beg end (* (or arg 1) tab-width))))

(defun textmate-shift-left (&optional arg)
  "Shift the line or region to the ARG places to the left."
  (interactive)
  (textmate-shift-right (* -1 (or arg 1))))

(global-set-key (kbd "M-[") 'textmate-shift-left)
(global-set-key (kbd "M-]") 'textmate-shift-right)

;;----------------------------------------------------------------------------
;; Duplicate Line or Region
;;----------------------------------------------------------------------------
(defun duplicate-line-or-region (&optional n)
  "Duplicate current line, or region if active.
  With argument N, make N copies.
  With negative N, comment out original line and use the absolute value."
  (interactive "*p")
  (let ((use-region (use-region-p)))
    (save-excursion
      (let ((text (if use-region        ;Get region if active, otherwise line
                      (buffer-substring (region-beginning) (region-end))
                    (prog1 (thing-at-point 'line)
                      (end-of-line)
                      (if (< 0 (forward-line 1)) ;Go to beginning of next line, or make a new one
                          (newline))))
                  ))
        (dotimes (i (abs (or n 1)))     ;Insert N times, or once if not specified
          (insert text))))
    (if use-region nil                  ;Only if we're working with a line (not a region)
      (let ((pos (- (point) (line-beginning-position)))) ;Save column
        (if (> 0 n)                             ;Comment out original with negative arg
            (comment-region (line-beginning-position) (line-end-position)))
        (forward-line 1)
        (forward-char pos)))))

(global-unset-key (kbd "C-c d"))
(global-set-key (kbd "C-c d") 'duplicate-line-or-region)


;;----------------------------------------------------------------------------
;; Kill Ring
;;----------------------------------------------------------------------------
(custom-set-variables
 '(kill-ring-max 500))

(require-package 'browse-kill-ring)
(require-package 'kill-ring-search)

(global-set-key (kbd "C-M-y") 'browse-kill-ring)

(defadvice yank-pop (around kill-ring-search-maybe (arg) activate)
  "If last action was not a yank, run `kill-ring-search' instead."
  (interactive "p")
  (if (not (eq last-command 'yank))
      (kill-ring-search)
    (barf-if-buffer-read-only)
    ad-do-it))

;;----------------------------------------------------------------------------
;; Mac Shared Clipboard
;;----------------------------------------------------------------------------
(if *is-a-mac* (require 'pbcopy))

(provide 'init-editing)
