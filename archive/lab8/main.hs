type Point = (Double, Double)

c = (5.0, 6.0) :: Point
d = (5.0, 6.0) :: (Double, Double)

data Student = Student {
    name :: [Char],
    grade :: Double,
    age :: Integer
}

-- f :: Student -> Double
-- f (Student _ grade _) = grade
-- f _ = 0.0

data List a = Empty | Cons a (List a)

changeGrade :: Student -> Student
changeGrade stud@(Student name grade age) = if name == "Gigel" then (Student name 0.0 age) else stud

customLength :: List a -> Integer
customLength Empty = 0
customLength (Cons _ l) = 1 + customLength l

-- newtype

-- Maybe a = Just a | Nothing
-- Either a b = Left a | Right b  