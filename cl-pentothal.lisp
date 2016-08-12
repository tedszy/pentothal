(in-package #:cl-pentothal)

(defparameter *passed* nil)
(defparameter *failed* nil)
(defparameter *results* nil)

(defmacro test (name function-form comparison expected)
  `(push (list ',name 
	       (lambda () 
		 (if (funcall #',comparison
			      ,expected
			      ,function-form)
		     (progn (incf *passed*)
			    (format t "ok: ~a~%" ',name))
		     (progn (incf *failed*)
			    (format t
				    "NOT OK: ~a ==> got ~a, expected ~a in ~a~%"
				    ',name
				    ,function-form
				    ,expected
				    ',function-form)))))
	       *results*))

(defun run-tests ()
  (setf *passed* 0)
  (setf *failed* 0)
  (loop for fnpair in (reverse *results*)
       do (funcall (cadr fnpair)))
  (format t "~&passed: ~a" *passed*)
  (format t "~&failed: ~a" *failed*)
  'done)


;; example

;; change to format like
;; (add-test foo (+ 1 1 1) = 3)


(test barf (+ 1 1 1) = 3)
(test merlin (+ 1 1 1) = 4)
(test queequeg (* 5 2) = 10)
(test zarf (+ 1 1) = 2)
(test zoo 
      (make-array 3 :initial-contents '(1 2 3)) 
      equalp 
      #(1 2 3))