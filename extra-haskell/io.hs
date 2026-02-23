{-
    During our Haskell journey, we may be wondering: how is I/O performed in Haskell ?

    The truth is that Haskell is a pure functional programming language, *except* the I/O
    operations. If we think about it, a pure functional program (as the ones written during
    during the PP laboratory) are not so useful in practice. Since pure functional programs
    imply immutability, the variables need to have some predefined (hardcoded) values during
    computation. Combined with the fact that all functions are pure, we conclude that the
    program would not be able to "read" any input (this would assume performing side effects)
    and would output the same result always. Obviously, this is not generally useful.

    Therefore, a datatype exists in Haskell that allows us to perform I/O interactions
    under the hood. This type is called IO monad.

    If you are new to monads, I strongly recommend taking a look into monads.hs, or just assume
    the following:
    - a monad is a "box" (e.g. IO Int is a boxed Int) that supports two operations.
    - the first operation is called `pure` (or `return`) and just wrapps an useful value in
    a box. In this case, return :: a -> IO a.
    - the second operation is called the bind operator (>>=) and has the effect of unwrapping
    an IO box, taking the result and applying a function that returns another box (usually
    leverages return/pure or some function like putStrLn that ends the computation).
    The bind operator has type (>>=) :: IO a -> (a -> IO b) -> IO b
-}

greetingsTeller :: IO ()
greetingsTeller = putStrLn "Tell me your name !" >> getLine >>= \s -> putStrLn $ "Hi, " ++ s ++ " !"

greetingsTellerInDoNotation :: IO ()
greetingsTellerInDoNotation = do
    putStrLn "Tell me your name !"
    s <- getLine
    putStrLn $ "Hi, " ++ s ++ " !"

sumList :: IO Int
sumList = do
    n <- read <$> getLine
    l <- sequence $ replicate n $ read <$> getLine
    return $ sum l