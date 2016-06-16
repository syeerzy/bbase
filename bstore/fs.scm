(import oop)

(define-class (fs) (<base>)
  (ivars)
  (inherited)
  (inheritable)
  (private)
  (protected)
  (public (foo)))
  
  
(define (loop start end)
  (if (<= start end)
    (begin
      (display start)
      (display #\\space)
      (loop (+ 1 start) end))))

(let ((a (make fs)))
  (send a foo))


