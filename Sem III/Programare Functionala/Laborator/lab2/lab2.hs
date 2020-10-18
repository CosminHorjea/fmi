-- la nevoie decomentati liniile urmatoare:

import Data.Char
-- import Data.List
import Data.List (elemIndex)

---------------------------------------------
-------RECURSIE: FIBONACCI-------------------
---------------------------------------------

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
  | n < 1 = n
  | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
  fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

-- | @fibonacciLiniar@ calculeaza @F(n)@, al @n@-lea element din secvența
-- Fibonacci în timp liniar, folosind funcția auxiliară @fibonacciPereche@ care,
-- dat fiind @n >= 1@ calculează perechea @(F(n-1), F(n))@, evitănd astfel dubla
-- recursie. Completați definiția funcției fibonacciPereche.
--
-- Indicație:  folosiți matching pe perechea calculată de apelul recursiv.
fibonacciLiniar :: Integer -> Integer
fibonacciLiniar 0 = 0
fibonacciLiniar n = snd (fibonacciPereche n)
  where
    fibonacciPereche :: Integer -> (Integer, Integer)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n = (snd x, fst x + snd x)
      where
        x = fibonacciPereche (n - 1)

---------------------------------------------
----------RECURSIE PE LISTE -----------------
---------------------------------------------
semiPareRecDestr :: [Int] -> [Int]
semiPareRecDestr l
  | null l = l
  | even h = h `div` 2 : t'
  | otherwise = t'
  where
    h = head l
    t = tail l
    t' = semiPareRecDestr t

semiPareRecEq :: [Int] -> [Int]
semiPareRecEq [] = []
semiPareRecEq (h : t)
  | even h = h `div` 2 : t'
  | otherwise = t'
  where
    t' = semiPareRecEq t

---------------------------------------------
----------DESCRIERI DE LISTE ----------------
---------------------------------------------
semiPareComp :: [Int] -> [Int]
semiPareComp l = [x `div` 2 | x <- l, even x]

-- L2.2
inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec _ _ [] = []
inIntervalRec lo hi (h : t)
  | lo <= h && h <= hi = h : (inIntervalRec lo hi t)
  | otherwise = inIntervalRec lo hi t

inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp lo hi xs = [x | x <- xs, x >= lo && x <= hi]

-- L2.3

pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0
pozitiveRec (h : t)
  | h > 0 = 1 + pozitiveRec (t)
  | otherwise = pozitiveRec (t)

pozitiveComp :: [Int] -> Int
pozitiveComp l = length [x | x <- l, x > 0]

-- L2.4
pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec [] = []
pozitiiImpareRec l = helper 0 l
  where
    helper _ [] = []
    helper i (x : xs)
      | odd x = i : helper (i + 1) xs
      | otherwise = helper (i + 1) xs

pozitiiImpareComp :: [Int] -> [Int]
--pozitiiImpareComp l = [i `elemIndex` l | i <- l , odd i]
pozitiiImpareComp l = [fst i | i <- zip [0 ..] l, odd (snd i)]

-- L2.5

multDigitsRec :: String -> Int
multDigitsRec [] = 1
multDigitsRec (x : xs)
  | isDigit x = (digitToInt x * multDigitsRec xs)
  | otherwise = 1 * multDigitsRec xs

multDigitsComp :: String -> Int
multDigitsComp sir = product [digitToInt x | x <- sir, isDigit x]

-- L2.6

discountRec :: [Float] -> [Float]
discountRec [] = []
discountRec (x : xs)
  | disc < 200 = disc : discountRec xs
  | otherwise = discountRec xs
  where
    disc = x * 0.75

discountComp :: [Float] -> [Float]
discountComp list = [x * 0.75 | x <- list, x * 0.75 < 200]
