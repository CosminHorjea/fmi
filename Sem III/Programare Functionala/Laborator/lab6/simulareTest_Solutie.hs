
--import Control.Exception
import Data.Char
import Data.List  

-- \title{Laboratorul 6}
-- \maketitle


-- Exercițiul 1
-- ------------

-- a) Scrieți o funcție f :: Char -> Bool care determină dacă un caracter aflabetic se află sau nu 
-- în prima jumătate a alfabetului (litere înainte de M, inclusiv).
-- Ar trebui să funcționeze atât pentru majuscule, cât și pentru litere mici. Pentru orice alt caracter( nu alfabetic)
-- functia f trebuie sa returneze o eroare (apelați funcția error "eroare"). 

-- > f 'e' == True
-- > f 'G' == True
-- > f 'm' == True
-- > f 'p' == False
-- > f 'N' == False
-- *Main> f '!'
-- *** Exception: Dati doar caractere

f::Char -> Bool
f a 
    | isLower a = if ord a <= ord 'm' then True else False
    | isUpper a = if ord a <= ord 'M' then True else False
    |otherwise = error "Dati doar caractere"

-- b) Definiți o funcție g :: String -> Bool care primește un șir de caractere și returnează
-- True dacă șirul conține mai multe litere în prima jumătate a alfabetului decât în
-- a doua jumătate, ignorând orice caracter care nu este un caracter alfabetic.
-- Rezolvați execițiul folosind descrieri de liste. 
-- > g "SyzYGy" == False 
-- > g "aB7L!e" == True 
-- > g "" == False
-- > g "Aardvark" == True 
-- > g "emnity" == False

-- *Main> g "a!!!!!!"
-- True


g::String -> Bool
g list = length [x | x <-list, isAlpha x && f x] > length [x | x <-list, isAlpha x && (f x==False)]

--nu
g2 list = length [x | x <-list, f x && isAlpha x  ] > length [x | x <-list, (f x==False) && isAlpha x]
-- *Main> g2 "a!!!!!!"
-- *** Exception: Dati doar caractere

-- c) Definiți o funcție h :: String -> Bool care se comportă identic
-- cu funcția g, dar rezolvați folosind recursivitate.

h::String -> Bool
h "" = False
h list = length (h_aux list) > length (h_aux2 list)

h_aux [] = []
h_aux (x: t)
    | isAlpha x && f x = x : h_aux t
    | otherwise = h_aux t
    
h_aux2 [] = []
h_aux2 (x: t)
    | isAlpha x && (f x ==False) = x : h_aux2 t
    | otherwise = h_aux2 t   
    
    
-- *Main> h "SyzYGy"
-- False
-- *Main> h ""
-- False
-- *Main> g "Aardvark"
-- True
-- *Main> h "Aardvark"
-- True
-- *Main> g "aB7L!e" == True
-- True
-- *Main> h "aB7L!e" == True
-- True
-- *Main> g "emnity" == False
-- True
-- *Main> h "emnity" == False
-- True

-- Exercițiul 2
-- ------------

-- a) Scrieți o funcție c :: [Int] -> [Int] care returnează o listă care conține toate
-- elemente din lista dată ca argument care apar de cel puțin două ori succesiv. Dacă un element 
-- apare de n ori în succesiune, pentru n>1, atunci ar trebui să apară de n-1 ori în rezultat. 
-- Rezolvați execițiul folosind descrieri de liste. 

c ::[Int] -> [Int]
c list = [x | (x,y) <- zip list (tail list), x == y]

-- c :: [Int] -> [Int]
-- c (x:xs) = [fst x | x <- zip (x:xs) xs, fst x == snd x]

-- c3 :: [Int] -> [Int] 
-- c3 list = [list!!i | i <- [0..length(list)-2], j <- [0 .. length(list)-1], i+1 == j &&  list!!i == list!!j]


-- c4 :: [Int] -> [Int] 
-- c4 list = [list!!i | i <- [0..length(list)-2], list!!i == list!!(i+1)]

-- b) Definiți o funcție d :: [Int] -> [Int]  care se comportă identic
-- cu funcția c, dar rezolvați folosind recursivitate.

d :: [Int] -> [Int]
d [] = []
d [x] = []
d ( x: y: list) =if x==y then x : d ([y] ++ list) else d ([y] ++ list)

-- d :: [Int] -> [Int] 
-- d []=[]
-- d [_]=[]
-- d (h1:h2:t)
    -- |h1==h2    = h1:(d (h2:t))
    -- |otherwise = d (h2:t)

-- *Main> d3 [4,1,1,1,4,4]
-- [1,1,4]
-- *Main> d3 []
-- []
-- *Main> d3 [2,2,2]
-- [2,2]
-- *Main> d3 [2,2,2,2,2]
-- [2,2,2,2]
-- *Main> d3 [4,1,1,1,4,4,1,1]
-- [1,1,4,1]
-- *Main> d4 [4,1,1,1,4,4,1,1]
-- [1,1,4,1]


-- c) Scrieți o proprietate prop_cd pentru a confirma că c și d se comportă identic și verificați pentru 3 exemple.


prop_cd :: [Int] -> Bool
prop_cd list = c list == d list

-- *Main> prop_cd [1,1,2,2,3]
-- True
-- *Main> prop_cd [1,1,2,2,3,4,3,3,5]
-- True

-- *Main> quickCheck prop_cd
-- +++ OK, passed 100 tests.



