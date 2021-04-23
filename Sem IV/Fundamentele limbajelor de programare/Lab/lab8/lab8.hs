-- Bibliografie:  Graham Hutton, Programming in Haskell, 2nd edition, Chapter 13

import Control.Applicative (Alternative (empty, many, (<|>)))
import Control.Monad (MonadPlus (..))
import Data.Char (isDigit, isSpace, ord)

newtype Parser a = Parser {apply :: String -> [(a, String)]}

parse :: Parser a -> String -> a
parse m s = head [x | (x, t) <- apply m s, t == ""]

-- parse anychar "a123" = head [ x | (x,t) <- apply anychar "a123". t==""]

-- Recunoasterea unui caracter arbitrar
anychar :: Parser Char
anychar = Parser f
  where
    f [] = []
    f (c : s) = [(c, s)]

-- Recunoasterea unui caracter cu o proprietate
satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser f
  where
    f [] = []
    f (c : s)
      | p c = [(c, s)]
      | otherwise = []

-- Recunoasterea unui anumit caracter
char :: Char -> Parser Char
char c = satisfy (== c)

-- Recunoasterea unui cuvant cheie caracter
string :: String -> Parser String
string [] = Parser (\s -> [([], s)])
string (x : xs) = Parser f
  where
    f s = [(y : z, zs) | (y, ys) <- apply (char x) s, (z, zs) <- apply (string xs) ys]

-- asta e un parser care cauta un string specificat in alt string
-- imi intoarce un parser care stie sa gaseasca un string specific

-- * Main> apply (string "abcd1234") "abcd1234asdas"

-- [("abcd1234","asdas")]

-- Exercitiul 1

three :: Parser (Char, Char)
three = Parser f
  where
    f (a : b : c : t) = [((a, c), t)]
    f _ = []

three2 :: Parser (Char, Char)
three2 = Parser f
  where
    f s = [((a, c), t) | (a, l1) <- apply anychar s, (b, l2) <- apply anychar l1, (c, t) <- apply anychar l2]

-- Exercitiul 2

instance Monad Parser where
  return x = Parser (\s -> [(x, s)])
  m >>= k =
    Parser
      ( \s ->
          [ (y, u)
            | (x, t) <- apply m s,
              (y, u) <- apply (k x) t
          ]
      )

instance Applicative Parser where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor Parser where
  -- fmap f ma = pure f <*> ma
  fmap f ma = Parser (\s -> [(f v, t) | (v, t) <- (apply ma s)]) --aplic un parser pe s si il pun un (v,t) iar dupa aplic f pe v

-- Exercitiul 3

anycharord :: Parser Int
anycharord = fmap ord anychar

-- Exercitiul 4

failM = Parser (\s -> [])

instance MonadPlus Parser where
  mzero = failM
  mplus m n = Parser (\s -> apply m s ++ apply n s)

instance Alternative Parser where
  empty = mzero
  (<|>) = mplus

satisfyM :: (Char -> Bool) -> Parser Char
satisfyM p = do
  c <- anychar
  if p c then return c else failM

digit = satisfyM isDigit

abcP = satisfyM (`elem` ['A', 'B', 'C'])

alt :: Parser a -> Parser a -> Parser a
alt p1 p2 = Parser f
  where
    f s = apply p1 s ++ apply p2 s

manyP :: Parser a -> Parser [a]
manyP p = someP p <|> return []

someP :: Parser a -> Parser [a]
someP p = do
  x <- p
  xs <- manyP p
  return (x : xs)

identifier :: Parser Char -> Parser Char -> Parser String
identifier firstCh nextCh = do
  c <- firstCh
  s <- many nextCh
  return (c : s)

decimal :: Parser Int
decimal = do
  s <- someP digit
  return (read s)

negative :: Parser Int
negative = do
  char '-'
  n <- decimal
  return (- n)

integer :: Parser Int
integer = decimal `mplus` negative

skipSpace :: Parser ()
skipSpace = do
  _ <- many (satisfyM isSpace)
  return ()

tokenS :: Parser a -> Parser a
tokenS p = do
  skipSpace
  x <- p
  skipSpace
  return x

-- Exercitiul 5
howmany :: Char -> Parser Int
howmany c = fmap length (someP (char c))

-- Exercitiul 6
twocharord = Parser f
  where
    f (a : b : t) = [(ord a + ord b, t)]
    f_ = []

twocharord2 = fmap (+) anycharord <*> anycharord

-- Exercitiul 7
no :: Int -> Int -> Int -> Int -> Int
no x y z v = x * 1000 + y * 100 + z * 10 + v

fourdigit = Parser f
  where
    f (a : b : c : d : t) = if (all (isDigit) [a, b, c, d]) then [(no (ord a - ord '0') (ord b - ord '0') (ord c - ord '0') (ord d - ord '0'), t)] else []
    f _ = []