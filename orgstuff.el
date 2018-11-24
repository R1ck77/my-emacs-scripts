(defun ensure-mark ()
  (if (not mark-active)
        (progn 
          (beginning-of-sexp)
          (mark-sexp))))

(defun wikified-text (text)
  (concat "[[file:wiki.org::" text "][" text "]]"))

(defun wikify ()
  (interactive)
  (ensure-mark)
  (kill-region (region-beginning) (region-end))
  (insert (wikified-text (car kill-ring)))
  (deactivate-mark))

(defun rdm-convert-to-link (format-function)
  (save-excursion
    (beginning-of-sexp)
    (mark-sexp)
    (kill-region (region-beginning) (region-end))
    (insert (funcall format-function (car kill-ring)))))

(defun format-org-link (format-string)
  (lexical-let ((fmt-string format-string))
    (lambda (arg)
      (format fmt-string arg arg))))

(defun wikify ()
  (interactive)
  (rdm-convert-to-link
   (format-org-link "[[file:wiki.org::%s][%s]]")))
