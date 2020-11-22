data Fruct
  = Mar String Bool
  | Portocala String Int

ionatanFaraVierme :: Fruct
ionatanFaraVierme = Mar "Ionatan" False

--
goldenCuVierme :: Fruct
goldenCuVierme = Mar "Godlden DElicious" True

portocalaSiciliana10 :: Fruct
portocalaSiciliana10 = Portocala "Sanguinello" 10

listaFructe :: [Fruct]
listaFructe =
  [ Mar "Ionatan" False,
    Portocala "Sanguinello" 10,
    Portocala "Valencia" 22,
    Mar "Golden Delicious" True,
    Portocala "Sanguinello" 15,
    Portocala "Moro" 12,
    Portocala "Tarocco" 3,
    Portocala "Moro" 12,
    Portocala "Valencia" 2,
    Mar "Golden Delicious" False,
    Mar "Golden" False,
    Mar "Golden" True
  ]

--a
ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala x _) = x `elem` ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia _ = False

--b
nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (Mar _ _ : t) = nrFeliiSicilia t
nrFeliiSicilia (Portocala s f : t) = (if ePortocalaDeSicilia (Portocala s f) then f else 0) + nrFeliiSicilia t

--c
nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi (Portocala _ _ : t) = nrMereViermi t
nrMereViermi (Mar x y : t) = (if y then 1 else 0) + nrMereViermi t

data Linie = L [Int]

-- deriving (Show)

data Matrice = M [Linie]

-- deriving (Show)

--a
verifica :: Matrice -> Int -> Bool
-- verifica (M(lista)) n = foldr (&&) True (map(\y->y==n) (map (foldr(+) 0 )[nr|L(nr)<-lista]))

verifica (M matrix) n = foldr (&&) True [sum l == n | (L l) <- matrix]

--verifica (M[L[2,20,3], L[4,21], L[2,3,6,8,6], L[8,5,3,9]]) 25

instance Show Linie where
  show (L l) = foldr (++) "" (map (\x -> (show (x) ++ " ")) l)

instance Show Matrice where
  show (M m) = foldr (++) "" (map (\x -> (show (x) ++ "\n")) m)

pozitive :: Linie -> Bool
pozitive (L l) = and [x > 0 | x <- l]

doarPozN :: Matrice -> Int -> Bool
doarPozN (M matrix) n = and (map (\x -> pozitive x) [(L l) | (L l) <- matrix, (length l) == n])

--doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3
