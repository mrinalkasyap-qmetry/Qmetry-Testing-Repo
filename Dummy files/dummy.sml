type loc = real * real

fun square (x : real) = x * x

fun dist (x, y) (x', y') =
    Math.sqrt (square (x' - x) + square (y' - y))

fun heron (a, b, c) = let
    val x = dist a b
    val y = dist b c
    val z = dist a c
    val s = (x + y + z) / 2.0
    in
        Math.sqrt (s * (s - x) * (s - y) * (s - z))
    end
