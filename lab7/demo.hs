{-
    TODO: live demo about:

    1. List comprehensions (cartesianProduct)
    2. Function composition and application (. vs $). Point free programming
    3. Other useful functionals (other than those in Racket):
        - scanl, zipWith, zipWith3, concatMap (map reduce), iterate, mapAccumL
        - wannabe functionals like zip, zip3, unzip, repeat, intersperse
    4. Evaluare lenesa && how to visualize it (:sprint). Maybe Tree example

    BONUS: `type` keyword (for homework)
-}





















data Tree = Nil | Node Tree Integer Tree deriving Show-- TODO for lazy evaluation

search :: Tree -> Integer -> Bool
search tree e = localSearch tree
    where
        localSearch :: Tree -> Bool
        localSearch Nil = False
        localSearch (Node left root right)
            | e == root = True
            | e < root = localSearch left
            | otherwise = localSearch right


parseTree :: [Integer] -> Tree
parseTree [] = Nil
parseTree (x:xs) = Node left x right
    where
        left = parseTree $ filter (< x) xs
        right = parseTree $ filter (> x) xs

-- parseTree [3, 1, 0, 2, 5, 4]