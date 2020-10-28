import Data.List

-- L3.1 Încercati sa gasiti valoarea expresiilor de mai jos si
-- verificati raspunsul gasit de voi în interpretor:
{-
[x^2 | x <- [1 .. 10], x `rem` 3 == 2]
[(x, y) | x <- [1 .. 5], y <- [x .. (x+2)]]
[(x, y) | x <- [1 .. 3], let k = x^2, y <- [1 .. k]]
[x | x <- "Facultatea de Matematica si Informatica", elem x ['A' .. 'Z']]
[[x .. y] | x <- [1 .. 5], y <- [1 .. 5], x < y ]

-}

factori :: Int -> [Int]
factori x = undefined

prim :: Int -> Bool
prim x = undefined

numerePrime :: Int -> [Int]
numerePrime x = undefined

-- L3.2 Testati si sesizati diferenta:
-- [(x,y) | x <- [1..5], y <- [1..3]]
-- zip [1..5] [1..3]

myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 l1 l2 l3 = undefined

--------------------------------------------------------
----------FUNCTII DE NIVEL INALT -----------------------
--------------------------------------------------------
aplica2 :: (a -> a) -> a -> a
--aplica2 f x = f (f x)
--aplica2 f = f.f
--aplica2 f = \x -> f (f x)
aplica2 = \f x -> f (f x)

-- L3.3
{-

map (\ x -> 2 * x) [1 .. 10]
map (1 `elem` ) [[2, 3], [1, 2]]
map ( `elem` [2, 3] ) [1, 3, 4, 5]

-}

-- firstEl [ ('a', 3), ('b', 2), ('c', 1)]

-- sumList [[1, 3],[2, 4, 5], [], [1, 3, 5, 6]]

-- prel2 [2,4,5,6]

-- L3.4
listaPatrate :: (Integral a) => [a] -> [a]
listaPatrate a = map (\x -> (snd x) ^ 2) (filter (\x -> odd (fst x)) (zip [1 ..] a))

eliminaConsoane :: [[Char]] -> [[Char]]
eliminaConsoane c = map (\x -> filter (`elem` "aeiouAEIOU") x) c

-- eliminaConsoane l = map( filter(\c -> c `elem` "aeiouAEIOU")) l
--3.5
myMap f [] = []
myMap f (x : xs) = f x : myMap f xs

myFilter1 :: (a -> Bool) -> [a] -> [a]
myFilter1 p (x : xs)
  | p x = x : myFilter1 p xs
  | otherwise = myFilter1 p xs

-- myFilter2 :: (a -> Bool) -> [a] -> [a]
-- myFilter2 f xs = [x| x <- xs, f x]

numerePrimeCiur :: Int -> [Int]
numerePrimeCiur x = auxCiur [2 .. x]
  where
    auxCiur [] = []
    auxCiur (h : xs) = h : auxCiur [x | x <- xs, x `mod` h > 0]

ordonareNat [] = True
ordonareNat (x : xs) = and [x <= y | (x, y) <- zip (x : xs) xs]

ordonareNat1 [] = True
ordonareNat1 [_] = True
ordonareNat1 (h : t)
  | h < head t = True && ordonareNat1 t
  | otherwise = False

-- alta metoda
ordonareNat1' :: Ord a => [a] -> Bool
ordonareNat1' [] = True
ordonareNat1' (h : t)
  | length t == 0 = True
  | h < head t && length t == 1 = True
  | otherwise = False

--ordonare unde definim noi relatia de ordine
ordonta :: [a] -> (a -> a -> Bool) -> Bool
ordonta (x : xs) op = and [op y w | (y, w) <- zip (x : xs) xs]

(*<*) :: (Integer, Integer) -> (Integer, Integer) -> Bool
(*<*) (x1, y1) (x2, y2) = and (x1 < x2, y1 < y2)

compuneList :: (b -> c) -> [(a -> b)] -> [(a -> c)]
compuneList f xs = map (f .) xs

-- apliaList :: a -> [(a,b)]->[b]
-- apliaList x xf = map ($ x) xf

myzip4 :: [a] -> [b] -> [c] -> [(a, b, c)]
myzip4 l1 l2 l3 = map (\((x, y), z) -> (x, y, z)) (zip (zip l1 l2) l3)
