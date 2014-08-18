(add-to-list 'load-path user-emacs-directory)

(defconst *is-a-mac* (eq system-type 'darwin))(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

(ido-mode t)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default
 inhibit-startup-message t
 inhibit-splash-screen t
 confirm-kill-emacs 'yes-or-no-p
 blink-cursor-delay 0
 blink-cursor-interval 0.4
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 compilation-scroll-output t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 grep-highlight-matches t
 grep-scroll-output t
 indent-tabs-mode nil
 tab-width 2
 line-spacing 0
 mouse-yank-at-point nil
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t
 display-buffer-reuse-frames t
 )
;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(custom-set-variables
 '(current-language-environment "UTF-8")
 '(locale-coding-system 'utf-8)
 '(ruby-insert-encoding-magic-comment nil)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Auto Revert
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (flet ((yes-or-no-p (prompt) t)) (revert-buffer)))

;; Auto refresh buffers
(global-auto-revert-mode +1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Auto Indent
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "RET") 'newline-and-indent)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Delete Whitespace
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; BACKUP
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Place all backup files into this directory
(custom-set-variables
 '(auto-save-interval 300)
 '(auto-save-timeout 10)
 '(backup-directory-alist (list (cons "." (expand-file-name "backups" user-emacs-directory))))
 '(backup-by-copying t)
 '(delete-old-versions t)
 '(kept-new-versions 30)
 '(kept-old-versions 5)
 '(vc-make-backup-files t)
 '(version-control t)
 '(delete-by-moving-to-trash t)
 '(grep-find-ignored-directories
   (quote
    ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "tmp" "log" "vendor")))
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; META-KEYS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when *is-a-mac*
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super)
  (setq default-input-method "MacOSX")
  (setq mouse-wheel-scroll-amount '(0.001)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; BACKGROUND for iTERM
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when *is-cocoa-emacs*
  (defun focus-iterm ()
    (interactive)
    (shell-command "osascript -e 'tell application \"iTerm\" to activate'"))

  (if window-system
      (progn (global-unset-key (kbd "C-z"))
             (global-unset-key (kbd "C-x C-z"))
             (global-set-key (kbd "C-z") 'focus-iterm)))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; CUSTOM FILE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Basic Shortcuts
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;----------------------------------------------------------------------------
;; Disabled Transpose
;;----------------------------------------------------------------------------
(global-unset-key (kbd "C-t")) ;; transpose-chars
(global-unset-key (kbd "M-t")) ;; transpose-words

(transient-mark-mode t)

;;----------------------------------------------------------------------------
;; Paren
;;----------------------------------------------------------------------------
(when (fboundp 'electric-pair-mode)
  (setq-default electric-pair-mode 1))
(show-paren-mode 1)

;;----------------------------------------------------------------------------
;; Comment
;;----------------------------------------------------------------------------
(global-unset-key (kbd "M-/"))
(global-set-key (kbd "M-/") 'comment-or-uncomment-region)

;;----------------------------------------------------------------------------
;; Just one space
;;----------------------------------------------------------------------------
(global-unset-key (kbd "C-c C-SPC"))
(global-set-key (kbd "C-c C-SPC") 'just-one-space)


;;----------------------------------------------------------------------------
;; Cua Mode
;;----------------------------------------------------------------------------
(cua-selection-mode t)
(global-unset-key (kbd "C-\\"))
(global-set-key (kbd "C-\\") 'cua-set-rectangle-mark)

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
;; Move Text
;;----------------------------------------------------------------------------
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg)
          (when (and (eval-when-compile
                       '(and (>= emacs-major-version 24)
                             (>= emacs-minor-version 3)))
                     (< arg 0))))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;----------------------------------------------------------------------------
;; Open Line & Indent
;;----------------------------------------------------------------------------
(defun sanityinc/open-line-with-reindent (n)
  "A version of `open-line' which reindents the start and end positions.
If there is a fill prefix and/or a `left-margin', insert them
on the new line if the line would have been blank.
With arg N, insert N newlines."
  (interactive "*p")
  (let* ((do-fill-prefix (and fill-prefix (bolp)))
         (do-left-margin (and (bolp) (> (current-left-margin) 0)))
         (loc (point-marker))
         ;; Don't expand an abbrev before point.
         (abbrev-mode nil))
    (delete-horizontal-space t)
    (newline n)
    (indent-according-to-mode)
    (when (eolp)
      (delete-horizontal-space t))
    (goto-char loc)
    (while (> n 0)
      (cond ((bolp)
             (if do-left-margin (indent-to (current-left-margin)))
             (if do-fill-prefix (insert-and-inherit fill-prefix))))
      (forward-line 1)
      (setq n (1- n)))
    (goto-char loc)
    (end-of-line)
    (indent-according-to-mode)))

(global-set-key (kbd "C-o") 'sanityinc/open-line-with-reindent)

(provide 'init-preference)
