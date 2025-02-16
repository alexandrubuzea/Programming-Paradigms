{-
    In order to explain some more advanced concepts, let's remember the Functor class:
    class Functor f where
        fmap :: Functor f => (a -> b) -> f a -> f b
    
    The fmap function can be regarded as a way to apply a function over a container, in
    a way that it preserves the structure. For example:
    
    fmap :: (Int -> Int) -> Maybe Int -> Maybe Int
    fmap (+1) (Just 2) -> Just 3
    fmap (+1) Nothing -> Nothing

    However, fmap can be also regarded as a function which performs function promotion.
    If we leverage currying, it seems that fmap offers us a way to "promote" a function
    from raw types (a -> b) to a more complex ("promoted") version (f a -> f b)
    For example, if we have f = (+1) and the functor is the list functor, then
    
    fmap (+1) :: Num a => [a] -> [a]
    
    so the (+1) function is "promoted" from operating on numeric values to operating on
    complex structures (lists, in this case) which involve numeric values.

    If we want to extend this concept to functions with multiple arguments, then we
    would need to have a higher-order function with its type being something like:

    func :: SomeClass f => (a -> b -> c) -> f a -> f b -> f c

    So, having two structures containing a and b and a way to combine an a and a b and
    getting a c is desired. Unfortunately, this is not possible using only functors,
    and some more complex/specialized type constructor is needed. These types are called
    applicative functors and are grouped in a class called Applicative:

    class Applicative f where
        pure :: a -> f a -- injects a value into a box
        <*> :: f (a -> b) -> f a -> f b -- combines a boxed value with a structure and
                                        -- returns another structure

    The above desired functional is called liftA2 and can be defined in terms of pure
    and <*>:

    liftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
    liftA2 h fa fb = pure h <*> fa <*> fb

    Many known types are applicatives. For example, [] is an applicative:
    [(+1), (*2)] <*> [1, 2] -> [2, 3, 2, 4] -- (creates a list with all results)

    Next step is that we would like to sequence these applicatives, and there are some
    constructors (called monads) that do that by doing the following: having a computation
    (a boxed input: m a) and a function that creates another computation from the result of
    the previous one, we can chain those computations, thus creating more complex pipelines.
    There is class Monad:

    class Monad m where
        return :: a -> m a -- injects a value into the monadic type, similar to Applicative's pure
        (>>=) :: m a -> (a -> m b) -> m b -- chains the computations by passing the result of the
                                          -- previous one in order to create a new one

    There are many type constructors that have Monad instances ("computations"):
        - list monad ([])
        - maybe monad: data Maybe a = Just a | Nothing
        - either monad (with keeping the first parameter constant when sequencing):
                data Either a b = Left a | Right b
                Basically, the computation continues for Right and is stopped for Left:
                (>>=) :: Either a b -> (b -> Either a c) -> Either a c
                Left x >>= f = Left x -- the result is passed as it is
                Right y >>= f = f y   -- the computation is created from the previous one

        - the state monad (see below)
        - function monad ((-> c))
        - IO monad (a builtin monad that is actually the only way in Haskell to perform side
                    effects)
-}

import Control.Monad
import qualified Data.Map as M

{-
    The list monad is used in order to model nondeterminism.
    If you recall nondeterminism from AA (Analysis of Algorithms) course, let's suppose
    we have a nondeterministic code as below:

    x = choice({1, 2, 3})
    y = 2 if x is even else choice({4, 5})
    z = x + y
    if z is even
        fail
    else
        u = 2 * z
    We can have all the values on all branches for our variables at the end of computation
-}

allVars :: [(Int, Int, Int, Int)]
allVars = [()] >>= const [1, 2, 3] >>= \x -> (if even x then [(x, 2)] else (x,) <$> [4, 5])
            >>= \(x, y) -> [(x, y, x + y)] >>= \(x, y, z) -> (if even z then [] else [(x, y, z, 2 * z)])

allVars' :: [(Int, Int, Int, Int)]
allVars' = do
    x <- [1, 2, 3]
    y <- (if even x then [2] else [4, 5])
    let z = x + y
    u <- (if even z then [] else [2 * z])
    return (x, y, z, u)

{-
    Let's show now the State monad instead. The State monad is defined as:
    newtype State s a = State {runState :: s -> (a, s)}

    So, our "state" is actually a stateful transformation that produces an outcome and
    possibly changes the inner state. Sequencing such operations via >>= would hide the
    state passing from one computation to another (basically we are sequencing some pipes).
    
    Note: during constructing a stateful transformation (State s a) from multiple
    components, no computation is actually performed due to lazy evaluation (we are just constructing
    the pipeline). The pipeline can be used only when we call runState using an initial state.
-}

-- TODO: demo state