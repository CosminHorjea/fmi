{- Monada Maybe este definita in GHC.Base

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing

instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)

instance Functor Maybe where
  fmap f ma = pure f <*> ma
-}

(<=<) :: (a -> Maybe b) -> (c -> Maybe a) -> c -> Maybe b
f <=< g = (\x -> g x >>= f)

asoc :: (Int -> Maybe Int) -> (Int -> Maybe Int) -> (Int -> Maybe Int) -> Int -> Bool
asoc f g h x = (h <=< (g <=< f) $ x) == ((h <=< g) <=< f $ x)

pos :: Int -> Bool
pos x = if (x >= 0) then True else False

foo :: Maybe Int -> Maybe Bool
foo mx = mx >>= (\x -> Just (pos x))

fooDo :: Maybe Int -> Maybe Bool
fooDo mx = do
  x <- mx
  return $ pos x

addM :: Maybe Int -> Maybe Int -> Maybe Int
addM mx my = do
  val1 <- mx
  val2 <- my
  return $ val1 + val2

addM2 :: Maybe Int -> Maybe Int -> Maybe Int
addM2 Nothing _ = Nothing
addM2 _ Nothing = Nothing
addM2 (Just a) (Just b) = Just (a + b)

cartesian_product :: Monad m => m a -> m b -> m (a, b)
cartesian_product xs ys = xs >>= (\x -> (ys >>= \y -> return (x, y)))

cartesian_productDo :: Monad m => m a -> m b -> m (a, b)
cartesian_productDo xs ys = do
  x <- xs
  y <- ys
  return (x, y)

prod :: (t1 -> t2 -> a) -> [t1] -> [t2] -> [a]
prod f xs ys = [f x y | x <- xs, y <- ys]

prodDo f xs ys = do
  x <- xs
  y <- ys
  return $ f x y

myGetLine :: IO String
myGetLine =
  getChar >>= \x ->
    if x == '\n'
      then return []
      else myGetLine >>= \xs -> return (x : xs)

myGetLineDo :: IO [Char]
myGetLineDo = do
  x <- getChar
  if x == '\n'
    then return []
    else do
      -- imi trebuie inca un do daca ies din notatia de monade (cand am scris if)
      xs <- myGetLineDo
      return (x : xs)

prelNo :: Floating a => a -> a
prelNo noin = sqrt noin

ioNumber :: IO ()
ioNumber = do
  noin <- readLn :: IO Float
  putStrLn $ "Intrare\n" ++ (show noin)
  let noout = prelNo noin
  putStrLn $ "Iesire"
  print noout

ioNumberNonDo :: IO ()
ioNumberNonDo = (readLn :: IO Float) >>= \noin -> (putStrLn $ ("Intrare: " ++ (show noin))) >> putStrLn "Iesire" >> print (prelNo noin)