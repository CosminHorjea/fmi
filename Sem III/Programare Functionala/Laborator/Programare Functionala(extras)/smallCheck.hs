import Test.QuickCheck
import Test.QuickCheck.Gen

class MySmallCheck a where
  smallValues :: [a]
  smallCheck :: (a -> Bool) -> Bool
  smallCheck prop = sc smallValues
    where 
      sc [] = True
      sc (x:xs) = if(prop x) then (sc xs) else error "eroare"

instance MySmallCheck Int where
  smallValues = [0,12,3,45,91,100]
propInt :: Int -> Bool
propInt x = x < 110

data Season = Spring | Summer |Autumn |Winter deriving (Eq,Show)

instance Arbitrary Season where
  arbitrary = emenents [Spring,Summer,Autumn,Winter]

power :: Maybe Int -> Int -> Int
power Nothing n = 2 ^ n
power(Just m) n = m ^ n

divide :: Int -> Int -> Maybe Int
divide n 0 = Nothing 
divide n m = Just (n `div` m)

addints ::[Either Int String ] -> Int
addints [] = 0
addints (Left n : xs) = n + addints xs
addints (Right n : xs) = addints xs

addints' :: [Either Int  String]
addints' xs = sum [ n | Left n <-xs]

--instanta functor pt functie
instance Functor (->) a where
  fmap f g = f . g  -- compun functia f (cea din map cum ar veni) pe g (cea ca argument)

-- Bool ca monoid fata de conjunctie

newtype All = All {getAll :: Bool}
  deriving (Eq,Read ,Show)
instance Semigroup All where
  All x <> All y = All (x&&y)
instance Monoid All where
  mempty  = All True