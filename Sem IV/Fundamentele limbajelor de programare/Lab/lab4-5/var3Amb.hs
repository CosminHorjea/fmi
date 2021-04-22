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
type M a = [a]

type Name = String

data Term
  = Var Name
  | Con Integer
  | Term :+: Term
  | Lam Name Term
  | App Term Term
  | Amb Term Term
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
interp (Var name) env = case (lookup name env) of
  Nothing -> []
  Just x -> [x]
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
interp (Amb a b) env = (interp a env) ++ (interp b env)

--interp (App (Lam "x" (Var "x" :+: Var "x")) (Amb (Con 1) (Con 2)))) []
-- gen amb foloseste ambele variabile alea (termeni) si alea sunt date la functia lambda
-- de underezulta mai multe outputs [2,4] adica [1+1,2+2]

-- test :: Term -> String
-- test t = showM $ interp t []

add :: Value -> Value -> M Value
add (Num a) (Num b) = return $ Num $ a + b
add _ _ = return Wrong

apply :: Value -> Value -> M Value
apply (Fun f) v = f v
apply _ _ = return Wrong

test :: Term -> String
test t = show $ interp t []

pgm1 :: Term
pgm1 =
  App
    (Lam "x" ((Var "x") :+: (Var "x")))
    ((Con 10) :+: (Con 11))

main = do
  print $ test pgm1
