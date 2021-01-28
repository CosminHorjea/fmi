import Test.QuickCheck
import Test.QuickCheck.Gen

double :: Int -> Int
double x = 2 * x

triple :: Int -> Int
triple x = 3 * x

penta :: Int -> Int
penta x = 5 * x

test :: Int -> Bool
test x = (double x + triple x) == (penta x)

testFalse :: Int -> Bool
testFalse x = (double x + triple x) == 2 * (penta x)

myLookUp :: Int -> [(Int, String)] -> Maybe String
myLookUp key [] = Nothing
myLookUp key (x : xs)
  | (fst x) == key = Just (snd x)
  | otherwise = myLookUp key xs

testLookUp :: Int -> [(Int, String)] -> Bool
testLookUp key x = ((myLookUp key x) == (lookup key x))

-- testLookUpCond :: Int -> [(Int,String)] -> Property
-- testLookUpCond n list = n > 0 && n `div` 5 == 0 ==> testLookUp n list

data ElemIS = I Int | S String
  deriving (Show, Eq)

--faza e ca, Arbitrary este folosit de QuickCheck cand alege elemente
instance Arbitrary ElemIS where
  arbitrary = oneof [geni, gens] -- alege unul dinte cei doi genereatori, unul de INT si unul de STRING
    where
      f = (unGen (arbitrary :: Gen Int)) -- un genereator de Int-uri
      g = (unGen (arbitrary :: Gen String)) -- un generator de Strings
      geni = MkGen (\s i -> let x = f s i in (I x)) --creez un generator s-seed i-intreg, e specific pentru alegeea de elemente si e random
      gens = MkGen (\s i -> let x = g s i in (S x)) --acum , el imi genereaza ceva, dar trebuie ca ceva-ul (in cazul asta x), sa il pun in functiile de sus
                                                    -- care practic se asigura ca ce generez eu acolo e un INT (I) sau un STRING (S)

myLookUpElem :: Int -> [(Int, ElemIS)] -> Maybe ElemIS
myLookUpElem = _ [] = Nothing
myLookUpElem key (x:xs)
  | key == fst x = Just(snd x)
  | otherwise = myLookUpElem key xs

testLookUpElem :: Int -> [(Int, ElemIS)] -> Bool-- ca mai sus
testLookUpElem = undefined
