import Data.List
import Data.Monoid ()

-- data Tree a = Nil | Node a (Tree a) (Tree a) deriving (Show, Eq, Read)

-- testTree = Node 4 (Node 3 Nil Nil) (Node 5 Nil Nil)

-- instance Foldable Tree where
--   foldMap f Nil = mempty
--   foldMap f (Node x l r) =
--     foldMap f l
--       `mappend` f x
--       `mappend` foldMap f r
type Id = String

type Link = Maybe String

type Info = Int

data Node = Node Id Info Link
  deriving (Show)

data NodeSpace = NodeSpace [Node]
  deriving (Show)

testNode = (Node "a" 1 (Just "b"))

listNodes = NodeSpace [(Node "b" 2 (Just "c")), (Node "c" 3 (Nothing))]

-- f01hc :: NodeSpace -> Node -> Link
f01hc (NodeSpace l) (Node id inf ln) = if length (filter (\(Node a b c) -> Just a == ln) l) == 1 then ln else Nothing

instance Eq Node where
  Node id info link == Node id' info' link' = info == info'

instance Eq NodeSpace where
  NodeSpace [] == NodeSpace [] = True
  NodeSpace (xs) == NodeSpace (xs') = and [or [info == info' | (Node id' info' link') <- xs'] == True | (Node id info link) <- xs]

-- Node "a" 1 (Just "b") == Node "a'" 2 (Just "b") = False
--NodeSpace [Node "a" 1 Nothing, Node “b” 2 (Just "a"), Node "b" 1 (Just "a")] == NodeSpace [Node "a" 1 (Just "b"), Node "b" 2 Nothing] = True

test = NodeSpace [Node "a" 1 Nothing, Node "b" 2 (Just "a"), Node "b" 1 (Just "a")] == NodeSpace [Node "a" 1 (Just "b"), Node "b" 2 Nothing]

test2 = NodeSpace [Node "a" 50 Nothing, Node "b" 2 (Just "a"), Node "b" 1 (Just "a")] == NodeSpace [Node "a" 1 (Just "b"), Node "b" 2 Nothing]

data MGraph = MGraph [(Id, [(Info, Id)])] deriving (Show)

f04hc :: NodeSpace -> Id -> [(Info, Id)]
f04hc (NodeSpace []) _ = []
f04hc (NodeSpace l) nodId = [(y, z) | (Node x y (Just z)) <- l, nodId == x]

-- f03hc :: NodeSpace -> MGraph
f05hc :: NodeSpace -> [(Id, [(Info, Id)])]
f05hc (NodeSpace []) = []
f05hc (NodeSpace ((Node x y z) : xs)) = ([(x, (f04hc (NodeSpace ((Node x y z) : xs)) x))] ++ (f05hc (NodeSpace xs)))

f03hc :: NodeSpace -> MGraph
f03hc n = (MGraph (foldl (\seen (x, y) -> if x `elem` [fst s | s <- seen] then seen else seen ++ [(x, y)]) [] (f05hc n)))

test3 = NodeSpace [Node "a" 1 Nothing, Node "b" 2 (Just "a"), Node "a" 3 (Just "c"), Node "a" 3 (Just "d")]
