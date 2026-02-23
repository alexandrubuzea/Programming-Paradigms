import Data.Time.Format.ISO8601 (yearFormat)
{-
    TODO: showtime
    1. Variables, function definitions in Haskell + native currying
    2. Operators vs functions. Currying, how to pass from operator to function and viceversa
    3. The basics of type system in Haskell (primitive types + simple functions + basic type inference)
    4. GHCi: :t, :sprint
    5. if/else, pattern matching, case, guards
    6. Operations on lists + list comprehensions
    7. Tuples, string (as [Char]) 
    8. Higher-order functions: map/filter/fold{l,r}/zipWith/concatMap
    9. let, where
    10. {H,G}oogle
-}

f x y = x + y

-- f x : y
-- a -> b -> c
g :: Integer -> Integer
g x = x + 10

customLength :: [a] -> Integer
customLength [] = 0
customLength (_:xs) = 1 + customLength xs

customLength2  :: [a] -> Integer
customLength2 l = if null l then 0 else 1 + customLength2 (tail l)

customLength3 :: [a] -> Integer
customLength3 l = case l of
    [] -> 0
    _ : xs -> 1 + customLength3 xs

customLength4 :: [a] -> Integer
customLength4 l
    | null l = 0
    | otherwise = 1 + customLength4 (tail l)

customLength5 :: [a] -> Integer
customLength5 = foldr (const (+ 1)) 0

qsort [] = []
qsort (x:xs) = qsort left ++ [x] ++ qsort right
    where
        left = filter (< x) xs
        right = filter (>= x) xs