#lang racket/base

(require rackunit
         rackunit/text-ui
         "iris-data.rkt"
         "knn.rkt")


(define knn-tests
  (test-suite
    "Tests for knn.rkt"

    (test-case
      "iris-distance computes the distance from an iris to an iris and puts it in a tuple"

      (define iris1 (iris 1 1 1 1 "unknown"))
      (define iris2 (iris 3 3 3 3 "Iris Setosa"))

      (define dist (iris-distance-euclidean iris1 iris2))

      (check-equal? (car dist) 4)
      (check-equal? (cdr dist) "Iris Setosa")

      )

    (test-case
      "count-list-elements"
      )
  ))

(run-tests knn-tests)


