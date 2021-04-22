import Data.Maybe

--- Monada Identity

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
type M = Identity

showM :: Show a => M a -> String
showM x = show $ runIdentity x

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

interp :: Term -> Environment -> M Value
interp (Var name) env = return $ fromMaybe Wrong (lookup name env)
interp (Con x) _ = return $ Num x
interp (a :+: b) env = do
  aVal <- interp a env
  bVal <- interp b env
  add aVal bVal
interp (Lam name body) env = return $ Fun (\v -> interp body ((name, v) : env))
interp (App fun arg) env = do
  argValue <- interp arg env
  funBody <- interp fun env
  apply funBody argValue

-- test :: Term -> String
-- test t = showM $ interp t []

add :: Value -> Value -> M Value
add (Num a) (Num b) = return $ Num $ a + b
add _ _ = return Wrong

apply :: Value -> Value -> M Value
apply (Fun f) v = f v
apply _ _ = return Wrong

test :: Term -> String
test t = showM $ interp t []

pgm1 :: Term
pgm1 =
  App
    (Lam "x" ((Var "x") :+: (Var "x")))
    ((Con 10) :+: (Con 11))

main = do
  print $ test pgm1
