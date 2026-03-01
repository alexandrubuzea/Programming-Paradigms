-- Q12, 2023

-- Care este tipul listei Haskell [foldl, foldr]?

-- Q11, 2023
-- Pentru programul Haskell de mai jos, ce tip va avea expresia [x, y]

data MyData a b = A a (MyData a b)
    | B b (MyData a b)
    | C a b
x = A id
y = B "id"

-- Q11, 2022
-- Care este tipul următoarei expresii ı̂n Haskell? [map, filter]

-- Q10, 2022

-- Pentru definitiile Haskell:
data MyT = Cons1 Int | Cons2 Float | Cons3 Int Float
f cons arg = zipWith (\c a -> c a) cons arg

-- care dintre următoarele legări NU generează o eroare?
-- 1. let x = f [Cons1, Cons2]
-- 2. let x = f [Cons1, Cons3 1]
-- 3. let x = f [Cons2, Cons3 2]