{--
 Definim tipul arborilor ternari cu informații numere intregi  (doar) pe frunze.

    data Arb = Leaf Integer | Node Arb Arb Arb

Dat fiind un arbore, codul unui  drum de la radăcină la o  frunza este  secvența de valori Direction care se obtine considerand L pentru muchiile care duc la stânga, R pentru cele care duc la dreapta si M pentru cele din mijloc:

data Direction = L | M | R   deriving Show

type LeafCode = [Direction]

De exemplu, daca

tree = Node

          (Node (Leaf 1) (Leaf 3) (Leaf 4))

          (Node (Leaf 1) (Leaf 2) (Leaf 4))

          (Leaf 4)

atunci codurile asociate lui 4 sunt [L,R], [M,R], [R].

Să se scrie functia  leafCodes care, dat fiind un arbore si o valoare de tip Integer, întoarece  lista codurilor drumurilor la  frunzele cu valoarea data folosind  monada Writer () pentru a acumula rezultatul.

data Writer a = Writer { output :: [LeafCode], value :: a }

leafCodes :: Arb -> Integer -> Writer ()

> output $ leafCodes tree 4

[[L,R],[M,R],[R]]

Programul trebuie sa contina definitia completa a monadei  Writer ().

Hint: puteti folosi o functie auxiliara care retine intr-un parametru drumul parcurs pana la un anumit moment

Rezolvarea exercitiului se va scrie in caseta text.
-}
data Arb = Leaf Integer | Node Arb Arb Arb

data Direction = L|M|R deriving Show 

tree = Node(Node (Leaf 1) (Leaf 3) (Leaf 4))(Node (Leaf 1) (Leaf 2) (Leaf 4))(Leaf 4)

type LeafCode= [Direction]
data Writer a = Writer { output :: [LeafCode], value :: a }


-- class Monad m where
--    return :: a -> m a
--    (>>=) :: m a -> (a -> m b) -> m b
instance Monad Writer where
  return x = Writer { output=[],value = x}
  w >>= k = 
    let 
      Writer out1 v1 = w  --val si outputul de la writerul pe care il primesc
      Writer out2 v2 = k v1 -- aplic k (functia care ia valoarea neimpachetata) si fac un writer nou
    in
      Writer (out1 ++ out2) v2 -- apoi dau append la pasi in writerul final ci pastre valoarea de dupa ce am aplicat k

instance Functor Writer where
  fmap f (Writer o w) = Writer o (f w)

instance Applicative Writer where
  pure = return
  fw <*> w = do
    f <- fw
    a <- w
    return $  f a

write :: LeafCode -> Writer ()
write code = Writer [code] ()

leafCodesAux :: Arb -> Integer -> LeafCode -> Writer ()
leafCodesAux (Leaf v) i code =
  if v == i then
    write code
  else
    return ()
leafCodesAux (Node left middle right) value code = do
  leafCodesAux left value (code ++ [L])
  leafCodesAux middle value (code ++ [M])
  leafCodesAux right value (code ++ [R])

leafCodes :: Arb -> Integer -> Writer ()
leafCodes arb value = leafCodesAux arb value []


-- leafCodes :: Arb -> Integer -> Writer ()
