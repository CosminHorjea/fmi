type Input = String

type Remainder = String

type Output = String

newtype MyIO a = MyIO {runMyIO :: Input -> (a, Input, Output)}

instance Monad MyIO where
  return x = MyIO (\inp -> (x, inp, ""))
  m >>= k = MyIO f
    where
      f inp =
        let (x, inpx, outx) = runMyIO m inp
         in let (y, inpy, outy) = runMyIO (k x) inpx
             in (y, inpy, outx ++ outy)

instance Applicative MyIO where
  pure = return
  mf <*> ma = do f <- mf; a <- ma; return (f a)

instance Functor MyIO where
  fmap f ma = do a <- ma; return (f a)

myPutChar :: Char -> MyIO ()
myPutChar ch = MyIO (\inp -> ((), inp, [ch]))

myGetChar :: MyIO Char
myGetChar = MyIO (\(ch : inp) -> (ch, inp, ""))

runIO :: MyIO () -> String -> String
runIO command input = third (runMyIO command input)
  where
    third (_, _, x) = x

myPutStr :: String -> MyIO ()
myPutStr = foldr (>>) (return ()) . map myPutChar

myPutStrLn :: String -> MyIO ()
myPutStrLn s = myPutStr s >> myPutChar '\n'

myGetLine :: MyIO String
myGetLine = do
  x <- myGetChar
  if x == '\n'
    then return []
    else do
      xs <- myGetLine
      return (x : xs)