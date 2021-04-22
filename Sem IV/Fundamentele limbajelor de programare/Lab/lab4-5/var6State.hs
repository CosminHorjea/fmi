newtype IntState a = IntState {runIntState :: Integer -> (a, Integer)}

instance Show a => Show (IntState a) where
  show m = "Value: " ++ show a ++ " Count: " ++ show state
    where
      (a,state) = runIntState m 0  

instance Monad IntState where
  return x = IntState (\s -> (x,s))
  k >>= f = IntState(\state -> let (a,state1) = runIntState k state in runIntState (f a) state1)

instance Functor IntState where
  fmap f x = pure f <*> x

instance Applicative IntState where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

modify :: (Integer -> Integer) -> IntState ()
modify fun = IntState (\s -> ((), fun s))

tickS :: IntState ()
tickS = modify (+ 1)

get :: IntState Integer
get = IntState(\s->(s,s))

--- Limbajul si  Interpretorul
type M a = IntState a

showM :: Show a => M a -> String
showM x = show x

type Name = String

data Term
  = Var Name
  | Con Integer
  | Term :+: Term
  | Lam Name Term
  | App Term Term
  | Count
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
interp (Var name) env = lookupM name env
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
interp Count _ = do
  count <- get
  return (Num count)

-- test :: Term -> String
-- test t = showM $ interp t []

lookupM :: Name -> Environment -> M Value
lookupM var env = case lookup var env of
  Just val -> return val
  Nothing -> return Wrong

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
