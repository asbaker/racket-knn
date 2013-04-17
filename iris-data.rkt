#lang racket/base

(require (planet neil/csv:2:0))
(require racket/list)
(require racket/pretty)

; (define class-setosa "Iris Setosa")
; (define class-versicolour "Iris Versicolour")
; (define class-virginica "Iris Virginica")

(define (string-or-number->number x)
  (if (number? x) x (string->number x)))

(struct iris (sepal-length
               sepal-width
               petal-length
               petal-width
               classification)
        #:guard (lambda (sl sw pl pw c type-name)
                  (values
                    (string-or-number->number sl)
                    (string-or-number->number sw)
                    (string-or-number->number pl)
                    (string-or-number->number pw)
                    c
                    )
                  )
        )

(define (is-blank? row)
  (or
    (null? row)
    (equal? (first row) "")))

(define (get-string-list file-name)
  (filter (compose not is-blank?) ((compose csv->list make-csv-reader open-input-file) file-name)))




(define (get-data file-name)
  (map (lambda (row) (apply iris row)) (get-string-list file-name))
  )

(provide
  (struct-out iris)
  string-or-number->number
  get-string-list
  is-blank?

  get-data
  )

