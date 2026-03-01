class Filterable f where
    filter' :: (a -> Bool) -> f a -> f a
    -- (***) :: (a -> Bool) -> f a -> f a 

instance Filterable [] where
    filter' :: (a -> Bool) -> [a] -> [a]
    filter' _ [] = []
    filter' p (x:xs) = if p x then x : filter' p xs else filter' p xs

instance Filterable Maybe where
    filter' :: (a -> Bool) -> Maybe a -> Maybe a
    filter' p m@(Just x) = if p x then m else Nothing
    filter' _ Nothing = Nothing

data Literal = Positive String | Negative String
newtype Clause = Clause [Literal]

instance Show Literal where
    show :: Literal -> String
    show (Positive l) = l
    show (Negative l) = "~" ++ l

instance Show Clause where
    show :: Clause -> String
    -- show (Clause l) = foldr (\x acc -> if acc == "" then x else x ++ " v " ++ acc) "" $ map show l
    show (Clause []) = ""
    show (Clause [x]) = show x
    show (Clause (x:xs)) = show x ++ concatMap (\s -> " v " ++ show s) xs

decompose :: [a] -> [(a, [a])]
decompose [] = []
decompose (x:xs) = (x, xs) : map (\(a, b) -> (a, x : b)) (decompose xs)

complementary :: Literal -> Literal -> Bool
complementary (Positive p) (Negative q) = p == q
complementary (Negative p) (Positive q) = p == q
complementary _ _ = False

resolve :: Clause -> Clause -> Maybe Clause
resolve (Clause l1) (Clause l2) = case resolvent of
    [] -> Nothing
    (res:_) -> Just $ Clause res
    where
        d1 = decompose l1
        d2 = decompose l2
        resolvent = [rest1 ++ rest2 | (elem1, rest1) <- d1, (elem2, rest2) <- d2, complementary elem1 elem2]


data Term = Const String | Var String deriving Eq
data Sentence = Atom String [Term]
type Substitution = [(String, Term)]

_lookup :: Substitution -> Term -> Term
_lookup sub (Var t) = case values of
    [] -> Var t
    x : _ -> x
    where
        values = [val | (key, val) <- sub, key == t]
_lookup _ term = term

lookupIterate :: Substitution -> Term -> [Term]
lookupIterate sub = iterate (_lookup sub)

lookupEnd :: Substitution -> Term -> Term
lookupEnd sub term = finalTerm
    where
        result = lookupIterate sub term
        pairs = zip result $ tail result
        finalTerm = fst $ head $ filter (\(t1, t2) -> t1 == t2) pairs

unifyTerms :: Substitution -> Term -> Term -> Bool
unifyTerms sub term1 term2 = case (end1, end2) of
    (Const c1, Const c2) -> c1 == c2
    _ -> True
    where
        end1 = lookupEnd sub term1
        end2 = lookupEnd sub term2

unifySentences :: Substitution -> Sentence -> Sentence -> Bool
unifySentences sub (Atom p1 t1) (Atom p2 t2) = p1 == p2 && length t1 == length t2 && and (zipWith (unifyTerms sub) t1 t2)

-- p(X) cu p(X, Y)

{-
    f x y = fst x : map (snd x) y

    f :: a -> b -> c
    x :: a
    y :: b
    fst x : map (snd x) y :: c
    (:) :: d -> [d] -> [d]
    c = [d]
    fst x :: d
    map (snd x) y :: [d]

    x :: (e, f) = a
    fst x :: e = d

    snd x :: f

    map (snd x) y :: [d]
    map :: (g -> h) -> [g] -> [h]
    snd x :: g -> h = f
    y :: [g] = b
    [d] = [h] -> d = h

    f x y = fst x : map (snd x) y
    f :: (d, g -> d) -> [g] -> [d]
-}