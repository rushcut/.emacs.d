(require 'moz)

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(add-hook 'javascript-mode-hook 'javascript-custom-setup)
(add-hook 'coffee-mode-hook 'javascript-custom-setup)
;; (add-hook 'after-save-hook 'moz-reload t)

(defun javascript-custom-setup ()
  (moz-minor-mode 1))

(defun moz-enable-auto-refresh ()
  "파일을 저장하면 자으로 원격의 MozRepl을 새로고침 기능 켜기"
  (interactive)
  (add-hook 'after-save-hook 'moz-reload))

(defun moz-disable-auto-refresh ()
  "파일을 저장하면 MozRepl을 이용해 새로고침하는 기능 끄기"
  (interactive)
  (remove-hook 'before-save-hook 'moz-reload t))

(defun moz-open-url (url &rest ignore)
  "MozRepl을 이용해서 파이어폭스 주소 이동"
  (interactive "sURL: ")
  (comint-send-string (inferior-moz-process)
                      (concat "content.document.location=\ '" url "\ ';")))

(defun moz-reload (&rest ignore)
  "파이어폭스 새로고침 하기"
  (interactive)
  (message "moz-reload")
  (save-buffer)
  (if (eql major-mode 'markdown-mode)
      (markdown-export)
      )
  (comint-send-string (inferior-moz-process) "BrowserReload();"))

(global-unset-key (kbd "C-c C-h"))
(global-set-key (kbd "C-c C-h") 'moz-reload)

(provide 'init-moz)
