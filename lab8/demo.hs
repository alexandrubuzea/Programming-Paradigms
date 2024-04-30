{-
    TODO: live demo

    1. significance of static typing in Haskell (+ how to read a type annotation)
    2. type, data (simple + registration), newtype + parameterized types + type recursion
    3. getters and data constructors (and how to distinguish them from functions)
    4. practical examples (List, Tree, NestedList, AST for arithmetic expressions)
    5. name alias (@)
    6. already defined types ([], (,), Maybe, Either)

    Extra: what is an AST ?
    Extra 2: classes (lab9)
-}

type Point = (Double, Double)

c :: Point
c = (0, 1)


d :: (Double, Double)
d = (0, 1)

type Pointed a = Point -> a

data List a = Nil | Cons a (List a)

toList :: List a -> [a]
toList Nil = []
toList (Cons x l) = x : toList l

member :: Eq a => List a -> a -> List a
member Nil _ = Nil
member ll@(Cons x l) e = if x == e then ll else member l e

-- data Student = Student String Integer Integer
data Student = Student {
    name :: String,
    age :: Integer,
    failedExams :: Integer
} deriving Show


data NestedList a = Atom a | List [NestedList a]
flatten :: NestedList a -> [a]
flatten (Atom a) = [a]
flatten (List l) = concatMap flatten l

data Tree a = Void | Node a (Tree a) (Tree a)

data Expr = Number Integer
    | Plus Expr Expr
    | Minus Expr Expr
    | Mult Expr Expr
    | Div Expr Expr

-- newtype -> accepta un singur data constructor, si un singur atribut

-- data Maybe a = Nothing | Just a

maybeDiv :: Integer -> Integer -> Maybe Integer
maybeDiv x y
    | y == 0 = Nothing
    | otherwise = Just $ x `quot` y

unwrap :: Maybe Integer -> Integer
unwrap m = case m of
    Just x -> x
    _ -> 0

-- data Either a b = Left a | Right b