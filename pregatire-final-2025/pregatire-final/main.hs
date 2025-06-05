{-
iterate $ x . y = iterate (x . y)
-}

-- 2021, subiect 6, varianta 1
instance (Num a, Show b, Show a) => Show (a -> b) where
    -- show :: (a -> b) -> String
    show f = show $ map (\x -> (x, f x)) [0, 1, 2, 3, 4, 5]

-- instance (Num a, Ord b, Enum a) => Ord (a -> b) where
--     -- (<=) :: (Num a, Ord b) => (a -> b) -> (a -> b) -> Bool
--     f <= g = and $ zipWith (<=) resF resG
--         where
--             resF = map f [0..100]
--             resG = map g [0..100]

data Card = C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | C10 | J | Q | K | A deriving Show
data Value = Only Int | Both Int Int deriving Show

class Valuable a where
    value :: Valuable a => a -> Value

instance Valuable Card where
    -- value :: Card -> Value
    value J = Only 10
    value Q = Only 10
    value K = Only 10
    value A = Both 1 11
    value x = Only $ read $ tail $ show x