module Lab7 where

import Control.Monad.State.Strict
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map


import SIMPLE

  


data Value = IVal Integer  | BVal Bool
  deriving (Show, Eq)

data ImpState = ImpState
    { env :: Map String Int
    , store :: Map Int Value
    , nextLoc :: Int
    }
  deriving (Show)
  

-- fromList :: Ord k => [(k, a)] -> Map k a 
-- construieste tipul Map dintr-o lista data  

-- insert :: Ord k => k -> a -> Map k a -> Map k a 
-- daca cheia exista deja, inlocuieste valoarea veche
 
-- lookup :: Ord k => k -> Map k a -> Maybe a  


-- mapMaybe :: (a -> Maybe b) -> Map k a -> Map k b  
-- colecteaza numai rezultatele Just
  
-- (!?) :: Ord k => Map k a -> k -> Maybe a 
-- gaseste valoarea corespunzatoare unei chei
  
 

compose :: Ord b => Map b c -> Map a b -> Map a c
compose bc ab
  | null bc = Map.empty
  | otherwise = Map.mapMaybe (bc Map.!?) ab

showImpState :: ImpState -> String
showImpState st = 
    "Final state: " <> show (compose (store st) (env st))

emptyState :: ImpState
emptyState = ImpState Map.empty Map.empty 0

type M = StateT ImpState IO


-- newtype StateT s m a = StateT {runStateT :: s -> m (a, s)}


-- state :: (Monad m)  => (s -> (a, s))  -> StateT s m a
-- state f = StateT (return . f)


--get :: (Monad m) => StateT s m s
--get = state $ \ s -> (s, s)

--put :: (Monad m) => s -> StateT s m ()
--put s = state $ \ _ -> ((), s)

-- gets :: (Monad m) => (s -> a) -> StateT s m a     
-- gets f = state $ \ s -> (f s, s)
-- intoarce o compnentanenta


--modify' :: (Monad m) => (s -> s) -> StateT s m ()
--modify' f = do
--    s <- get
--    put $! f s

runM :: M a -> IO (a, ImpState)
runM m = runStateT m emptyState

lookupM :: String -> M Value
lookupM x = do
    Just l <- Map.lookup x <$> gets env
    Just v <- Map.lookup l <$> gets store
    return v

updateM :: String -> Value -> M ()
updateM x v = do
    Just l <- Map.lookup x <$> gets env
    st <- gets store
    let st' = Map.insert l v st
    modify' (\s -> s {store = st'})

cop :: BinCop  -> (Integer -> Integer -> Bool)
-- asociaza simbolului de operatie o operatie concreta
cop Lt = (<)
cop  Gt = (>)
cop Lte = (<=)
-- cop W = \ x y -> (x * x< y)

lop :: BinLop  -> (Bool -> Bool -> Bool)
lop And = (&&)
lop Or = (||)

evalExp :: Exp -> M Value
evalExp (Id x) = lookupM x
evalExp (I i) = return (IVal i)
evalExp (B b) = return (BVal b)
evalExp (BinC op e1 e2) = do      -- :<: e1 e1
    IVal i1 <- evalExp e1
    IVal i2 <- evalExp e2
    return (BVal $ (cop op) i1 i2) -- BVal (i1 < i2)
evalExp (BinL op e1 e2) = do      -- :<: e1 e1
    BVal i1 <- evalExp e1
    BVal i2 <- evalExp e2
    return (BVal $ (lop op) i1 i2) -- BVal (i1 < i2)    
evalExp e = error $ "Evaluation for '" <> show e <> "' not yet defined."




-- mapM_ :: (Foldable t, Monad m) => (a -> m b) -> t a -> m () 
-- mapM_ f = foldr c (return ())
--          where c x k = f x >> k  

-- liftIO :: IO a -> m a  efectueaza  actiunea de intrare-iesire si intoarce ce tip ne trebuie 

evalStmt :: Stmt -> M ()
evalStmt (Asgn x e) = do
    v <- evalExp e
    updateM x v
evalStmt (Read s x) = do
    i <- liftIO (putStr s  >> readLn)
    evalStmt(Asgn x (I i))
evalStmt (Decl x e) = do
    v <- evalExp e
    modify' (declare v)
  where
    declare v st = ImpState env' store' nextLoc'
      where
        l = nextLoc st
        nextLoc' = 1 + nextLoc st
        store' = Map.insert l v (store st)
        env' = Map.insert x l (env st)
evalStmt (Block sts) = do
    oldEnv <- gets env
    mapM_ evalStmt sts
    modify' (\s -> s {env = oldEnv})
evalStmt (If be st1 st2) = do
                       BVal b <- evalExp be
                       if b then (evalStmt st1) else (evalStmt st2)                         
evalStmt s = error $ "Evaluation for '" <> show s <> "' not yet defined."

evalPgm :: [Stmt] -> IO ((), ImpState)
evalPgm sts = runM $ mapM_ evalStmt sts

