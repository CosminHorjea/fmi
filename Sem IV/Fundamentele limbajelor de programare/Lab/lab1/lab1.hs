--- Ex 1
data Prog = On Instr

data Instr = Off | Expr :> Instr

data Expr = Mem | V Int | Expr :+ Expr

type Env = Int

type DomProg = [Int]

type DomInstr = Env -> [Int]

type DomExpr = Env -> Int

prog :: Prog -> DomProg
prog (On s) = stmt s 0

stmt :: Instr -> DomInstr
stmt (ex :> is) env = let val = expr ex env in (val : (stmt is val))
stmt Off env = []

expr :: Expr -> DomExpr
expr Mem env = env
expr (V i) _ = i
expr (ex1 :+ ex2) env = (expr ex1 env) + (expr ex2 env)

type Name = String

data Hask
  = HTrue
  | HFalse
  | HLit Int
  | HLet Name Hask Hask
  | HIf Hask Hask Hask
  | Hask :==: Hask
  | Hask :+: Hask
  | HVar Name
  | HLam Name Hask
  | Hask :$: Hask
  deriving (Read, Show)

infix 4 :==:

infixl 6 :+:

infixl 9 :$:

data Value
  = VBool Bool
  | VInt Int
  | VFun (Value -> Value)
  | VError -- pentru reprezentarea erorilor

type HEnv = [(Name, Value)]

type DomHask = HEnv -> Value

-- Ex 1
instance Show Value where
  show (VBool b) = show b
  show (VInt i) = show i
  show (VFun _) = "function"
  show VError = "error"

-- Ex 2
instance Eq Value where
  (VBool b1) == (VBool b2) = b1 == b2
  (VInt i1) == (VInt i2) = i1 == i2
  a == b = error ((show b) ++ " nu se poate compara cu " ++ (show a))

-- Ex 3

isError :: Value -> Bool
isError VError = True
isError _ = False

hEval :: Hask -> HEnv -> Value
hEval HTrue _ = VBool True
hEval HFalse _ = VBool False
hEval (HLit i) _ = VInt i
hEval (HVar name) env = case (lookup name env) of
  Nothing -> error $ "Variabila " ++ name ++ " nu este definita "
  Just v -> v
hEval (HLam name ex) env = VFun (\value -> hEval ex ((name, value) : env))
hEval (HLet name val ex) env = hEval ex ((name, (hEval val env)) : env)
--operatii
hEval (expr1 :==: expr2) env = VBool $ (hEval expr1 env) == (hEval expr2 env) --evaluez fieacere expresie, vad ce rezultat are si le comapr pretty ez
hEval (expr1 :+: expr2) env = case ((hEval expr1 env), (hEval expr2 env)) of -- deci, rezolv expresiile si vad
  (VInt a, VInt b) -> VInt $ a + b -- daca sunt numere, pot sa le adun duuh
  (a, b) -> error "Nu am putut efectua adunarea" -- altfel, inseamna ca incerca sa adun altceva decat numere, sau un numar cu altceva, eroare

--logics
hEval (HIf cond trueBranch falseBranch) env = case (hEval cond env) of --evaulez expresia
  (VBool True) -> hEval trueBranch env -- practic ar intoarce un VBool si asa impart cazurile
  (VBool False) -> hEval falseBranch env
  v -> error "Nu am putut evalua expresia"
hEval (expr1 :$: expr2) env = case ((hEval expr1 env), (hEval expr2 env)) of -- asta e operatorul de aplicativitate
  ((VFun f), v) -> f v -- deci aplic ce e in stanga pe ce e in dreapta
  (_, _) -> error "Nu e functie pe prima poz"

main = do
  print $ (VInt 5) == (VInt 5)