(def accounts (vector (ref 0) (ref 5000)))

(defn credit [n amount] (dosync (alter (nth accounts n) + amount)))

(defn debit [n amount] (dosync (alter (nth accounts n) - amount)))


