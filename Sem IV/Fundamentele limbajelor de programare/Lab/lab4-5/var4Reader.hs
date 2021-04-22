--- Monada Identity

import Data.Maybe

newtype Identity a = Identity {runIdentity :: a}

instance Show a => Show (Identity a) where
  show m = show $ runIdentity m

instance Monad Identity where
  return x = Identity x
  k >>= f = f $ runIdentity k

instance Functor Identity where
  fmap f x = return $ f $ runIdentity x

instance Applicative Identity where
  pure = return
  Identity f <*> Identity x = Identity $ f x

--- Limbajul si  Interpretorul
newtype EnvReader a = Reader {runEnvReader :: Environment -> a}

instance Show a => Show (EnvReader a) where
  show m = show $ runEnvReader m []

instance Monad EnvReader where
  return x = Reader (\_ -> x)
  ma >>= k = Reader $ \env -> runEnvReader (k (runEnvReader ma env)) env

instance Applicative EnvReader where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return $ f a

instance Functor EnvReader where
  fmap f m = pure f <*> m

type M a = EnvReader a

type Name = String

data Term
  = Var Name
  | Con Integer
  | Term :+: Term
  | Lam Name Term
  | App Term Term
  deriving (Show)

pgm :: Term
pgm =
  App
    ( Lam
        "y"
        ( App
            ( App
                ( Lam
                    "f"
                    ( Lam
                        "y"
                        (App (Var "f") (Var "y"))
                    )
                )
                ( Lam
                    "x"
                    (Var "x" :+: Var "y")
                )
            )
            (Con 3)
        )
    )
    (Con 4)

data Value
  = Num Integer
  | Fun (Value -> M Value)
  | Wrong

instance Show Value where
  show (Num x) = show x
  show (Fun _) = "<function>"
  show Wrong = "<wrong>"

type Environment = [(Name, Value)]

ask :: EnvReader Environment
ask = Reader id

local :: (Environment -> Environment) -> EnvReader a -> EnvReader a -- !!
local f ma = Reader $ (\x -> (runEnvReader ma) . f $ x)

interp :: Term -> M Value
interp (Var name) = do
  env <- ask
  return $ fromMaybe Wrong (lookup name env)
interp (Con x) = return $ Num x
interp (a :+: b) = do
  aVal <- interp a
  bVal <- interp b
  add aVal bVal
interp (Lam name body) = do
  env <- ask
  return $ Fun $ \v -> local (const $ (name, v) : env) (interp body)
-- test :: Term -> String
-- test t = showM $ interp t []
interp (App fun arg) = do
  argValue <- interp arg
  funBody <- interp fun
  apply funBody argValue

add :: Value -> Value -> M Value
add (Num a) (Num b) = return $ Num $ a + b
add _ _ = return Wrong

apply :: Value -> Value -> M Value
apply (Fun f) v = f v
apply _ _ = return Wrong

showM :: Show a => M a -> String
showM ma = show $ runEnvReader ma []

test :: Term -> String
test t = showM $ interp t

pgm1 :: Term
pgm1 =
  App
    (Lam "x" ((Var "x") :+: (Var "x")))
    ((Con 10) :+: (Con 11))

main = do
  print $ test pgm1
  print $ showM $ interp (Var "x")
