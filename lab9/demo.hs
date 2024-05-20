import GHC.Num (naturalShiftL)
import Text.XHtml (base)
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
            - predefined classes (Eq, Show, Num, Functor)
            - "currying" type constructors :)
-}

{-
    map :: (a -> b) -> [a] -> [b]
    map f [] = []
    map f (x : xs) = f x : map f xs
-}

{-
    class Show a where
        show :: a -> String
-}

data Student = Student {
    name :: [Char],
    age :: Integer,
    cnp :: [Char]
} deriving Show

-- instance Show Student where
    -- show :: Student -> String

    -- show (Student name age cnp) = "{" ++ name ++ ", " ...  
{-
    class Show a where
        show :: Show a => a -> String
-}

instance Eq Student where
    (==) :: Student -> Student -> Bool
    s1 == s2 = cnp s1 == cnp s2
{-

    instance Eq a => Eq [a] where
        (==) :: Eq a => [a] -> [a] -> Bool
        [] == [] = True
        (x : xs) == (y : ys) = x == y && xs == ys
        _ == _ = False

    class Eq a => Ord a where
        (>) :: ...
        (<) :: ...
        compare :: ...
        ...
    
    class Custom a where
        (+++) :: ...
        gigel :: ...
-}

-- Show, Ord

{-
    map :: (a -> b) -> [a] -> [b]
    map f [] = []
    map f (x : xs) = f x : map f xs
-}

customLength :: [a] -> a
customLength = undefined

-- :t length

{-
    class Functor f where
        fmap :: Functor f => (a -> b) -> f a -> f b
-}

class Container f where
    contents :: f a -> [a]

data BST a = Void | Node a (BST a) (BST a) deriving Show

instance Functor BST where
    fmap :: (a -> b) -> BST a -> BST b
    fmap _ Void = Void
    fmap f (Node root left right) = Node (f root) (fmap f left) (fmap f right)
{-

    a -> b = (->) a b

    instance Functor ((->) t) where
    -- fmap :: (a -> b) -> (t -> a) -> (t -> b)
        fmap = (.)
-}

instance (Num a, Eq b) => Eq (a -> b) where
    (==) :: (Num a, Eq b) => (a -> b) -> (a -> b) -> Bool
    f == g = map f l == map g l
        where
            l = take 11 naturals
            naturals = 0 : map (+1) naturals

-- class Num a where
    -- (+) :: a -> a -> a
    -- (-) :: a -> a -> a
    -- (*) :: a -> a -> a