generateEven :: Int -> [Int]
generateEven n = map (* 2) [1..n]

generateEven2 :: Int -> [Int]
generateEven2 n = [x | x <- [1..2 * n], even x]

generateEven3 :: Int -> [Int]
generateEven3 n = filter even [1..2 * n]

generateEven4 :: Int -> [Int]
generateEven4 n = take n [2, 4..]

main :: IO()
main = do
    print (generateEven 10)
    print (generateEven2 10)
    print (generateEven3 10)
    print (generateEven4 10)