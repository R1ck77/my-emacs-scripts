(defun yank-xclip (clipboard)
  (let ((result (shell-command-to-string (format "xclip -out -selection %s" clipboard))))
    (if result
        (insert result))))

(defun yank-from-primary ()
  (interactive)
  (yank-xclip "primary"))

(defun yank-from-secondary ()
  (interactive)
  (yank-xclip "clipboard"))

(defun yank-from-xclip (arg)
  (interactive "P")
  (if arg
      (yank-from-secondary)
    (yank-from-primary)))

(defun kill-to-xclip (begin end region))

(defun send-region-to-xclip (begin end &optional region)
  (call-process-region begin end
                       "bash"
                       nil
                       nil
                       nil
                       "-c" "xclip -in -selection clipboard"))

(defun advise-kill ()
  (advice-add 'kill-ring-save
              :before 'send-region-to-xclip)
  (advice-add 'kill-region
              :before 'send-region-to-xclip))

(defun remove-kill-advises ()
  (advice-remove 'kill-ring-save 'print-me)
  (advice-remove 'kill-region 'print-me))
