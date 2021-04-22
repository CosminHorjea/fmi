{-
type Name = String

data Term
  = Var Name
  | Con Integer
  | Term :+: Term
  | Lam Name Term
  | App Term Term
  | Out Term
  deriving (Show)


newtype Writer a = Writer {runWriter :: (a, String)}

instance Monad Writer where
  return a = Writer (a, "")
  ma >>= k =
    let (a, log1) = runWriter ma
     in let (b, log2) = runWriter (k a) in Writer (b, log1 ++ log2)

instance Applicative Writer where
  pure = return
  mf <*> ma = do f <- mf; a <- ma; return (f a)

instance Functor Writer where
  fmap f ma = pure f <*> ma

type M a = Writer a

showM :: Show a => M a -> String
showM ma = "Output: " ++ w ++ "\nValue: " ++ show a
  where
    (a, w) = runWriter ma

data Value
  = Num Integer
  | Fun (Value -> M Value)
  | Wrong

type Environment = [(Name, Value)]

instance Show Value where
  show (Num a) = show a
  show (Fun _) = "functie"
  show Wrong = "Wrong"

interp :: Term -> Environment-> M Value
interp ( Var x) env = get x env
interp (Con i) env = return $ Num i
interp (t1 :+: t2) env = do
  v1 <- interp t1 env
  v2 <- interp t2 env
  add v1 v2
interp (Lam x e) env = 
  return $ Fun $ \v -> interp e ((x,v):env)
interp (App t1 t2) env = do
  f <- interp t1 env
  v <- interp t2 env
  apply f v
interp (Out t) env = do
  v <- interp t env
  tell (show v ++ "; ")
  return v

get :: Name -> Environment -> M Value
get x env = case [v | (y,v)<- env, x==y] of
  (v:_) -> return v
  _     -> return Wrong

add :: Value->Value -> M Value
add (Num i)(Num j) = return (Num $ i+j)
add _ _ = return Wrong

apply :: Value -> Value -> M Value
apply (Fun k) v = k v
apply _ _ = return Wrong

tell :: String -> Writer () 
tell logMsg = Writer ((),logMsg)

test :: Term-> String
test t = showM $ interp t []

pgm, pgmW :: Term
pgm = App (Lam "x" ((Var "x") :+: (Var "x"))) ((Out (Con 10)) :+: (Out (Con 11)))
pgmW = App (Var "y")(Lam "y" (Out(Con 3)))

-}
{-
type Name = String

data Term
  = Var Name
  | Con Integer
  | Term :+: Term
  | Lam Name Term
  | App Term Term
  | Out Term
  deriving (Show)


newtype MaybeWriter a = MW {getvalue ::Maybe (a, String)}

instance Monad MaybeWriter where
  return a = MW $ Just (a, "")
  ma >>= f =
    case a of
      Nothing -> MW Nothing 
      Just (x,v) ->
        case getvalue (f x) of
          Nothing -> MW Nothing 
          Just (y,v) -> MW $ Just (y,w++v)
    where a = getvalue ma

instance Applicative MaybeWriter where
  pure = return
  mf <*> ma = do f <- mf; a <- ma; return (f a)

instance Functor MaybeWriter where
  fmap f ma = pure f <*> ma

type M a = MaybeWriter a

showM :: Show a => M a -> String
showM ma =
  case a of
    Nothing -> "Nothing"
    Just (x,w) ->
      "Output "++ w ++ "Value: "++show x
  where a = getvalue ma 

data Value
  = Num Integer
  | Fun (Value -> M Value)

type Environment = [(Name, Value)]

instance Show Value where
  show (Num a) = show a
  show (Fun _) = "functie"

interp :: Term -> Environment-> M Value
interp ( Var x) env = get x env
interp (Con i) env = return $ Num i
interp (t1 :+: t2) env = do
  v1 <- interp t1 env
  v2 <- interp t2 env
  add v1 v2
interp (Lam x e) env = 
  return $ Fun $ \v -> interp e ((x,v):env)
interp (App t1 t2) env = do
  f <- interp t1 env
  v <- interp t2 env
  apply f v
interp (Out t) env = do
  v <- interp t env
  tell (show v ++ "; ")
  return v

get :: Name -> Environment -> M Value
get x env = case [v | (y,v)<- env, x==y] of
  (v:_) -> return v
  _     -> MW Nothing 

add :: Value->Value -> M Value
add (Num i)(Num j) = return (Num $ i+j)
add _ _ = MW Nothing 

apply :: Value -> Value -> M Value
apply (Fun k) v = k v
apply _ _ = MW Nothing 

tell :: String -> MaybeWriter () 
tell logMsg = MW $ Just ((),logMsg)

test :: Term-> String
test t = showM $ interp t []

pgm, pgmW :: Term
pgm = App (Lam "x" ((Var "x") :+: (Var "x"))) ((Out (Con 10)) :+: (Out (Con 11)))
pgmW = App (Var "y")(Lam "y" (Out(Con 3)))
-}

type Name = String

data Term
  = Var Name
  | Con Integer
  | Term :+: Term
  | Lam Name Term
  | App Term Term
  | Out Term
  | Term :/: Term
  deriving (Show)


newtype MaybeWriter a = MW {getvalue ::Maybe (a, String)}

instance Monad MaybeWriter where
  return a = MW $ Just (a, "")
  ma >>= f =
    case a of
      Nothing -> MW Nothing 
      Just (x,v) ->
        case getvalue (f x) of
          Nothing -> MW Nothing 
          Just (y,v) -> MW $ Just (y,w++v)
    where a = getvalue ma

instance Applicative MaybeWriter where
  pure = return
  mf <*> ma = do f <- mf; a <- ma; return (f a)

instance Functor MaybeWriter where
  fmap f ma = pure f <*> ma

type M a = MaybeWriter a

showM :: Show a => M a -> String
showM ma =
  case a of
    Nothing -> "Nothing"
    Just (x,w) ->
      "Output "++ w ++ "Value: "++show x
  where a = getvalue ma 

data Value
  = Num Integer
  | Fun (Value -> M Value)

type Environment = [(Name, Value)]

instance Show Value where
  show (Num a) = show a
  show (Fun _) = "functie"

interp :: Term -> Environment-> M Value
interp ( Var x) env = get x env
interp (Con i) env = return $ Num i
interp (t1 :+: t2) env = do
  v1 <- interp t1 env
  v2 <- interp t2 env
  add v1 v2
interp (Lam x e) env = 
  return $ Fun $ \v -> interp e ((x,v):env)
interp (App t1 t2) env = do
  f <- interp t1 env
  v <- interp t2 env
  apply f v
interp (Out t) env = do
  v <- interp t env
  tell (show v ++ "; ")
  return v
interp (t1 :/: t2) env= do
  v1<- interp t1 env
  v2 <- interp t2 env
  imparte v1 v2

imparte :: Value-> Value-> M Value
imparte (Num i) (Num j) 
  | j==0 = MW Nothing 
  | otherwise = return (Num $ i `div` j)
imparte _ _ = MW Nothing 

get :: Name -> Environment -> M Value
get x env = case [v | (y,v)<- env, x==y] of
  (v:_) -> return v
  _     -> MW Nothing 

add :: Value->Value -> M Value
add (Num i)(Num j) = return (Num $ i+j)
add _ _ = MW Nothing 

apply :: Value -> Value -> M Value
apply (Fun k) v = k v
apply _ _ = MW Nothing 

tell :: String -> MaybeWriter () 
tell logMsg = MW $ Just ((),logMsg)

test :: Term-> String
test t = showM $ interp t []

pgm, pgmW :: Term
pgm = App (Lam "x" ((Var "x") :+: (Var "x"))) ((Out (Con 10)) :+: (Out (Con 11)))
pgmW = App (Var "y")(Lam "y" (Out(Con 3)))
