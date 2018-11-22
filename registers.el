(defun integer-value (value)
  "Return the value (if integer) or the bovine conversion if a string"
  (if (integerp value)
      value
    (if (stringp value)
        (string-to-number value)
      (error "Only integers and strings cannot be converted"))))

(defun increment-valid-marker (marker)
  (let ((buffer (marker-buffer))
        (position (marker-position)))
    (if (and buffer position)
        (with-current-buffer buffer
          (set-marker marker (min (point-max)
                                  (+ marker 1))
                      buffer)))))

(defun increment-register-content (content)
  (if (markerp content)
      (increment-valid-marker register)
    (+ (integer-value content) 1)))

(defun inc-register-as-number (register)
  "Increment the register

If the register contains an integer or a string that can be converted to an integer, increment the value.
If the register contains a marker with a position and buffer, increment the marker.
Empty markers are silently ignored.

Issue an error in all other scenarios"
  (interactive "cRegister: ")
  (set-register register
                (increment-register-content (get-register register))))

