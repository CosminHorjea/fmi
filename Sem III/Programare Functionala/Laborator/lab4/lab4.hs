--Functia foldr
import Numeric.Natural

produsRec :: [Integer] -> Integer
produsRec [] = 1
produsRec (x : xs) = x * produsRec xs

produsFold :: [Integer] -> Integer
produsFold l = foldr (\x acc -> acc * x) 1 l

-- sau produsFold = foldr (*) 1
andRec :: [Bool] -> Bool
andRec [] = True
andRec (x : xs) = x && andRec xs

andFold :: [Bool] -> Bool
andFold = foldr (&&) True

concatRec :: [[a]] -> [a]
concatRec [] = []
concatRec (x : xs) = x ++ concatRec (xs)

concatFold :: [[a]] -> [a]
concatFold = foldr (++) []

rmChar :: Char -> String -> String
rmChar c l = [x | x <- l, x /= c]

rmCharsRec :: String -> String -> String
rmCharsRec _ [] = []
rmCharsRec chars (x : xs)
  | x `elem` chars = rmCharsRec chars xs
  | otherwise = x : (rmCharsRec chars xs)

test_rmchars :: Bool
test_rmchars = rmCharsRec ['a' .. 'l'] "fotbal" == "ot"

rmCharsFold :: String -> String -> String
rmCharsFold x1 x2 = foldr rmChar x2 x1

logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
  where
    f 0 = start
    f n = rate * f (n - 1) * (1 - f (n - 1))

logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079

ex1 :: Natural
ex1 = 100

ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3] --evalueaza daca incerca sa o afisam

ex21 :: Fractional a => a
ex21 = head ex20 --nu evalueaza

ex22 :: Fractional a => a
ex22 = ex20 !! 2 --nu evalueaza

ex23 :: Fractional a => [a]
ex23 = drop 2 ex20 --nu evalueaza

ex24 :: Fractional a => [a]
ex24 = tail ex20 --evalueaza

ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2

ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7

ex33 :: Bool
ex33 = ex31 5 --nu necesita, prima e true si fiind OR atunci expr este adev

ex34 :: Bool
ex34 = ex31 7 -- da, deoarece prima devine false

ex35 :: Bool
ex35 = ex32 5 -- da, deoarece logistic0 e pe prima pozitie

ex36 :: Bool
ex36 = ex32 7 -- da, ca la ex35

--Universalitatea functiilor foldr

foldr' :: (a -> b -> b) -> b -> ([a] -> b)
foldr' op unit = f
  where
    f [] = unit
    f (a : as) = a `op` f as

--suma patratelor elementelor impare
sumaPatratelorImpare :: [Integer] -> Integer
sumaPatratelorImpare [] = 0
sumaPatratelorImpare (a : as)
  | odd a = a * a + sumaPatratelorImpare as
  | otherwise = sumaPatratelorImpare as

sumaPatratelorImpareFold :: [Integer] -> Integer
sumaPatratelorImpareFold = foldr op unit
  where
    unit = 0
    a `op` suma
      | odd a = a * a + suma
      | otherwise = suma

--functia map
map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (a : as) = f a : map' f as

mapFold :: (a -> b) -> [a] -> [b]
mapFold f = foldr op unit
  where
    unit = []
    a `op` l = f a : l

--functia filter
filter' :: (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p (a : as)
  | p a = a : filter' p as
  | otherwise = filter' p as

filterFold :: (a -> Bool) -> [a] -> [a]
filterFold p = foldr op unit
  where
    unit = []
    a `op` filtered
      | p a = a : filtered
      | otherwise = filtered

--Ex 1
--a
semn :: [Integer] -> String
semn [] = []
semn (n : numere)
  | n `elem` [-9 .. 9] =
    case () of
      ()
        | n < 0 -> '-' : semn numere
        | n == 0 -> '0' : semn numere
        | otherwise -> '+' : semn numere
  | otherwise = semn numere

--c
semnFold :: [Integer] -> String
semnFold = foldr op unit
  where
    unit = ""
    a `op` semne
      | a `elem` [-9 .. (-1)] = '-' : semne
      | a == 0 = '0' : semne
      | a `elem` [1 .. 9] = '+' : semne
      | otherwise = semne