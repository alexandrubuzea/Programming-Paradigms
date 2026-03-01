{-
    Q9, 2023
    Pentru programul Haskell de mai jos, de câte ori se calculează corpul
    functiei f la evaluarea expresiei length [a 2, a 2, a 2, b, b]
    f x y = x + y
    a = f 1
    b = f 2 3
-}

{-
    Q10, 2023

    Fie următoarele definitii ı̂n Haskell:

    xs = map (+ 1) [1 .. 10]
    f (8:9:_) = True

    Câte elemente ale listei xs vor fi calculate dacă se evaluează expresia
    (f xs)?
-}

{-
    Q9, 2022

    De câte ori se evaluează aplicatiile functiei (+ 1) ı̂n cadul expresiei
    Haskell de mai jos?
    
    length $ map (+ 1) [1..10]
-}

{-
    length [] = 0
    length (_ : xs) = 1 + length xs
-}


f (_:8:9:_) = 2
f (8:9:_) = 1
f _ = 0