-- LABORATOR 6: INTRODUCERE IN HASKELL

{-
    Haskell este un limbaj compilat / interpretat, pur functional.
    Este un limbaj strongly and statically typed (tipurile sunt stricte
    aka nu sunt permise conversii + determinarea lor se face la compilare,
    NU la runtime).
-}

-- exemplu 1 : a este un intreg care are valoarea 5
a :: Integer
a = 5

-- in cadrul laboratorului + cursului de PP, noi vom folosi GHCI = interpretorul
-- de Haskell

-- aspecte ale limbajului:

-- 1. Lazy evaluation. Daca in Racket evaluarea era aplicativa si putea fi
-- intarziata cu promisiuni, aici avem intarziere by default

{-
    f x y = x + y
    f (1 + 2) (3 + 4)

    I. Evaluare aplicativa:
    f (1 + 2) (3 + 4) -> f 3 7 -> 3 + 7 -> 10

    II. Evaluare lenesa:
    f (1 + 2) (3 + 4) -> (1 + 2) + (3 + 4) -> 3 + 7 -> 10
-}

-- stim din Racket consecinta evaluarii lenese: tipuri de date infinite :)

-- exemplu 2 : sunt permise definitii recursive, tocmai datorita evaluarii lenese
example1 = 1 : example1

-- 2. Functii lambda (folosind sintaxa cu \. ex. \x -> x + 1)
f = \x -> x 0 -- functie care primeste o alta functie pe care o aplica pe 0

-- exercitiu: care este tipul sintetizat pentru f ? Presupuneti 0 :: Integer
-- ca sa nu ne batem capul cu constragerea Num

-- 3. Avem distinctie intre functii si operatori. Operatorii au precedenta mai slaba !
inc :: Integer -> Integer
inc = (+1)
b = inc 1 : [2, 3] -- aici se va evalua inc 1 = 2, apoi b = [2, 2, 3]

-- exercitiu: ce tip va avea b ?

-- 3.2. Putem face conversii intre functii si operatori si viceversa
-- operator -> functie se face prin paranteze

-- exemplu 3: cons in lista, dar cu "functie"
newList = (:) 1 [2..10] -- va pune 1 in lista

-- functie -> operator se face cu backquotes (``)
-- in Haskell exista functia subtract a b = b - a

-- exemplu 4: folosirea lui subtract ca operator 
result = 2 `subtract` 3 -- va da 1

-- exemplu 5: folosirea filter ca operator
result2 = even `filter` [1, 2, 3, 4]

-- 4. Tipuri primitive relevante: Int/Integer, Bool, Char, String = [Char], Double

-- in Haskell avem, similar cu Python, tupluri/perechi.

-- exemplu 6: tipul unei perechi este tipul primului element + tipul celui de-al doilea
-- element + constructorul de tip (,)

c = (5, False) :: (Integer, Bool)

-- functii pe perechi: fst, snd (pentru extragere elemente din perechi)
d = snd c :: Bool

-- pentru un operator conditional, avem mai multe variante de a scrie un "if", asa cum
-- avem in programarea imperativa.

-- varianta 1: if clasic

factorial1 :: Integer -> Integer
factorial1 x = if x == 0 then 1 else x * factorial1 (x - 1)

-- varianta 2: case (asemanator cu switch-ul din programarea imperativa):
factorial2 :: Integer -> Integer
factorial2 x = case x of
    0 -> 1
    _ -> x * factorial2 (x - 1)

-- varianta 3: o sintaxa asemanatoare case-ului (garzi)
factorial3 :: Integer -> Integer
factorial3 x
    | x == 0 = 1
    | otherwise = x * factorial3 (x - 1)

-- varianta 4 (highly recommended): pattern matching
factorial4 :: Integer -> Integer
factorial4 0 = 1
factorial4 x = x * factorial4 (x - 1)

-- in Haskell avem functionalele cunoscute din Racket (map, foldl/r, filter),
-- plus o serie de functionale speciale (zipWith)

-- exemplu map
timesTwo :: [Integer] -> [Integer]
timesTwo inputList = map (* 2) inputList

-- exemplu filter
filterPerfectSquares :: [Integer] -> [Integer]
filterPerfectSquares list = filter f list
    where
        f :: Integer -> Bool
        f x = mod (length (filter (\e -> mod x e == 0) [1..x])) 2 == 1

-- exemplu foldr
flatten :: [[a]] -> [a]
flatten listOfLists = foldr (++) [] listOfLists

-- exemplu foldl
customReverse :: [a] -> [a]
customReverse list = foldl (flip (:)) [] list

-- exemplu zipWith
naturals = 0 : zipWith (+) naturals [1,1..]

-- in Haskell putem realiza legare statica cu let sau where

-- exemplu de let

x = let f = filter even 
        func = (f . g)
        g = filter (\x -> mod x 3 == 0)
    in  func [1..100]

-- exemplu de where
resultFunction = map f [1, 2]
    where
        f x = repeat x
