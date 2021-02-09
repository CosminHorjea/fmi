type Depth = Int
data Set a = Nil | Node(Set a)a (Set a) Depth

node :: Set a -> a ->Set a -> Set a
node l x r = Node l x r (1 + (depth l `max` depth r))

depth :: Set a -> Int
depth Nil = 0 
depth (Node _ _ _ d) = d

list :: Set a -> [a]
list Nil = []
list (Node l x r _) = list l ++ [x] ++ list r

invariant :: Ord a => Set a->Bool 
invariant Nil = True 
invariant (Node l x r d) =
  invariant l && invariant r &&
  and [y< x | y<-list l]&&
  and [ y>x | y<- list r]&&
  abs ( depth l - depth r) <= 1 &&
  d==1 + (depth l `max` depth r)

empty :: Set a
empty = Nil

insert :: Ord a => a -> Set a -> Set a
insert x Nil = node empty x empty
insert x (Node x y r _)
  | x == y = node l y r
  | x< y = rebalance (node (insert x l) y r)
  | x> y = rebalance(node l y (insert x r))

set :: Ord a => [a] -> Set a
set =foldr inser empty

rebalance  :: Set a -> Set a
rebalance (Node (Node a x b _) y c _)
  | depth a >= depth b && depth a > depth c = node a x (node b y c)
rebalance (Node a x (Node b y c _) _)
  | depth c >= depth b && depth c > depth a = node(node a x b) y c
rebalance (Node (Node a x (Node b y c _) _) z d _)
  |depth (node b y c) > depth d= node (node a x b) y (node c z d)
rebalance (Node a x (Node (Node b y c _)z d _) _)
  | depth (node b y c) > depth a=node (node a x b) y (node c z d)
rebalance a = a

element :: Ord a => a -> Set a -> Bool 
x `element` Nil = False 
x `element` (Node l y r _)
  | x == y = True 
  | x <  y = x `element` l
  | x >  y = x `element` r

equal :: Ord a => Set a -> Set a -> Bool 
s `equal` t = list s == list t