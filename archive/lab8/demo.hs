import GHC.Read (list)
import Language.Haskell.TH (safe)
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

-- (a -> b) -> [a] -> [b]

type Point = (Double, Double)

reflect :: Point -> (Double, Double)
reflect (x, y) = (x, -y)

data Being = P {
    age :: Integer,
    name :: String,
    cnp :: String
} | Animal {
    animalAge :: Integer
}

-- data Color = Red | Blue | Yellow | Green | ... 

processBeing :: Being -> Integer
processBeing (P age name cnp) = age
-- processBeing (Animal age name rn) = age

-- data NestedList a = Atom a | List [NestedList a]

data Tree a = EmptyTree | Node (Tree a) a (Tree a)

-- data Tree a = Atom a | Node (Tree a) (Tree a)

data Natural = Zero | Succ Natural
-- Zero, Succ Zero, Succ $ Succ Zero ...

-- data List = Nil | Cons Integer List

data List a = EmptyList | Cons a (List a)

listLength :: List a -> Integer
listLength EmptyList = 0
listLength (Cons _ rest) = 1 + listLength rest

newtype Celsius = MakeCelsius Float

safeHead :: [a] -> Maybe a
safeHead (x : _) = Just x
safeHead [] = Nothing

-- data Either a b = Left a | Right b

type Error = String

f :: Either Integer String -> Either String String
f (Left i) = Left $ show i
f r@(Right error) = Right error

-- func :: GHC.Types.Any -> [GHC.Types.Any] -> [GHC.Types.Any]
-- func = filter . (/=)

data T f a = T (f a -> f a)