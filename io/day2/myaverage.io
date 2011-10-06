List myAverage := method(
  if(self size == 0, 0, self sum / self size)
)

list(1, 2, 3) myAverage println
list() myAverage println
list(1, "") myAverage
