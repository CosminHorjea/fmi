import Data.List (nub)
import Data.Maybe (fromJust)

type Nume = String

data Prop
  = Var Nume
  | F
  | T
  | Not Prop
  | Prop :|: Prop
  | Prop :&: Prop
  | Prop :->: Prop
  | Prop :<->: Prop
  deriving (Eq, Read)

infixr 2 :|:

infixr 3 :&:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R")))

instance Show Prop where
  show F = "F"
  show T = "T"
  show (Var p) = show p
  show (Not prop) = "(~" ++ show prop ++ ")"
  show (prop1 :&: prop2) = "(" ++ show prop1 ++ " & " ++ show prop2 ++ ")"
  show (prop1 :|: prop2) = "(" ++ show prop1 ++ " | " ++ show prop2 ++ ")"
  show (prop1 :->: prop2) = "(" ++ show prop1 ++ " -> " ++ show prop2 ++ ")"
  show (prop1 :<->: prop2) = "(" ++ show prop1 ++ " <-> " ++ show prop2 ++ ")"

test_ShowProp :: Bool
test_ShowProp =
  show (Not (Var "P") :&: Var "Q") == "((~P) & Q)"

type Env = [(Nume, Bool)]

env :: Env
env = [("P", False), ("Q", False)]

impureLookup :: Eq a => a -> [(a, b)] -> b
impureLookup x environment = fromJust (lookup x environment)

eval :: Prop -> Env -> Bool
eval (Var p) env = impureLookup p env -- ma uit sa caut valoarea variabileli logice in env
eval T _ = True -- true si fals sunt True sau False, indiferent de env
eval F _ = False
eval (Not p) env = not (eval p env) -- iau opusul variabilei din env
eval (p1 :&: p2) env = (eval p1 env) && (eval p2 env) -- pretty logic 😁
eval (p1 :|: p2) env = (eval p1 env) || (eval p2 env)
eval (p1 :->: p2) env = eval ((Not p1) :|: p2) env
eval (p1 :<->: p2) env = eval ((p1 :->: p2) :&: (p2 :->: p1)) env

test_eval :: Bool
test_eval = eval (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True

variabile :: Prop -> [Nume]
variabile (Var p) = [p]
variabile T = []
variabile F = []
variabile (Not p) = variabile p
variabile (p1 :&: p2) = nub (variabile p1 ++ variabile p2)
variabile (p1 :|: p2) = nub (variabile p1 ++ variabile p2)

test_variabile =
  variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]

envs :: [Nume] -> [Env]
envs [] = []
envs [x] = [[(x, False)], [(x, True)]]
envs (x : xs) = [(x, val) : e | val <- [False, True], e <- envs xs]

test_envs =
  envs ["P", "Q"]
    == [ [ ("P", False),
           ("Q", False)
         ],
         [ ("P", False),
           ("Q", True)
         ],
         [ ("P", True),
           ("Q", False)
         ],
         [ ("P", True),
           ("Q", True)
         ]
       ]

satisfiabila :: Prop -> Bool
satisfiabila p = or [eval p env | env <- envs (variabile p)]

test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True

test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida p = and [eval p env | env <- envs (variabile p)]

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False

test_valida2 = valida (Not (Var "P") :|: Var "P") == True

show_Bool :: Bool -> String
show_Bool True = "T"
show_Bool False = "F"

tabelAdevar :: Prop -> String
tabelAdevar p = concat $ map (++ "\n") tabel
  where
    vars = variabile p
    afis_prima = concat $ (map (++ "") vars) ++ [show p]
    evaluari = envs vars
    aux_af tv = (show_Bool tv) ++ ""
    afis_evaluare ev = concat $ (map aux_af [snd p | p <- ev]) ++ [show_Bool (eval p ev)]
    tabel = afis_prima : (map afis_evaluare evaluari)

echivalenta :: Prop -> Prop -> Bool
echivalenta p1 p2 = and [eval p1 env == eval p2 env | env <- envs (variabile p1)]

test_echivalenta1 =
  True
    == (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))

test_echivalenta2 =
  False
    == (Var "P") `echivalenta` (Var "Q")

test_echivalenta3 =
  True
    == (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))
