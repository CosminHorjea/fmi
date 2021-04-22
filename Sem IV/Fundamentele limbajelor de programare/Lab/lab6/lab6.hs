module Checker where

import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import SIMPLE

data Type = TInt | TBool
  deriving (Eq)

instance Show Type where
  show TInt = "int"
  show TBool = "bool"

type CheckerState = Map Name Type

emptyCheckerState :: CheckerState
emptyCheckerState = Map.empty

newtype EReader a = EReader {runEReader :: CheckerState -> (Either String a)}

throwError :: String -> EReader a
throwError e = EReader (\_ -> (Left e))

instance Monad EReader where
  return a = EReader (\env -> Right a)
  act >>= k = EReader f
    where
      f env = case (runEReader act env) of
        Left s -> Left s
        Right va -> runEReader (k va) env

instance Functor EReader where
  fmap f ma = do a <- ma; return (f a)

instance Applicative EReader where
  pure = return
  mf <*> ma = do f <- mf; a <- ma; return (f a)

askEReader :: EReader CheckerState
askEReader = EReader (\env -> Right env)

localEReader :: (CheckerState -> CheckerState) -> EReader a -> EReader a
localEReader f ma = EReader (\env -> (runEReader ma) (f env))

type M = EReader

expect :: (Show t, Eq t, Show e) => t -> t -> e -> M ()
expect tExpect tActual e =
  if (tExpect /= tActual)
    then
      ( throwError $
          "Type mismatch. Expected " <> show tExpect <> " but got " <> show tActual
            <> " for "
            <> show e
      )
    else (return ())

lookupM :: String -> M Type
lookupM name = do
  env <- askEReader
  case Map.lookup name env of
    Just x -> return x
    Nothing -> throwError $ "Variabila " ++ name ++ " nu exista! "

checkExp :: Exp -> M Type
checkExp (Id name) = lookupM name
checkExp (I _) = return TInt
checkExp (B _) = return TBool
checkExp (UMin exp) = checkUnaExp exp TInt
checkExp (Not exp) = checkUnaExp exp TBool
checkExp (BinA _ a b) = checkBinExp (a, b) (TInt, TInt, TInt)
checkExp (BinC _ a b) = checkBinExp (a, b) (TInt, TInt, TBool)
checkExp (BinE _ a b) = checkBinExpSame (a, b) TBool
checkExp (BinL _ a b) = checkBinExp (a, b) (TBool, TBool, TBool)

checkUnaExp :: Exp -> Type -> M Type
checkUnaExp exp expectedType = do
  expType <- checkExp exp
  expect expectedType expType exp
  return expectedType

checkBinExp :: (Exp, Exp) -> (Type, Type, Type) -> M Type
checkBinExp (a, b) (aExpectedType, bExpectedType, resultType) = do
  aType <- checkExp a
  bType <- checkExp b
  expect aExpectedType aType a
  expect bExpectedType bType b
  return resultType

checkBinExpSame :: (Exp, Exp) -> Type -> M Type
checkBinExpSame (a, b) resultType = do
  aType <- checkExp a
  bType <- checkExp b
  expect aType bType b
  return resultType

checkStmt :: Stmt -> M ()
checkStmt (Asgn name exp) = do
  varType <- lookupM name
  checkUnaExp exp varType
  return ()
checkStmt (If cond thenBlock elseBlock) = do
  checkUnaExp cond TBool
  checkStmt thenBlock
  checkStmt elseBlock
checkStmt (Read _ name) = do
  varType <- lookupM name
  expect TInt varType name
checkStmt (Print _ exp) = checkExp exp >> return ()
checkStmt (While cond block) = do
  checkUnaExp cond TBool
  checkStmt block
checkStmt (Block stmts) = checkBlock stmts

checkBlock :: [Stmt] -> M ()
checkBlock [] = return ()
checkBlock ((Decl name exp) : others) = do
  expType <- checkExp exp
  localEReader (Map.insert name expType) (checkBlock others)
checkBlock (stmt : others) = (checkStmt stmt) >> (checkBlock others)

checkPgm :: [Stmt] -> Bool
checkPgm pgm =
  case (runEReader (checkBlock pgm)) emptyCheckerState of
    Left err -> error err
    Right _ -> True

main :: IO ()
main = do
  print $ checkPgm pFact