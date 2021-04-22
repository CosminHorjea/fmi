import Data.List
import Data.Maybe

type Name = String

data Pgm = Pgm [Name] Stmt
  deriving (Read, Show)

data Stmt = Skip | Stmt ::: Stmt | If BExp Stmt Stmt | While BExp Stmt | Name := AExp
  deriving (Read, Show)

data AExp = Lit Integer | AExp :+: AExp | AExp :*: AExp | Var Name
  deriving (Read, Show)

data BExp = BTrue | BFalse | AExp :==: AExp | Not BExp
  deriving (Read, Show)

infixr 2 :::

infix 3 :=

infix 4 :==:

infixl 6 :+:

infixl 7 :*:

type Env = [(Name, Integer)]

factStmt :: Stmt
factStmt =
  "p" := Lit 1 ::: "n" := Lit 3
    ::: While
      (Not (Var "n" :==: Lit 0))
      ( "p" := Var "p" :*: Var "n"
          ::: "n" := Var "n" :+: Lit (-1)
      )

pg1 :: Pgm
pg1 = Pgm [] factStmt --asta e doar un program de testat

aEval :: AExp -> Env -> Integer --  evaluam operatii
aEval (Lit a) _ = a -- doar intaorcem a (a este un "literal")
aEval (a :+: b) e = aEval a e + aEval b e -- la un moment dat o sa se intoarca valoarea lui a si b si le adunam
aEval (a :*: b) e = aEval a e * aEval b e -- aici le inmultim
aEval (Var name) e = fromJust $ lookup name e -- aici luam valoarea variabileli din env

bEval :: BExp -> Env -> Bool -- evaulam chestii binare
bEval BTrue _ = True --este mereu True, indiferent de context
bEval BFalse _ = False -- aici de mereu false
bEval (a :==: b) e = aEval a e == aEval b e -- evaluam a si b si pana la urma vedem daca sunt egale
bEval (Not a) e = not $ bEval a e -- il evaluam pe a si dupa negam

sEval :: Stmt -> Env -> Env -- evaluam un statement
sEval Skip env = env -- daca e skip, dam skip...
sEval (s1 ::: s2) env = sEval s2 $ sEval s1 env -- se ajunge mai intai la env de dupa op s1 si dupa se evalueaza 2, nu stiu ce inseamna ::: tho
sEval (If cond thenBranch elseBranch) env =
  -- aici e un if
  if bEval cond env
    then sEval thenBranch env
    else sEval elseBranch env
sEval (While cond st) env =
  -- aici e un while
  if bEval cond env
    then sEval (While cond st) (sEval st env)
    else env
sEval (name := exp) env = (name, aEval exp env) : filter ((/= name) . fst) env -- aici asignam o valoare, deci facem perechea si dupa o adaugam in env, dar avem grija sa o suprascriem(filter)

pEval :: Pgm -> Env
pEval (Pgm vars st) = sEval st $ zip vars $ repeat 0 --facem o lista de 0, le facem tupluri cu zip, gen ("a",0),("b,0") etc <- asta e env, si dupa evaluam st (Statement)
