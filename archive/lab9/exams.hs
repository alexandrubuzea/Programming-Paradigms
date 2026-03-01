-- Exercise 6 (2022 exam)

-- definiti clasa Filterable care generalizeaza filter :: (a -> Bool) -> [a] -> [a]
-- pe containere de orice forma (functia se va numi filter')

-- instantiati clasa pentru constructorul lista Haskell []
-- instantiati clasa pentru Maybe

-- class Filterable ... where ...

-- Exercise 6 (2023 exam)

class Composable t where
    compose :: (b -> t c) -> (a -> t b) -> a -> t c

-- cum arata tipul particularizat pentru Maybe ?
-- compose :: (b -> Maybe c) -> (a -> Maybe b) -> a -> Maybe c
-- instantiati clasa pentru Maybe.

instance Composable Maybe where
    compose f g x = case g x of
        Just y -> f y
        _ -> Nothing


-- (a -> b) -> (a -> a) -> (b -> b)
-- fmap f g x = x

-- Haskell problem from 2022 (propositional rezolution)

decompose :: [a] -> [(a, [a])]
decompose [] = []
decompose (x:xs) = (x, xs) : map (\(h, t) -> (h, x:t)) (decompose xs)