(define (checker p1 p2)
  (let ([p12 (hc-append p1 p2)]
        [p21 (hc-append p2 p1)])
    (vc-append p12 p21)))
 

> (checker (colorize (square 10) "red")
           (colorize (square 10) "black"))
