-- Monada Reader

newtype Reader env a = Reader {runReader :: env -> a}

instance Monad (Reader env) where --reader monad allows us to treat functions as values with context
  return x = Reader (\_ -> x)
  ma >>= k = Reader f
    where
      f env =
        let a = runReader ma env-- runReader ma imi da o functie care ia un env deci pe env-ul de la final se aplica funtia aia si imi iese a
         in runReader (k a) env -- iar aici primesc iara o functie care se duce mai sus de une am where

instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor (Reader env) where
  fmap f ma = pure f <*> ma

ask :: Reader env env
ask = Reader id

local :: (r -> r) -> Reader r a -> Reader r a
local f ma = Reader $ (\r -> (runReader ma) (f r))

-- Reader Person String

data Person = Person {name :: String, age :: Int}

-- showPersonN :: Person -> String
-- showPersonN person = "Name: " ++ name person

-- showPersonA :: Person -> String
-- showPersonA person = "Age: " ++ show (age person)

-- showPerson :: Person -> String
-- showPerson a = "(" ++ showPersonN a ++ "," ++ showPersonA a ++ ")"

-- mshowPersonN :: Reader Person String
-- mshowPersonN = Reader showPersonN

-- mshowPersonA :: Reader Person String
-- mshowPersonA = Reader showPersonA

-- mshowPerson :: Reader Person String
-- mshowPerson = Reader showPerson
-- another example

showPersonN :: Person -> String
showPersonN p = let x = name p in ("Name: " ++ x)

showPersonA :: Person -> String
showPersonA p = let y = age p in ("AGE: " ++ (show y))

showPerson :: Person -> String
showPerson p =
  let x = showPersonN p
      y = showPersonA p
   in ("(" ++ x ++ "," ++ y ++ ")")

mshowPersonN :: Reader Person String
mshowPersonN = do
  p <- ask --presupun ca ask ia parametrul
  return ("Name:" ++ (name p))

mshowPersonA :: Reader Person String
mshowPersonA = do
  p <- ask
  return ("Age" ++ (show (age p)))

mshowPerson :: Reader Person String
mshowPerson = do
  x <- mshowPersonN
  y <- mshowPersonA
  return ("(" ++ x ++ "," ++ y ++ ")")