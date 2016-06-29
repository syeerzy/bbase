; 对读写操作的统计
;
; 统计数字格式为 一个这种结构称为一个 "统计""
; #(读字节数 写字节数 小读操作数 大读操作数 写操作数)
;
; 整体统计结构为
; #(总统计  当前线程的统计 '(,,,所有线程的统计,,,))
; 也就是
; #(统计  统计 '(统计 统计 统计 ...))
;         
(import oop)

(define (vector-add! vec i n)
  (vector-set! vec i
               (+ (vector-ref vec i) n)))

(define (id v) v)

(define (statistics-data->string data)
  (let-values (((br bw ro lro wo) (apply values (vector->list data))))
    (format "读~d字节(小~d/大~d次)|写~d字节(~d次)" br ro lro bw wo)))





(define-class (Statistics name) (<base>)
  (ivars (scheme name)
         (root '#(0 0 0 0 0))
         (local #f)
         (all '()))
  (inherited)
  (inheritable)
  (private 
    (visit-all   
      (getter fold-leftr)
      (fold-left folder 
                 (getter local) 
                 (map getter all))))
  (protected)
  (public 
    (get-thread-statistics ()
       (if (not local)
         (begin
           (set! local (make-thread-parameter '#(0 0 0 0 0)))
           (set! all (cons (weak-cons (get-thread-id) local) all))))
       local)
    (increment-bytes-read (n) (vector-add! (get-thread-statistics) 0 n))
    (increment-bytes-written (n) (vector-add! (get-thread-statistics) 1 n))
    (increment-read-ops (n) (vector-add! (get-thread-statistics) 2 n))
    (increment-large-read-ops (n) (vector-add! (get-thread-statistics) 3 n))
    (increment-write-ops (n) (vector-add! (get-thread-statistics) 4 n))
    (get-bytes-read () (visit-all (lambda (v) (vector-ref v 0)) +))
    (get-bytes-written () (visit-all (lambda (v) (vector-ref v 1)) +))
    (get-read-ops () 
       (visit-all (lambda (v) 
                    (+ (vector-ref v 3) (vector-ref v 2))) 
                  +))
    (get-large-read-ops () (visit-all (lambda (v) (vector-ref v 3)) +))
    (get-write-ops () (visit-all (lambda (v) (vector-ref v 4)) +))
    (->string () 
       (statistics-data->string 
         (string (visit-all id (lambda (a b) (vector-map + a b))))))))


  


(define (Statistics name)
  '#(name
     #(0 0 0 0 0)
     #(0 0 0 0 0)
     '()))
