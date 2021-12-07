define WINDOW-WIDTH 150)
(define WINDOW-HEIGHT 180)

; A world is a number.
; Its display is a blue disk of that size.
; show-world : world -> image
(define (show-world diameter)
  (circle diameter "solid" "blue"))
"Examples of show-world:"
(show-world 1) "should be a blue dot"
(show-world 20) "should be" (circle 20 "solid" "blue")

"Now let's start the animation!"

(big-bang WINDOW-WIDTH WINDOW-HEIGHT 1 10)
(on-update-event show-world)
