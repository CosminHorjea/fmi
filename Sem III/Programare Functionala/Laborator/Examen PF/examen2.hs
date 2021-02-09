data B e = R e Int | B e ::: B e
  deriving (Eq)

infixr 5 :::

-- instance Foldable B where
--   foldr f u aux =
--     case aux of
--       (R exp i) -> (f i (foldr f u exp))
--       (B e) (:::) (B e) -> u

instance Foldable B where
  foldr f u (b ::: b') = foldr f u (B f b) ::: foldr f u (B f b)
  foldr f u (R e i) = R e (f i)

fTest0 = maximum (R "nota" 2 ::: R "zece" 3 ::: R "la" 5 ::: R "examen" 1) == "zece"

class C e where
  cFilter :: (a -> Bool) -> e a -> e (Maybe a)
  fromList :: [a] -> e a

instance C B where
  cFilter l = map (\(R exp i) -> if exp then Just x else Nothing) l
  fromList l = map (\x -> (R (Just x) 1)) l

cTest0 =
  cFilter (\x -> length x == 4) (fromList ["nota", "zece", "la", "examen"])
    == (R (Just "nota") 1 ::: R (Just "zece") 2 ::: R Nothing 3 ::: R Nothing 4)