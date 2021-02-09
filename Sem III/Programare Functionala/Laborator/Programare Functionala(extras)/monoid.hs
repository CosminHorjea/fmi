import Data.Monoid
-- import  Foldable as F  

-- newtype Product a = Product {getProdcut :: a}
--   deriving (Eq,Ord,Read,Show,Bounded)

-- instance Num a => Monoid(Product a) where
--   mempty = Product 1
--   Product x  `mappend` Product y = Product (x*y)

-- instance Monoid Ordering where  
--     mempty = EQ  
--     LT `mappend` _ = LT  
--     EQ `mappend` y = y  
--     GT `mappend` _ = GT  

-- lengthCompare :: String -> String -> Ordering
-- lengthCompare x y = let a = length x `compare` length y
--                         b = x `compare` y
--                     in if a == EQ then b else a

-- lengthCompare' :: String -> String -> Ordering
-- lengthCompare' x y = (length x `compare` length y) `mappend`
--                      (vowels x `compare` vowels y) `mappend`
--                      (x`compare` y)
--   where vowels = length . filter (`elem` "aeiou")

-- instance Monoid a => Monoid (Maybe a) where -- clasa maybe a e o insanta a monoidului doar daca a are o instanta de monoid
--   mempty = Nothing
--   Nothing `mappend` m = m
--   m `mappend` Nothing = m
--   Just m1 `mappend` Just m2 = Just (m1 `mappend` m2)


data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)  
instance Foldable Tree where
  foldMap f Empty = mempty
  foldMap f (Node x l r) = foldMap f l `mappend`
                           f x         `mappend`
                           foldMap f r

testTree = Node 5  
            (Node 3  
                (Node 1 Empty Empty)  
                (Node 6 Empty Empty)  
            )  
            (Node 9  
                (Node 8 Empty Empty)  
                (Node 10 Empty Empty)  
            )  


-- ghci> getAny $ F.foldMap (\x -> Any $ x == 3) testTree  
-- True  
-- foldMap aplcia functia pe fiecare nod si intoarce un monoid (Any) si dupa le uneste cu mappend

--tree to list 
-- foldMap (\x -> [x]) testTree 
-- pt ca sta intoarce un monoid (lista) si dupa se aplica (++) care e operatia pe lista
--sau ca plebii
-- foldr (\x y -> [x]++y) [] testTree