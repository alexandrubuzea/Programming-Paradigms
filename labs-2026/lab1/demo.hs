app :: [a] -> [a] -> [a]
app [] l = l
app (x : xs) l = x : app xs l

data Nat = Zero | Succ Nat deriving Show

add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ (add m n)

mult :: Nat -> Nat -> Nat
mult Zero n = Zero
mult (Succ m) n = add (mult m n) n

data Tree = Vid | Node Tree Integer Tree deriving Show

{-
    We can create something like t = Node t 1 t, which means an infinite
binary tree with all nodes equal to 1.

    In a similar way you can get ```ones = 1 : ones```, which produces an
infinite list of ones.
-}