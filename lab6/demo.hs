import Control.Arrow (ArrowChoice(right))
-- sumList 

sumList :: [Integer] -> Integer
sumList l = if null l then 0 else head l + sumList (tail l)

sumList2 :: [Integer] -> Integer
sumList2 l
    | null l = 0
    | otherwise = head l + sumList2 (tail l)

sumList3 :: [Integer] -> Integer
sumList3 l = case null l of
    True -> 0
    False -> head l + sumList3 (tail l)

sumList4 :: [Integer] -> Integer
sumList4 [] = 0
sumList4 (x:xs) = x + sumList4 xs

sumList5 :: [Integer] -> Integer
sumList5 = foldr (+) 0

qsort :: [Integer] -> [Integer]
qsort [] = []
qsort (x:xs) = qsort left ++ [x] ++ qsort right
    where
        left = filter (< x) xs
        right = filter (>= x) xs

data List a = Nil | Cons a (List a)