import Data.Set as S

{-
    1. Write a function that returns the cartesian product of two lists.
    Example: cartesianProduct [1, 2] [4, 5] = [(1, 4), (1, 5), (2, 4), (2, 5)]
    
    Use list comprehension
-}

cartesianProduct :: [a] -> [b] -> [(a, b)]
cartesianProduct = undefined

{-
    2. Write a function that returns the cartesian product of multiple lists.
    The function receives a list of lists and returns a list with list elements
    that are "tuples" (lists).

    Example: extendedCartesianProduct [[1, 2], [4, 5]] = [[1, 4], [1, 5], [2, 4], [2, 5]]
-}
extendedCartesianProduct :: [[a]] -> [[a]]
extendedCartesianProduct = undefined

{-
    3. Let's suppose we are first year students and we have to solve the following equation:
    x^3 - 2 * x^2 - 3 * x - 7 = 0

    Let's try to solve this equation using several methods.
    First of all, define f and df (the derivative of the function f).
-}

f :: Double -> Double
f = undefined

df :: Double -> Double
df = undefined

{-
    4. Now, solve the equation using Newton's method:

    x_{k+1} = x_k - f(x_k) / f'(x_k)

    The function takes a function and its derivative, an initial approximation, a maximum
    acceptable error and the maximum number of steps to be performed. The function returns
    a pair that contains the number of steps and the error (difference in absolute value
    between x_{k + 1} and x_k).

    Implement the function below using tail recursion.
    Hint: make a local recursive function using where, that receives only parameters that
    do change.
-}

newtonMethod ::
    (Double -> Double) -- f
    ->
    (Double -> Double) -- df
    ->
    Double -- x0, our initial approximation
    ->
    Double -- tol, our maximum acceptable error
    ->
    Integer -- maximum number of steps
    ->
    (Integer, Double) -- maximum number of steps

newtonMethod = undefined

{-
    5. Now, determine an infinite list of approximations given by the Newton's method
    for the above function.

    approximationStream = [x0, x1, x2, x3, ...] where

    x1 = x0 - f(x0) / f'(x0)
    x2 = x1 - f(x1) / f'(x1)
    ...
    
    Hint: use iterate
-}

x0 :: Double
x0 = undefined -- choose x0 = -3 and x0 = 2 respectively in order to get the solutions

approximationStream :: [Double]
approximationStream = undefined -- use f, df and x0

{-
    6. Now let's define a graph datatype and some basic operations for it.
-}

type Graph a = ([a], [(a, a)]) -- G = (V, E) with vertices of type a and edges of type (a, a)

-- 6a. Define a constructor for the Graph datatype
construct :: [a] -> [(a, a)] -> Graph a
construct = undefined

-- 6b. Get neighbours of a node (note that the graph is directed)
neighbours :: a -> Graph a -> [a]
neighbours = undefined

-- 6c. Using neighbours, get the adjacency list representation for the graph
adjacencyList :: Graph a -> [(a, [a])]
adjacencyList = undefined

-- 6d. Using list comprehension, get the adjacency matrix representation for the graph
adjacencyMatrix :: Graph a -> ([a], [[Bool]])
adjacencyMatrix = undefined

{-
    7. Remember the CNF-SAT problem that consists of a boolean formula written in the
    conjunctive normal form (conjunctions between many disjunctions). A formula
    of this type is satisfiable if there exists an allocation of the (boolean) variables
    in the formula such that the formula is evaluated to True.

    Example 1: this formula is satisfiable:
    (x1 V x2 V x3) ^ (~x1 V x2) ^ (~x2 V x3)
    (we can choose x1,2,3 = True)

    Example 2: this formula is not satisfiable:
    (x1 V x2) ^ (~x1 V x2) ^ ~x2
-}

{-
    7a. Write a function that receives a list of lists of integers representing an
    encoding for a boolean CNF formula (an element in that list is called a clause,
    with the positive integers corresponding to positive literals and negative
    integers corresponding to the negative literals) and a possible solution for the
    SAT problem and returns:
        - True, if the allocation given is a solution to the SAT problem or it is a
            partial solution (respects all constraints given by the clauses)
        - False, if the given allocation is not a solution or it cannot be completed
            to a solution.

    Example: [[1, -2], [3, -4, -5]] corresponds to the formula
    (x1 V ~x2) ^ (x3 V ~x4 V ~x5).
-}
checkConstraints :: [[Integer]] -> [(Integer, Bool)] -> Bool
checkConstraints = undefined

{-
    7b. Given the list of variables, write a function that returns a list of all
    solution candidates for the SAT problem (by brute-forcing all combinations of
    allocations).

    Ex. possibleAllocations [1, 2] = [
        [(1, True), (2, True)],
        [(1, True), (2, False)],
        [(1, False), (2, True)],
        [(1, False), (2, False)],
    ]

    Hint: use extendedCartesianProduct from exercise 2
-}
possibleAllocations :: [a] -> [[(a, Bool)]]
possibleAllocations = undefined

{-
    7c. Finally, write a (basic) SAT solver that receives a SAT formula, a list of all
    variables and determines using the above functions if the formula is satisfiable. 
-}
solveSAT :: [[Integer]] -> [Integer] -> Bool
solveSAT = undefined

{-
    7d. The above approach is brute forced, since it checks all possible solutions
    (2 ^ |V|, where V is the variables set). The approach can be improved via
    backtracking. Write a function that determines the satisfiability of a formula
    using the following algorithm (backtracking):
    - takes a variable from the variable set
    - checks if the formula is satisfiable using the chosen variable as True/False
        by reducing the SAT formula (see the comments below for reduceSAT)
-}

{-
    HINT: may consider useful the following function that reduces the SAT clause.
    The behaviour should be the following:
    (x1 V ~x2) ^ (x2 V x3) and x3 = True -> (x1 V ~x2) -> [[1, -2]]
    (x1 V ~x2) ^ (x2 V x3) and x2 = False -> x3 -> [3]

    Empty clause means that the formula is not satisfiable. Since our function can
    return a result or a new formula, one can use Either algebraic datatype (is
    defined as a "box" in which we can encapsulate values of two different type -
    similar to C style union)
-}

reduceSAT :: [[Integer]] -> Integer -> Bool -> Either [[Integer]] Bool
reduceSAT = undefined

efficientlySolveSAT :: [[Integer]] -> [Integer] -> Bool
efficientlySolveSAT = undefined

{-
    BONUS: Using the above graph representation, determine the distance between two
    nodes from the graph

    Hint: use breadth-first search (BFS) algorithm in order to accomplish this
    Hint2: in order to keep the visited nodes, it is recommended to keep a Data.Set
    (see the documentation for more info). The module is already imported (see the
    first line).

    Note: we use Eq a constraint in order to allow comparison by equality (==) between
    nodes.
-}

distanceNodes :: Eq a => Graph a -> a -> a -> Integer
distanceNodes = undefined