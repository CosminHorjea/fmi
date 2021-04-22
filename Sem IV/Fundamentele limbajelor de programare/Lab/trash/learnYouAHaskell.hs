-- (>>=) :: (Monad m) => m a -> (a -> m b) -> mb

import Control.Monad (MonadPlus (mzero))
import Control.Monad.Writer
import Data.Monoid

applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
applyMaybe Nothing f = Nothing
applyMaybe (Just x) f = f x

type Birds = Int

type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
  | abs ((left + n) - right) < 4 = Just (left + n, right)
  | otherwise = Nothing

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
  | abs (left - (right + n)) < 4 = Just (left, right + n)
  | otherwise = Nothing

-- foo :: Maybe String
-- foo =
--   Just 3
--     >>= ( \x ->
--             Just "!"
--               >>= ( \y ->
--                       Just (show x ++ y)
--                   )
--         )

foo :: Maybe String
foo = do
  x <- Just 3
  y <- Just "!"
  Just (show x ++ y)

routine :: Maybe Pole
routine = do
  start <- return (0, 0)
  first <- landLeft 2 start
  second <- landRight 2 first
  landLeft 1 second

-- Fara monade
-- routine :: Maybe Pole
-- routine =
--     case Just (0,0) of
--         Nothing -> Nothing
--         Just start -> case landLeft 2 start of
--             Nothing -> Nothing
--             Just first -> case landRight 2 first of
--                 Nothing -> Nothing
--                 Just second -> landLeft 1 second

justH :: Maybe Char
justH = do
  (x : xs) <- Just "hello"
  return x

-- ghci> [1,2] >>= \n -> ['a','b'] >>= \ch -> return (n,ch)
-- [(1,'a'),(1,'b'),(2,'a'),(2,'b')]

listOfTuples :: [(Int, Char)]
listOfTuples = do
  n <- [1, 2]
  ch <- ['a', 'b']
  return (n, ch)

guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()
guard False = mzero

-- ghci> [1..50] >>= (\x -> guard ('7' `elem` show x) >> return x)
-- [7,17,27,37,47]

sevensOnly :: [Int]
sevensOnly = do
  x <- [1 .. 50]
  -- guard ('7' `elem` show x)
  return x

type KnightPos = (Int, Int)

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c, r) =
  filter
    onBoard
    [ (c + 2, r -1),
      (c + 2, r + 1),
      (c -2, r -1),
      (c -2, r + 1),
      (c + 1, r -2),
      (c + 1, r + 2),
      (c -1, r -2),
      (c -1, r + 2)
    ]
  where
    onBoard (c, r) = c `elem` [1 .. 8] && r `elem` [1 .. 8]

in3 :: KnightPos -> [KnightPos]
in3 start = do
  first <- moveKnight start
  second <- moveKnight first
  moveKnight second

canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start

(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)
f <=< g = \x -> g x >>= f

-- let f x = [x,-x]
-- let g x = [x*3,x*2]
-- let h = f <=< g
-- h 3

-- For a few monads more

applyLog :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog (x, log) f = let (y, newLog) = f x in (y, log `mappend` newLog)

type Food = String

type Price = Sum Int

addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _ = ("beer", Sum 30)

-- Instanta de monada a lui Writer
-- instance (Monoid w) => Monad (Writer w) where
--   return x = Writer (x, mempty)
--   (Writer (x, v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')

logNumber :: Int -> Writer [String] Int
logNumber x = writer (x, ["Got number: " ++ show x])

multWithLog :: Writer [String] Int
multWithLog = do
  a <- logNumber 3
  b <- logNumber 5
  return (a * b)

-- gcd' :: Int -> Int -> Int
-- gcd' a b
--   | b == 0 = a
--   | otherwise = gcd' b (a `mod` b)

-- gcd' :: Int -> Int -> Writer [String] Int
-- gcd' a b
--   | b == 0 = do
--     tell ["Finished with " ++ show a]
--     return a
--   | otherwise = do
--     tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
--     gcd' b (a `mod` b)

-- fst $ runWriter (gcd' 8 3)
-- mapM_ putStrLn $ snd $ runWriter (gcd' 8 3)

newtype DiffList a = DiffList {getDiffList :: [a] -> [a]}

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs ++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

instance Semigroup (DiffList a) where
  (DiffList a) <> (DiffList b) = DiffList a

instance Monoid (DiffList a) where
  mempty = DiffList (\xs -> [] ++ xs)
  (DiffList f) `mappend` (DiffList g) = DiffList (\xs -> f (g xs))

-- ghci> fromDiffList (toDiffList [1,2,3,4] `mappend` toDiffList [1,2,3])
-- [1,2,3,4,1,2,3]

gcd' :: Int -> Int -> Writer (DiffList String) Int
gcd' a b
  | b == 0 = do
    tell (toDiffList ["Finished with " ++ show a])
    return a
  | otherwise = do
    result <- gcd' b (a `mod` b)
    tell (toDiffList [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)])
    return result

-- let f = (+) <$> (*2) <*> (+10)
-- f 3 = 19

addStuff :: Int -> Int
addStuff = do
  a <- (* 2)
  b <- (+ 10)
  return (a + b)

-- sau
-- addStuff x =
--   let a = (* 2) x
--       b = (+ 10) x
--    in a + b
