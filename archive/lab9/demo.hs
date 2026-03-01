{-
    TODO: live demo

    1. Parametric vs ad-hoc polymorphism
    2. Example of interesting situations such as (+1) == (+1) (instances for functions)
    3. Class definitions (Eq, Show - below), example: Invertible
    4. Class instances for known types (e.g. Student)
    5. Context in instances (Eq a => Eq (BST a))
    6. Class extensions ("inheritance": ex. Eq => Ord)
    7. Class for numbers (TODO : show hierarchy)
    8. Higher order types (typeclass parameterized with type constructor
    instead of concrete type): Functor, Container 

    BONUS:  - Eq on unary functions with numerical input
            - Functor for functions
            - Functor for Maybe, Either
            - predefined classes (Eq, Show, Num, Functor)
            - "currying" type constructors :) + MAYBE intro to kinds
-}

{-
    map f [] = []
    map f (x:xs) = f x : map f xs
-}

data Student = S {
    age :: Integer,
    name :: String
}

instance Eq Student where
    S _ n1 == S _ n2 = n1 == n2

{-
class Eq a where
    (==) :: Eq a => a -> a -> Bool
    x == y = not (x /= y)
    (/=) :: Eq a => a -> a -> Bool
    x /= y = not (x == y)

instance Eq a => Eq [a] where
    (==) :: [a] -> [a] -> Bool
    [] == [] = True
    (x : xs) == (y : ys) = x == y && xs == ys
    _ == _ = False

data Tree a = EmptyTree | Node (Tree a) a (Tree a)

instance Eq a => Eq (Tree a) where
    (==) :: Tree a -> Tree a -> Bool
    EmptyTree == EmptyTree = True
    Node l1 root1 r1 == Node l2 root2 r2 = root1 == root2 && l1 == l2 && r1 == r2
    _ == _ = False

instance (Num a, Eq b) => Eq (a -> b) where
    f == g = f 0 == g 0
-}

instance (Num a, Eq b, Enum a) => Eq (a -> b) where
    f == g = map f [0..100] == map g [0..100]

(+++) :: a -> a -> [a]
x +++ y = [x, y]

data Tree a = EmptyTree | Node (Tree a) a (Tree a) deriving Show

{-
class Functor f where
    fmap :: Functor f => (a -> b) -> f a -> f b

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node l root r) = Node (fmap f l) (f root) (fmap f r)
-}

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node l root r) = Node (fmap f l) (f root) (fmap f r)

{-

-}