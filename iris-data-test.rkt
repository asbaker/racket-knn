#lang racket/base
(require rackunit
         rackunit/text-ui
         racket/pretty
         "iris-data.rkt")


(define iris-data-tests
  (test-suite
    "Tests for iris-data.rkt"

    (test-pred
      "is-blank? is true for an empty list"
      is-blank? '())

    (test-pred
      "is-blank? is true for a list with an empty string"
      is-blank? '(""))

    (test-pred
      "string-or-number->number converts number to number"
      number?
      (string-or-number->number 1.1))

    (test-pred
      "string-or-number->number converts string to number"
      number?
      (string-or-number->number "1.1"))

    (test-equal?
      "get-string-list provides a 150 element list"
      (length (get-string-list "data/iris.data"))
      150)

    (test-true
      "get-string-list provides a list of lists"
      (andmap list? (get-string-list "data/iris.data")))

    (test-pred
      "iris struct for integer values"
      iris?
      (iris 5.5 3.3 2.1 1.1 "Iris Setosa"))

    (test-case
      "iris struct for string values"

      (let
        ([iris-string (iris "5.5" "3.3" "2.1" "1.1" "Iris setosa")])
        (check-pred iris? iris-string)
        (check-pred number? (iris-sepal-length iris-string))
        (check-pred number? (iris-sepal-width iris-string))
        (check-pred number? (iris-petal-length iris-string))
        (check-pred number? (iris-petal-width iris-string))))

    (test-equal?
      "get-data returns a list of size 150s"
      (length (get-data "data/iris.data"))
      150)

    (test-true
      "get-data returns a list of structs"
      (andmap iris? (get-data "data/iris.data")))
    )
  )


(run-tests iris-data-tests)


