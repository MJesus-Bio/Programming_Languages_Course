
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; 1
(define (sequence low high stride)
  (if (> low high)
      null
      (cons low (sequence (+ low stride) high stride))))

;; 2
(define (string-append-map xs suffix)
  (map (lambda (s) (string-append s suffix)) xs))

;; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: list empty")]
        [#t (car (list-tail xs (remainder n (length xs))))]))

;; 4
(define (stream-for-n-steps s n)
  (if (= n 0)
      null
      (let ([ss (s)])
       (cons (car ss)
             (stream-for-n-steps (cdr ss) (- n 1))))))

;; 5
(define funny-number-stream
  (letrec ([f (lambda (n) (if (= 0 (remainder n 5))
                              (cons (- 0 n) (lambda () (f (+ n 1))))
                              (cons n (lambda () (f (+ n 1))))))])
    (lambda () (f 1))))

;; 6
(define dan-then-dog
  (letrec ([f (lambda (n) (if (= 0 (remainder n 2))
                              (cons "dan.jpg" (lambda () (f (+ n 1))))
                              (cons "dog.jpg" (lambda () (f (+ n 1))))))])
    (lambda () (f 0))))

;; 7
(define (stream-add-zero s)
  (lambda ()
    (let ([ss (s)])
      (cons (cons 0 (car ss))
            (stream-add-zero (cdr ss))))))

;; 8
(define (cycle-lists xs ys)
  (letrec ([cycle-lists (lambda (n)
                          (cons (cons (list-nth-mod xs n)
                                      (list-nth-mod ys n))
                                (lambda () (cycle-lists (+ n 1)))))])
    (lambda () (cycle-lists 0))))
                                              
;; 9
(define (vector-assoc v vec)
  (letrec ([vector-assoc (lambda (n)
                           (cond [(= n (vector-length vec)) #f]
                                 [(not (pair? (vector-ref vec n)))
                                  (vector-assoc (+ n 1))]
                                 [(equal? v (car (vector-ref vec n)))
                                  (vector-ref vec n)]
                                 [#t (vector-assoc (+ n 1))]))])
    (vector-assoc 0)))

;; 10
(define (cached-assoc xs n) 
  (let* ([cache (make-vector n #f)]
         [slot 0]
         [cached-assoc (lambda (v)
                         (let ([ans (vector-assoc v cache)])
                           (if ans
                               ans
                               (let ([l_ans (assoc v xs)])
                                 (if l_ans
                                     (begin
                                       (vector-set! cache slot l_ans)
                                       (set! slot (remainder (+ 1 slot) n))
                                       l_ans)
                                     #f)))))])
    cached-assoc)) 

;; Challenge
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (let ([eval_once e1])
       (letrec ([repeat (lambda ()
                          (if (>= e2 eval_once)
                              #t
                              (repeat)))])
         (repeat)))]))