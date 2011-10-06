Number oldDiv := Number getSlot("/")

Number / := method(d,
  if (d == 0, 0, self oldDiv(d))
)

(5 / 2) println
(5 / 0) println
