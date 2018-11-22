(defun integer-value (value)
  "Return the value (if integer) or the bovine conversion if a string"
  (if (integerp value)
      value
    (if (stringp value)
        (string-to-number value)
      (error "Only integers and strings cannot be converted"))))

(defun inc-register-as-number (register)
  (interactive "cRegister: ")
  (set-register register (+ (integer-value (get-register register)) 1)))

