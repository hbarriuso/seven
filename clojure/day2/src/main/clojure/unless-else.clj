(defmacro unless
  ([test then] (list 'if (list 'not test) then))
  ([test then else] (list 'if (list 'not test) then else))
)