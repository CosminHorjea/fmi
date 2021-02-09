type Key = Int
type Value = String

class Collection c where
  cempty :: c 
  csingleton :: Key ->  Value -> c 
  cinsert:: Key -> Value -> c  -> c 
  cdelete :: Key -> c  -> c 
  clookup :: Key -> c -> Maybe Value
  ctoList :: c  -> [(Key, Value)]
  ckeys :: c  -> [Key]
  ckeys c = [fst pair | pair <- ctoList c]
  cvalues :: c  -> [Value]
  cvalues c = [snd pair | pair <- ctoList c]
  cfromList :: [(Key,Value)] -> c
  cfromList [] = cempty
  cfromList ((k,v) : list) = cinsert k v (cfromList list)

newtype  PairList 
  = PairList { getPairList :: [(Key,Value)] }
instance Collection PairList where
  cempty = PairList []
  csingleton k v = PairList[(k,v)]
  cinsert k v (PairList l) = if k `elem` ckeys(PairList l) then (PairList l) else (PairList ([(k,v)]++l))
  cdelete k (PairList l) = PairList [(key,val) | (key,val)<- l,key/=k]
  ctoList (PairList l) = l
  clookup _ (PairList []) = Nothing 
  clookup k (PairList (h:t))
    |k == (fst h) = Just (snd h)
    |otherwise = clookup k (PairList t)
data SearchTree 
  = Empty
  | Node
      SearchTree  -- elemente cu cheia mai mica 
      Key                    -- cheia elementului
      (Maybe Value)          -- valoarea elementului
      SearchTree  -- elemente cu cheia mai mare
   deriving Show   

instance Collection SearchTree where
  cempty = Empty
  csingleton k v = Node Empty k (Just v) Empty
  cinsert k v Empty = csingleton k v
  cinsert k v (Node l k1 v1 r) = if k > k1 then Node l k1 v1 (cinsert k v r) else Node (cinsert k v l) k1 v1 r
  cdelete k (Node l k1 v1 r) 
    | k == k1 = Node l k1 Nothing r
    | k < k1 = cdelete k l
    | k > k1 = cdelete k r
  ctoList Empty = []
  ctoList (Node l k Nothing r) =(ctoList l) ++ (ctoList r)
  ctoList (Node l k (Just v) r) = (ctoList l) ++ [(k,v)] ++ (ctoList r)
  ckeys Empty = []
  ckeys (Node l k (Just v) r) = ckeys l ++ [k]++ckeys r
  cvalues Empty = []
  cvalues (Node l k Nothing  r) = cvalues l ++ cvalues r
  cvalues (Node l k (Just v) r) = cvalues l ++ [v] ++ cvalues r
  clookup k Empty = Nothing 
  clookup k (Node l k' (Just v) r) 
    | k == k' = Just v
    | k > k' = clookup k r
    | k < k' = clookup k l
    | otherwise = Nothing 
  cfromList [] = Empty
  cfromList ((k,v):xs)= cinsert k v (cfromList xs) -- probabil astea ultimele nu trebuei redefinite fiindca sunt deja in collection
