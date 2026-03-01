-- Custom problem

{-
    Let's suppose we encode logical clauses in the form of an integer list.
    For example, a clause (x1 V x2 V ~x3) will be encoded as [1, 2, -3]
    A literal from the clause will be encoded as an integer number (positive
    if the literal is in direct form and negative if it is negated)
-}

type Literal = Integer
type Clause = [Integer]

{-
    a. Write a function that has type Clause returns a String representing the logical
    formula that the clause describes. Do not use intersperse or intercalate
    Example: clauseToString [1, 2, -3] -> "x1 V x2 V ~x3"
    Hint: write *literalToString* first !
-}
literalToString :: Literal -> String
literalToString = undefined

clauseToString :: Clause -> String
clauseToString = undefined

{-
    b. Write a function called *decompose* with type [a] -> [(a, [a])] that receives a
    list of values and returns a list of pairs having a value and the rest of the list
    without the value in the pair.
    Example: decompose [1, 2, 3] = [(1, [2, 3]), (2, [1, 3]), (3, [1, 2])]
-}

decompose :: [a] -> [(a, [a])]
decompose = undefined

{-
    c. Write a function called *resolve* with type Clause -> Clause -> Bool that checks
    if the two clauses can be resolved (i.e. one has xi and the other one has ~xi)
-}

complementary :: Literal -> Literal -> Bool
complementary x y = x + y == 0

resolve :: Clause -> Clause -> Bool
resolve = undefined