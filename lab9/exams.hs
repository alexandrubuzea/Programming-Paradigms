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
-- instantiati clasa pentru Maybe.

-- Haskell problem from 2022 (propositional rezolution)

