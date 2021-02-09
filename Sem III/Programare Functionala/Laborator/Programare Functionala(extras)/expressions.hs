data Exp = Lit Int
          | Exp :+: Exp
          | Exp :*: Exp

eval :: Exp -> Int
eval (Lit n) = n
eval (e :+: f) = eval e + eval f
eval (e :*: f) = eval e * eval f

instance Eq Exp where
  Lit n == Lit n' = n == n'
  e :+: f == e' :+: f' = e == e' && f == f'
  e :*: f == e' :*: f' = e == e' && f == f'
  _       == _         = False

instance Ord Exp where
  Lit n <= Lit n’ = n < n’
  Lit n <= e’ :+: f’ = True
  Lit n <= e’ :*: f’ = True
  e :+: f <= e’ :+: f’ = e < e’ || (e == e’ && f <= f’)
  e :+: f <= e’ :*: f’ = True
  e :*: f <= e’ :*: f’ = e < e’ || (e == e’ && f <= f’)
  _ <= _ = False

instance Show Exp where
  show (Lit n) = "Lit " ++ showN n
  show (e :+: f) = "(" ++ show e ++ ":+:" ++ show f ++ ")"
  show (e :*: f) = "(" ++ show e ++ ":*:" ++ show f ++ ")"

data Exp = Lit Int | Exp :+: Exp | Exp :*: Exp deriving (Eq,Ord,Show)