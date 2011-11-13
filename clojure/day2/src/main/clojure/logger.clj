(defprotocol MyLogger
  (log [this msg]))

(deftype ConsoleLogger []
  MyLogger
  (log [this msg] (str msg)))

