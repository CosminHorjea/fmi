--- Monada Writer

newtype WriterLS a = Writer {runWriter :: (a, [String])}

instance Monad WriterLS where
  return va = Writer (va, [])
  ma >>= k =
    let (va, log1) = runWriter ma
        (vb, log2) = runWriter (k va)
     in Writer (vb, log1 ++ log2)

instance Applicative WriterLS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor WriterLS where
  fmap f ma = pure f <*> ma

tell :: String -> WriterLS ()
tell log = Writer ((), [log])

logIncrement :: Int -> WriterLS Int
logIncrement x = Writer (x + 1, ["Increment " ++ show x])

logIncrementN :: Int -> Int -> WriterLS Int
logIncrementN x 0 = Writer (x, [])
logIncrementN x a = do
  oth <- logIncrementN x (a -1)
  logIncrement oth

isPos :: Int -> WriterLS Bool
isPos x = if (x >= 0) then (Writer (True, ["poz"])) else (Writer (False, ["neg"]))

mapWriterLS :: (a -> WriterLS b) -> [a] -> WriterLS [b]
mapWriterLS f [] = return []
mapWriterLS f (x : xs) = do
  h <- f x
  rest <- mapWriterLS f xs
  return $ h : rest

-- map isPos [1,2,3] -> eroare, rez monadice

-- map runWriter $ map isPos [1,-2,3] , mai intai aplica map pe aia din dreapta, dupa pun runWriter pe fiecare