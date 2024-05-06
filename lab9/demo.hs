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

customLength :: [a] -> a
customLength = undefined

-- :t length

class Container f where
    contents :: f a -> [a]

data BST a = Void | Node a (BST a) (BST a)