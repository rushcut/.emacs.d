(add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-mode/contrib/lisp")

(when (< emacs-major-version 24)
  (require-package 'org))
;; (require 'org-fstree)
(when *is-a-mac*
  (require-package 'org-mac-link)
  (require-package 'org-mac-iCal))

;; (define-key global-map (kbd "C-c l") 'org-store-link)
;; (define-key global-map (kbd "C-c a") 'org-agenda)

(require-package 'org-pomodoro)

(setq org-modules '(org-bibtex org-bookmark org-expiry org-habit org-id org-info
                               org-inlinetask org-man org-w3m org-clock org-timer
                               org-protocol org-drill org-mu4e))
(when (eq system-type 'darwin)
  (setq org-modules (append org-modules '(org-mac-link-grabber))))


(custom-set-variables
 ;; '(org-modules org-modules)
 '(org-startup-indented t)
 '(org-global-properties '(("STYLE_ALL" . "habit")))
 '(org-read-date-prefer-future 'time)
 '(org-completion-use-ido t)
 '(org-refile-targets '((org-agenda-files :maxlevel . 3)
                        (nil :maxlevel . 3)))
 '(org-refile-use-outline-path 'file)
 '(org-outline-path-complete-in-steps nil)
 '(org-clock-history-length 35)
 '(org-clock-idle-time 25)
 '(org-drawers '("PROPERTIES" "LOGBOOK" "CLOCK"))
 '(org-clock-into-drawer "CLOCK")
 '(org-clock-persist (quote history))
 '(org-agenda-todo-ignore-with-date t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-skip-timestamp-if-done t)
 '(org-agenda-span 7)
 '(org-tags-column -80)
 '(org-agenda-tags-column -80)
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(org-cycle-separator-lines 2)
 '(org-agenda-todo-list-sublevels t)
 '(org-show-following-heading t)
 '(org-show-hierarchy-above t)
 '(org-show-siblings nil)
 '(org-log-into-drawer t)
 '(org-special-ctrl-a/e t)
 '(org-special-ctrl-k t)
 '(org-yank-adjusted-subtrees nil)
 '(org-use-fast-todo-selection t)
 '(org-file-apps '((t . emacs)
                   (system . "open %s")))
 '(org-fontify-done-headline t)
 '( org-src-fontify-natively t)
 '(org-src-window-setup 'current-window))

(global-set-key (kbd "C-c o c") 'org-capture)

;; TABLE ALIGN
;; (when *is-cocoa-emacs*
;;   (set-face-font 'org-table "-*-NanumGothicCoding-Regular-r-*-*-18-*-*-*-m-*-fontset-nanum")
;;   )


;;----------------------------------------------------------------------------
;;
;; ORG-FIELS
;;
;;----------------------------------------------------------------------------
(defun org-pomodoro-on-org-agenda-load ()
  (define-key org-agenda-mode-map "\C-c\C-x'" 'org-pomodoro-agenda-columns))
(make-directory (concat my-dropbox-dir "g/org/projects") t)
(setq org-directory (concat my-dropbox-dir "g/org"))
(setq org-agenda-files (list (concat my-dropbox-dir "g/org") (concat my-dropbox-dir "g/org/projects")))
(setq org-mobile-directory (concat my-dropbox-dir "Apps/MobileOrg"))
(setq org-mobile-inbox-for-pull (concat org-directory "from_mobile.org"))
(setq org-default-notes-file (concat org-directory "/inbox.org"))

(defun org ()
  (interactive)
  (ido-find-file-in-dir org-directory))
(defun dired-g (&rest arguments)
  (interactive)
  (dired (concat my-dropbox-dir "g")))
(defun orgb ()
  (interactive)
  (ido-find-file-in-dir org-directory))

;;----------------------------------------------------------------------------
;;
;; ORG-CAPTURE
;;
;;----------------------------------------------------------------------------
(custom-set-variables
 '(org-protocol-protocol-alist '(("edit-link" :protocol "edit-link" :function org-edit-url)))
 '(org-capture-templates
   '(("r" "Notes" entry (file+headline (concat org-directory "/inbox.org") "Notes")
      "* %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %a\n%i"
      :prepend t)
     ("t" "TODO" entry (file+headline (concat org-directory "/inbox.org") "Tasks")
      "* TODO %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %a\n%i")
     ("j" "Journal" plain (file+datetree (concat org-directory "/journal.org"))
      "\n%?\n" :empty-lines 1)
     ("m" "Management" plain (file+datetree (concat org-directory "/management.org"))
      "\n%?\n" :empty-lines 1)
     ("p" "Pomodoro" plain (file+datetree (concat org-directory "/pomodoro.org"))
      "\n%?\n" :empty-lines 1)
     ("d" "Dump" plain (file+olp (concat org-directory "/inbox.org") "Quick Notes" "Plain")
      "\n--%U--------------------------------------------------\n%?\n" :empty-lines 1)
     ("l" "List" item (file+olp (concat org-directory "/inbox.org") "Quick Notes" "List") "%?\n" :empty-lines 1)
     ("s" "SOMEDAY" entry (file+headline (concat org-directory "/inbox.org") "Someday")
      "* SOMEDAY %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %a\n%i")
     ("x" "Clipboard" entry (file+headline (concat org-directory "/inbox.org") "Notes")
      "* %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %x"
      :prepend t :empty-lines 1)
     ("i" "Idea" entry (file (concat org-directory "/spark.org") "")
      "* %?\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %a\n%i")

     ("b" "Default template" entry (file+headline (concat org-directory "/inbox.org") "Tasks")
      "* TODO %:description\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  %c\n\n%i"
      :prepend t :empty-lines 1 :immediate-finish t))))

;;----------------------------------------------------------------------------
;;
;; ORG-CLOCK
;;
;;----------------------------------------------------------------------------
(defun my-org-clock-display (msg)
  (notify "Org Notification" msg :icon "appointment-reminder"))

(defun org-gtd-clock-out-if-pause ()
  "Clock out when the task is marked PAUSE."
  (when (and (string= org-state "PAUSE")
             (not (string= org-last-state org-state))
             (org-clock-is-active))
    (org-clock-out t)))
(defun org-gtd-clock-out-switch-to-pause-if-going (state)
  "Switch to PAUSE if clock out a task marked GOING"
  (if (string= state "GOING") "PAUSE" state))
(defun org-gtd-clock-in-if-starting ()
  "Clock in when the task is marked GOING."
  (when (and (string= org-state "GOING")
             (not (string= org-last-state org-state))
             (not org-clock-current-task))
    (org-clock-in)))
(add-hook 'org-after-todo-state-change-hook
          'org-gtd-clock-in-if-starting)
(add-hook 'org-after-todo-state-change-hook
          'org-gtd-clock-out-if-pause)

(custom-set-variables
 '(org-clock-in-resume nil)
 '(org-clock-in-switch-to-state "GOING")
 '(org-clock-out-switch-to-state
   (function org-gtd-clock-out-switch-to-pause-if-going))
 '(org-clock-out-when-done t))

(when (fboundp 'notify)
  (setq org-show-notification-handler (function my-org-clock-display)))

;;----------------------------------------------------------------------------
;;
;; ORG-GTD
;;
;;----------------------------------------------------------------------------

(custom-set-variables
 '(org-extend-today-until 2)
 '(org-agenda-time-grid
   '((daily today require-timed remove-match)
     "----------------"
     (700 800 900 1000 1100 1400 1500 1600 2000 2200)))
 '(org-todo-keywords
   '((sequence "TODO(t)" "GOING(g)" "PAUSE(p" "WAITING(w@)" "LATER(l)"
               "|" "DONE(d!/@)" "SOMEDAY(s)" "CANCELED(c@)")))
 '(org-todo-keyword-faces
   '(("TODO" :foreground "coral3" :weight bold)
     ("GOING" :foreground "green" :weight bold)
     ("PAUSE" :foreground "yellow" :weight bold)))
 '(org-priority-faces
   '((?A :foreground "red" :weight bold)
     (?B :foreground "#94bff3" :weight bold)
     (?C :foreground "#6f6f6f")))
 '(org-tag-alist '((:startgroup . nil)
                   ("@ruby" . ?r)
                   ("@objective-c" . ?o)
                   ("@c" . ?c)
                   ("@java" . ?j)
                   ("@javascript" . ?s)
                   ("@emacs" . ?e)
                   (:endgroup . nil)
                   ("must" . ?m)
                   ("pattern" . ?p)
                   ("language" . ?l)
                   ("idea" . ?i)
                   ("next" . ?n)))
 '(org-todo-state-tags-triggers
   '(("WAITING" ("next"))
     ("LATER" ("next"))
     ("DONE" ("next"))
     ("SOMEDAY" ("next"))
     ("CANCELED" ("next"))
     ("GOING" ("next" . t))))
 '(org-stuck-projects
   '("project/-DONE-CANCELED"
     ("GOING") ("next") ""))
 '(org-tags-exclude-from-inheritance '("project"))
 '(org-columns-default-format
   "%42ITEM %TODO %3Effort(E){:} %3CLOCKSUM(R) %SCHEDULED"))

;;----------------------------------------------------------------------------
;;
;; ORG-AGENDA
;;
;;----------------------------------------------------------------------------
(defun sacha/org-agenda-done (&optional arg)
  "Mark current TODO as done.
    This changes the line at point, all other lines in the agenda referring to
    the same tree node, and the headline of the tree node in the Org-mode file."
  (interactive "P")
  (org-agenda-todo "DONE"))

(defun sacha/org-agenda-mark-done-and-add-followup ()
  "Mark the current TODO as done and add another task after it.
    Creates it at the same level as the previous task, so it's better to use
    this with to-do items than with projects or headings."
  (interactive)
  (org-agenda-todo "DONE")
  (org-agenda-switch-to)
  (org-capture 0 "t"))

(defun sacha/org-agenda-new ()
  "Create a new note or task at the current agenda item.
    Creates it at the same level as the previous task, so it's better to use
    this with to-do items than with projects or headings."
  (interactive)
  (org-agenda-switch-to)
  (org-capture 0))

(defun org-agenda-3-days-view (&optional day-of-year)
  "Switch to 3-days (yesterday, today, tomorrow) view for agenda."
  (interactive "P")
  (org-agenda-check-type t 'agenda)
  (if (and (not day-of-year) (equal org-agenda-current-span 3))
      (error "Viewing span is already \"%s\"" 3))
  (let* ((sd (or day-of-year
                 (org-get-at-bol 'day)
                 (time-to-days (current-time))))
         (sd (and sd (1- sd)))
         (org-agenda-overriding-arguments
          (or org-agenda-overriding-arguments
              (list (car (get-text-property (point) 'org-last-args)) sd 3 t))))
    (org-agenda-redo)
    (org-agenda-find-same-or-today-or-agenda))
  (org-agenda-set-mode-name)
  (message "Switched to %s view" 3))

(defun init--org-agenda-mode ()
  (define-key org-agenda-mode-map "D" 'org-agenda-3-days-view)
  (define-key org-agenda-mode-map "M" 'org-agenda-month-view)
  (define-key org-agenda-mode-map "x" 'sacha/org-agenda-done)
  (define-key org-agenda-mode-map "X" 'sacha/org-agenda-mark-done-and-add-followup)
  (define-key org-agenda-mode-map "N" 'sacha/org-agenda-new))
(add-hook 'org-agenda-mode-hook 'init--org-agenda-mode)

(setq org-agenda-custom-commands
      '(
        ("l" . "Context List")

        ("lp" "Pattern"
         ((tags-todo "pattern/GOING|PAUSE|TODO")))

        ("lh" "Home"
         ((tags-todo "@home/GOING|PAUSE|TODO")))

        ("le" "Errands"
         ((tags-todo "@errands/GOING|PAUSE|TODO")))

        ("lc" "Computer"
         ((tags-todo "@computer/GOING|PAUSE|TODO")))

        ("lm" "Message"
         ((tags-todo "@message/GOING|PAUSE|TODO")))
        ("lr" "Reading"
         ((tags-todo "@reading/GOING|PAUSE|TODO")))
        ("L" "Combined Context List"
         ((tags-todo "@home/GOING|PAUSE|TODO")
          (tags-todo "@errands/GOING|PAUSE|TODO")
          (tags-todo "@computer/GOING|PAUSE|TODO")
          (tags-todo "@phone/GOING|PAUSE|TODO")
          (tags-todo "@message/GOING|PAUSE|TODO")
          (tags-todo "@reading/GOING|PAUSE|TODO")))
        ("T" "TODO List"
         ((todo "GOING|PAUSE|TODO"))
         ((org-agenda-todo-ignore-with-date nil)))
        ("D" "DONE List"
         ((todo "DONE|CANCELED"))
         ((org-agenda-todo-ignore-with-date nil)))
        ("M" "Maybe"
         ((todo "WAITING|LATER")
          (todo "SOMEDAY"))
         ((org-agenda-todo-ignore-with-date nil)))
        ("i" "Inbox" tags "inbox-CONTAINER=\"true\"")

        ("d" "Daily Action List"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)))
          (todo "GOING|PAUSE|TODO"))
         ((org-agenda-todo-ignore-with-date t)))

        ("r" "Review"
         ((agenda "" ((org-agenda-span 'day)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      (org-agenda-skip-deadline-if-done nil)
                      (org-agenda-skip-timestamp-if-done nil)
                      (org-agenda-skip-scheduled-if-done nil)))
          (todo "GOING|PAUSE|TODO")))

        ("p" "Projects" ((tags "project/-DONE-CANCELED") (stuck "")))

        ("x" "Archive tags search" tags ""
         ((org-agenda-files (file-expand-wildcards (concat org-directory "/*.org_archive" )))))
        ("X" "Archive search" search ""
         ((org-agenda-files (file-expanod-wildcards (concat org-directory "/*.org_archive" )))))

        ("g" "open dropbox/g" dired-g)))

;;----------------------------------------------------------------------------
;;
;; ORG-POMODORO
;;
;;----------------------------------------------------------------------------
(global-set-key (kbd "C-c o '") 'org-pomodoro-record-interuptions)
;; (define-key my-keymap (kbd "'") 'org-pomodoro-record-interuptions)
;; (add-hook 'org-load-hook 'org-pomodoro-on-org-load)
;; (add-hook 'org-agenda-mode-hook 'org-pomodoro-on-org-agenda-load)

;;----------------------------------------------------------------------------
;;
;; ORG-DRILL
;;
;;----------------------------------------------------------------------------

(defun init--org-drill-on-dired-load ()
  (define-key dired-mode-map (kbd "C-c SPC") 'my-dired-do-drill))

(add-hook 'dired-load-hook 'init--org-drill-on-dired-load)

(defun my-dired-do-drill (&optional arg)
  (interactive "P")
  (org-drill
   ;; This can move point if ARG is an integer.
   (mapcar
    'car
    (dired-map-over-marks (cons (dired-get-filename) (point)) arg))))

;; TODO: RESEARCHING!
;;
;; (defun wl-org-column-view-uses-fixed-width-face ()
;;   ;; copy from org-faces.el
;;   (when (or t (fboundp 'set-face-attribute))
;;     ;; Make sure that a fixed-width face is used when we have a column table.
;;     (set-face-attribute 'org-column nil
;;                         :height (face-attribute 'default :height)
;;                         :family (face-attribute 'default :family))))

;;; Task
(defun org-project-task-file ()
  "ORG 디렉토리의 프로젝트 테스크 파일 경로를 리턴한다"
  (-when-let (proj (ignore-errors (replace-regexp-in-string "^\\." "" (project-name))))
    (f-join org-directory "projects" (concat proj ".org"))))

(defun org-open-project-task-file ()
  (interactive)
  (find-file-other-window (org-project-task-file)))

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "GOING")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

(make-face 'org-pomodoro-header-face)
(set-face-attribute 'org-pomodoro-header-face nil
                    :inherit 'mode-line-face
                    :foreground "black"
                    :height 110
                    )

(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '(" " org-mode-line-string " ") 'face 'org-pomodoro-header-face))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(after-load 'org-clock
  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))

(after-load 'org
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "M-h") nil))
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (autoload 'omlg-grab-link "org-mac-link")
    (define-key org-mode-map (kbd "C-c g") 'omlg-grab-link)))



;; ;; Show iCal calendars in the org agenda
;; (when (and *is-a-mac* (require 'org-mac-iCal nil t))
;;   (setq org-agenda-include-diary t
;;         org-agenda-custom-commands
;;         '(("I" "Import diary from iCal" agenda ""
;;            ((org-agenda-mode-hook #'org-mac-iCal)))))

;;   (add-hook 'org-agenda-cleanup-fancy-diary-hook
;;             (lambda ()
;;               (goto-char (point-min))
;;               (save-excursion
;;                 (while (re-search-forward "^[a-z]" nil t)
;;                   (goto-char (match-beginning 0))
;;                   (insert "0:00-24:00 ")))
;;               (while (re-search-forward "^ [a-z]" nil t)
;;                 (goto-char (match-beginning 0))
;;                 (save-excursion
;;                   (re-search-backward "^[0-9]+:[0-9]+-[0-9]+:[0-9]+ " nil t))
;;                 (insert (match-string 0))))))

(global-set-key (kbd "C-c o t") 'org-open-project-task-file)
(global-set-key (kbd "C-c o a") 'org-agenda)
(global-set-key (kbd "C-c o 3") 'org-agenda-3-days-view)

(require-package 'org)
(require 'org)

(provide 'init-org)
