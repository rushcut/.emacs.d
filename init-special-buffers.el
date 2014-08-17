;; (setq my-special-buffers (quote ("\\*magit.*" "\\*compilation\\*" "\\*rspec-compilation\\*" "\\*Help\\*" "\\*Apropos\\*" "\\*Buffer List\\*" "\\*Compile-Log\\*" "\\*info\\*" "\\*vc\\*" "\\*vc-diff\\*" "\\*diff\\*" "bbdb" "\\*RE-Builder\\*" "\\*Shell Command Output\\*" "\\*ESS\\*" "\\*WoMan-Log\\*" "\\*magit-process\\*" "\\*Dired log\\*" "\\*anything\\*" "\\*CEDET Global\\*" "\\*Pp Eval Output\\*")))
;; (setq special-display-regexps (append special-display-regexps (mapcar (lambda (x) (list x 'my-display-buffers)) my-special-buffers)))

(setq my-special-bottom-buffers (quote ("\\*eclim:.*")))
(setq special-display-regexps (append special-display-regexps (mapcar (lambda (x) (list x 'my-display-bottom-buffers)) my-special-bottom-buffers)))


(defun my-display-buffers (buf)
  (let ((count (length (window-list))))
    (save-excursion
      (if (< count 2) (split-window-horizontally))
      (window-number-select 1)
      (set-window-buffer (car (last (window-list))) buf)
      )
    )
  )

(defun my-display-bottom-buffers (buf)
  (save-selected-window
    (save-excursion
      (let* ((w (split-window-vertically))
             (h (window-height w)))
        (select-window w)
        (switch-to-buffer buf)
        (shrink-window (- h 10))))))

(custom-set-variables
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(uniquify-strip-common-suffix nil))

(provide 'init-special-buffers)
