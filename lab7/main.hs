-- Laborator 7: Point free && list comprehension

-- sintaxa list comprehension:
l = [x | x <- [1..], mod x 3 == 0]

-- functionale utile:

-- 1. intersperse
-- l2 = intersperse 1 $ repeat 2

-- 2. repeat
l3 = repeat 3 -- stream doar cu valori de 3

-- 3. iterate
l4 = iterate (+ 2) 5 -- un stream al aplicatiilor succesive ale functiei (+2)
                     -- pe valoarea 5, adica [5, 7, 9, 11 ...]

-- 4. Sablon map-reduce (concatMap)
alphabet = "ab"
result = "" : concatMap (\x -> map ((x ++) . (:[])) alphabet) result
