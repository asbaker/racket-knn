#lang racket/base

(require "iris-data.rkt"
         racket/pretty
         racket/function
         racket/list
         racket/set
         )

(define (iris-distance-euclidean from to)
  (let (
        [sld (expt (- (iris-sepal-length from) (iris-sepal-length to)) 2)]
        [swd (expt (- (iris-sepal-width from) (iris-sepal-width to)) 2)]
        [pld (expt (- (iris-petal-length from) (iris-petal-length to)) 2)]
        [pwd (expt (- (iris-petal-width from) (iris-petal-width to)) 2)]
        )

    (cons (sqrt (+ sld swd pld pwd)) (iris-classification to))))

(define (iris-distance-manhattan from to)
  (let (
        [sld (- (iris-sepal-length from) (iris-sepal-length to))]
        [swd (- (iris-sepal-width from) (iris-sepal-width to))]
        [pld (- (iris-petal-length from) (iris-petal-length to))]
        [pwd (- (iris-petal-width from) (iris-petal-width to))]
        )

    (cons (abs (+ sld swd pld pwd)) (iris-classification to))))

(define (iris-distance-pair-< i1 i2)
  (< (car i1) (car i2)))

(define (iris-distance-pair-> i1 i2)
  (> (car i1) (car i2)))

(define (unique-classes distance-pairs)
  (list->set (map cdr distance-pairs)))

(define (pair-cdr-is? x pair)
  (equal? (cdr pair) x))


(define (count-all-classes distance-pairs)
  (define (_count-all classes accum)
    (if (set-empty? classes)
      accum
      (_count-all
        (set-rest classes)
        (cons
          (cons (count (curry pair-cdr-is? (set-first classes)) distance-pairs) (set-first classes))
          accum)
        )
      )
    )

  (_count-all (unique-classes distance-pairs) (list))
)

(define (knn-classify k training-data classify-me)
  (define k-neighbors (take (sort (map (curry iris-distance-euclidean classify-me) training-data) iris-distance-pair-<) k))
  (cdar (sort (count-all-classes k-neighbors) iris-distance-pair->))
  )



(define (main)
  ; code for blog post breakdown
  (define training-data (get-data "test-data/training_data2.csv"))

  ; code example 1
  ; (pretty-print training-data)

  ; (define classify-me (iris 6.3 2.5 4.9 1.5 "Iris-versicolor"))

  ; code example 2
  ; (pretty-print (map (curry iris-distance-euclidean classify-me) training-data))

  ; code example 3
  ; (pretty-print (take (sort (map (curry iris-distance-euclidean classify-me) training-data) iris-distance-pair-<) 5))

  ; code example 4
  ; (define k-neighbors (take (sort (map (curry iris-distance-euclidean classify-me) training-data) iris-distance-pair-<) 5))
  ; (pretty-print (count-all-classes k-neighbors))

  ; code example 5
  ; (define k-neighbors (take (sort (map (curry iris-distance-euclidean classify-me) training-data) iris-distance-pair-<) 5))
  ; (pretty-print (cdar (sort (count-all-classes k-neighbors) iris-distance-pair->)))



  ; code example 6
  (define k 5)
  (define test-data (get-data "test-data/test_data2.csv"))
  (define ml-classes (map (curry knn-classify k training-data) test-data))
  (define real-classes (map iris-classification test-data))

  (pretty-print '("Classified . Actual"))
  (map (compose pretty-print cons) ml-classes real-classes)

  (void)
  )

(provide main
         iris-distance-euclidean
         )
