{-
    TODO: live demo about:

    1. List comprehensions (cartesianProduct, cartesian product of multiple lists)
    2. Function composition and application (. vs $). Point free programming
    3. Other useful functionals (other than those in Racket) for generating/working
       with infinite lists:
        - scanl, zipWith, zipWith3, concatMap (map reduce), iterate, mapAccumL
        - wannabe functionals like zip, zip3, unzip, repeat, intersperse
    4. Evaluare lenesa && how to visualize it (:sprint). Tree example

    Examples to present:
    - spot 3 [1, 2, 3, 3] = [1, 2]
    BONUS: `type` keyword (for homework)
-}

-- cartesianProduct [[1, 2], [3], [4, 5]] -> 
cartesianProduct :: [[a]] -> [[a]]
cartesianProduct [] = [[]]
cartesianProduct (x : xs) = [e : l | e <- x, l <- cartesianProduct xs]

approximations = iterate (\x -> 0.5 * (x + 2 / x)) 2

pairs = zip approximations (tail approximations)
res = head $ [x | (x, y) <- pairs, abs (x - y) < 1e-10]

{-
length [] = 0
length (_:xs) = 1 + length xs

map f [] = []
map f (x : xs) = f x : map f xs

length $ map (+1) [1..10]
length $ map (+1) $ 1 : [2..10]
length $ (+1) 1 : map (+1) [2..10]
1 + length $ map (+1) [2..10]

-}

ourSpot x = filter (x /=)
