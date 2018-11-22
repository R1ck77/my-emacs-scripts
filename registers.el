(defun update-string (string lambda)
  (number-to-string (funcall lambda  (string-to-number string))))

(defun update-valid-marker (marker lambda)
  (let ((buffer (marker-buffer marker))
        (position (marker-position marker)))
    (if (and buffer position)
        (with-current-buffer buffer
          (set-marker marker (min (point-max)
                                  (funcall lambda marker))
                      buffer)))))

(defun update-register-content (content lambda )
  (cond
   ((markerp content) (update-valid-marker content lambda))
   ((stringp content) (update-string content lambda))
   ((numberp content) (funcall lambda content))
   (t (error "this type cannot be converted"))))

(defun inc-register-as-number (register)
  "Increment the register

If the register contains an integer or a string that can be converted to an integer, increment the value.
If the register contains a marker with a position and buffer, increment the marker.
Empty markers are silently ignored.

Issue an error in all other scenarios"
  (interactive "cRegister: ")
  (set-register register
                (update-register-content (get-register register)
                                         (lambda (x) (+ x 1)))))

(defun update-register-as-number (register string-expr)
  (interactive "cRegister \nMExpression(x): ")
  (let* ((full-string-lambda (format "(lambda (x) %s)" string-expr))
         (f (eval (read full-string-lambda))))
    (set-register register
                  (update-register-content (get-register register)
                                           f))))

