-- Racket -> strongly typed si dynamically typed
-- Haskell -> strongly typed si statically typed
f :: Integer -> Integer -> Integer
f x y = x + y

-- f1 = \x y -> x + y
-- f2 = \x -> \y -> x + y
-- f3 = (+ x) y
-- f4 = (+ y) x
-- f5 = (+)

{-
    g = f 3 = \y -> 3 + y 
-}

{-
    lambda(x y) (+ x y)
    lambda(x) (lambda (y) (+ x y))
-}

-- Int, Integer, Bool, Char, String = [Char]

-- []

h x y z = (x == y) && z

-- Racket -> evaluare aplicativa
-- Haskell -> evaluare lenesa

{-
    -> operatori -> in Haskell, in forma infixata
    -> functii -> in forma prefixata
-}

-- f x y = inc x + y

-- _ + _

-- pentru liste: [], :

my_length1 :: Eq a => [a] -> Integer
my_length1 l = if l == [] then 0 else 1 + my_length1 (tail l)

my_length2 :: Eq a => [a] -> Integer
my_length2 l = case l == [] of
    True -> 0
    _ -> 1 + my_length2 (tail l)

my_length3 :: Eq a => [a] -> Integer
my_length3 l
    | l == [] = 0
    | otherwise = 1 + my_length3 (tail l)

-- [] sau x:xs
my_length4 :: [a] -> Integer
my_length4 [] = 0
my_length4 (_:xs) = 1 + my_length4 xs

a = let
        b = 3
        c = 2
    in
        b + c

a2 = b + c
    where
        b = 3
        c = 2

qsort :: [Integer] -> [Integer]
qsort [] = []
qsort (x:xs) = qsort left ++ [x] ++ qsort right
    where
        left = filter (< x) xs
        right = filter (>= x) xs 