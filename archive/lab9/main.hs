my_length :: [a] -> Integer
my_length [] = 0
my_length (x:xs) = 1 + my_length xs

data Student = Stud {
    name :: [Char],
    age :: Integer,
    cnp :: [Char]
} deriving (Eq, Show)

-- instance Eq Student where
--     (Stud _ _ c1) == (Stud _ _ c2) = c1 == c2

-- f :: (Num a, Eq b) => a -> b

instance (Num a, Eq b) => Eq (a -> b) where
    f == g = f 1 == g 1

data Tree a  = Nil | Node a (Tree a) (Tree a) deriving Show

instance Functor Tree where
    -- fmap :: Functor f => (a -> b) -> f a -> f b
    fmap f Nil = Nil
    fmap f (Node n left right) = Node (f n) (fmap f left) (fmap f right)