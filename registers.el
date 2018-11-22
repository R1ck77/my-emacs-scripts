(defun increment-string (string)
  (+ (string-to-number value) 1))

(defun increment-valid-marker (marker)
  (let ((buffer (marker-buffer marker))
        (position (marker-position marker)))
    (if (and buffer position)
        (with-current-buffer buffer
          (set-marker marker (min (point-max)
                                  (+ marker 1))
                      buffer)))))

(defun increment-register-content (content)
  (cond
   ((markerp content) (increment-valid-marker content))
   ((stringp content) (increment-string content))
   (numberp content) (+ content 1)
   (t (error "this type cannot be converted"))))

(defun inc-register-as-number (register)
  "Increment the register

If the register contains an integer or a string that can be converted to an integer, increment the value.
If the register contains a marker with a position and buffer, increment the marker.
Empty markers are silently ignored.

Issue an error in all other scenarios"
  (interactive "cRegister: ")
  (set-register register
                (increment-register-content (get-register register))))

