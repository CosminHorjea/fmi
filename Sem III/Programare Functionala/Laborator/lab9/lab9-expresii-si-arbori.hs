data Expr
  = Const Int -- integer constant
  | Expr :+: Expr -- addition
  | Expr :*: Expr -- multiplication
  deriving (Eq)

data Operation = Add | Mult deriving (Eq, Show)

data Tree
  = Lf Int -- leaf
  | Node Operation Tree Tree -- branch
  deriving (Eq, Show)

instance Show Expr where
  show (Const x) = show x
  show (e1 :+: e2) = show e1 ++ "+" ++ show e2
  show (e1 :*: e2) = show e1 ++ "*" ++ show e2

evalExp :: Expr -> Int
evalExp (Const x) = x
evalExp (e1 :+: e2) = evalExp e1 + evalExp e2
evalExp (e1 :*: e2) = evalExp e1 * evalExp e2

exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))

exp2 = (Const 2 :*: (Const 3 :+: Const 4))

exp3 = (Const 4 :+: (Const 3 :*: Const 3))

exp4 = (((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2)

test11 = evalExp exp1 == 6

test12 = evalExp exp2 == 14

test13 = evalExp exp3 == 13

test14 = evalExp exp4 == 16

evalArb :: Tree -> Int
evalArb (Lf n) = n
evalArb (Node Add arb1 arb2) = evalArb (arb1) + evalArb (arb2)
evalArb (Node Mult arb1 arb2) = evalArb (arb1) * evalArb (arb2)

expToArb :: Expr -> Tree
expToArb (Const n) = Lf n
expToArb (expr1 :+: expr2) = Node Add arbr1 arbr2
  where
    arbr1 = expToArb (expr1)
    arbr2 = expToArb (expr2)
expToArb (expr1 :*: expr2) = Node Mult arbr1 arbr2
  where
    arbr1 = expToArb (expr1)
    arbr2 = expToArb (expr2)

arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0) (Lf 5))

arb2 = Node Mult (Lf 2) (Node Add (Lf 3) (Lf 4))

arb3 = Node Add (Lf 4) (Node Mult (Lf 3) (Lf 3))

arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3) (Lf 1))) (Lf 2)

test21 = evalArb arb1 == 6

test22 = evalArb arb2 == 14

test23 = evalArb arb3 == 13

test24 = evalArb arb4 == 16

class MySmallCheck a where
  smallValues :: [a]
  smallCheck :: (a -> Bool) -> Bool
  smallCheck prop = and [prop x | x <- smallValues]

checkExp :: Expr -> Bool
checkExp expr = evalExp (expr) == evalArb (expToArb (expr))

instance MySmallCheck Expr where
  smallValues = [Const 1, Const 2]

test5 = smallCheck checkExp
