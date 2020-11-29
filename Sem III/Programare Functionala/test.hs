import Data.Char
import Data.List

-- r13hc

--1
r01hc :: String -> Int
r01hc [] = 1
r01hc (x : xs)
  | toLower (x) `elem` "haskel" = 10 * (r01hc xs)
  | otherwise = 1 * r01hc xs

-- r01hc "Christmas" == 10000
-- r01hc "Programare" == 1000
-- r01hc "Functionala" == 1000

r02hc :: String -> Int
r02hc l = product [(if toLower (x) `elem` "haskel" then 10 else 1) | x <- l]

-- r02hc "" == 1
-- r02hc "Marti" == 10
-- r02hc "Miercuri" == 10

r03hc :: String -> Int
r03hc l = foldr (\x acc -> (if toLower (x) `elem` "haskel" then 10 else 1) * acc) 1 l

-- r03hc "HASKELL" == 10000000
-- r03hc "Romania" == 100
-- r03hc "Moldova" == 100

testare :: String -> Bool
testare s = (r02hc s == r03hc s)

-- testare "HASKELL" == True
-- testare "Marti" == True
-- testare "Programare" == True

-- fac o functie recursiva ajutatoare care ia ca parametru si contorul, daca numarul din capul listei este cifra,
-- atunci adaug numarul si aplez functia cu contorul 0, altfel incrementez contorul,la final scot numerele de 0 din fata listei
r11hc :: [Integer] -> [Integer]
r11hc [] = [0]
r11hc l = dropWhile (== 0) (r12hc l 0)

r12hc :: [Integer] -> Integer -> [Integer]
r12hc [] _ = []
r12hc (x : xs) nr
  | x `elem` [0 .. 9] = [nr] ++ r12hc (xs) 0
  | otherwise = r12hc (xs) (nr + 1)

-- [1, 11, 12, 13, 14, 15, 2, 21, 22,3, 5, 51, 52,2, 21] == [5,2,0,2]
-- [12,13,14,1,15,16,7] == [3,2]
-- [0,1, 20, 21,24,44,1] == [4]
-- [0,1,20,21,24,44] == [] -- nu exista dubsecventa cifrata