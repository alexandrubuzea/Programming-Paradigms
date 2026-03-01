-- Pentru cazul de mai jos, ce se intampla la apelul f [5] ?
f :: [Integer] -> Integer
f [] = 0
f (x : y : xs) = x + y + f xs

-- Ce produc urmatoarele expresii (undefined = valoare din Haskell care emuleaza orice
-- tip, evaluarea sa produce o eroare la runtime) ?

-- head [2, undefined]
-- length [undefined]
-- length undefined
-- length $ map (*2)  $ [1, 2, 3, undefined]


-- Ce produce urmatoarea expresie, cu si fara adnotarea de tip ?

{-
    l = [1, 2, 3, 4] :: [Integer]
    map (/ 2) l
-}