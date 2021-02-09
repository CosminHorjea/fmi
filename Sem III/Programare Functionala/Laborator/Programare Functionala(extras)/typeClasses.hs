elem' :: Prelude.Eq a => a -> [a] -> Bool
elem' x ys = or [x == y | y <- ys]
elem' x [] = False
elem' x (y : ys) = x == y || elem' x ys
elem' x ys = foldr (||) False (map (x ==) ys)

class Eq a where
  (==) :: a -> a -> Bool

instance Main.Eq Int where
  (==) = eqInt

instance Main.Eq Char where
  x == y = ord x == ord y

instance (Main.Eq a, Main.Eq b) => Main.Eq (a, b) where
  (u, v) == (x, y) = (u == x) && (v == y)

instance Eq a => Prelude.Eq [a] where
  [] == [] = True
  [] == y : ys = False
  x : xs == [] = False
  x : xs == y : ys = (x == y) && (xs == ys)

data EqDict a = EqD (a -> a -> Bool)

eq :: EqDict a -> a -> a -> Bool
eq (EqDict f) = f

elem :: EqDict a -> a -> [a] -> Bool
elem d x ys = or [eq d x y | y <- ys]

--seasons

-- data Season = Winter | Spring | Summer | Fall

next :: Season -> Season
next Winter = Spring

-- ....

warm :: Season -> Bool
warm Winter = False

-- ...

instance Prelude.Eq Season where
  Winter == Winter = True
  Spring == Spring = True
  Fall == Fall = True
  Summer == Summer = True
  _ == _ = False

instance Ord Season where
  Spring <= Winter = False
  Summer <= Winter = False
  Summer <= Spring = False
  Fall <= Winter = False
  Fall <= Spring = False
  Fall <= Summer = False
  _ <= _ = True

instance Show Seasons where
  show Winter = "Winter"
  show Spring = "Spring"
  show Fall = "Fall"
  show Summer = "Summer"

instance Enum Season where
  fromEnum Winter = 0
  fromEnum Spring = 1
  fromEnum Summer = 2
  fromEnum Fall = 3

  toEnum 0 = Winter
  toEnum 1 = Spring
  toEnum 2 = Summer
  toEnum 3 = Fall

data Season = Winter | Spring | Summer | Fall
  deriving (Eq, Ord, Show, Enum)

next :: Season -> Season
next x = toEnum ((fromEnum x + 1) `mod` 4)

warm :: Season -> Bool
warm x = x `elem` [Spring .. Fall] --[Spring,Summer,Fall]

type Radius = Float

type Width = Float

type Height = Float

data Shape
  = Circle Radius
  | Rect Width Height

area :: Shape -> Float
area (Circle r) = pi * r ^ 2
area (Rect w h) = w * h

instance Main.Eq Shape where
  Circle r == Circle r' = r == r'
  Rect w h == Rect w' h' = w == w' && h == h'
  _ == _ = False

instance Ord Shape where
  Circle r <= Circle r' = r < r'
  Circle r <= Rect w' h' = True
  Rect w h <= Rect w' r' = w < w' || (w == w' && h <= h')
  _ <= _ = False

instance Show Shape where
  show (Circle r) = "Circle " ++ showN r
  show (Radius w h) = "Radius " ++ showN w ++ " " ++ showN h

showN :: (Num a) => a -> String
showN x
  | x >= 0 = show x
  | otherwise = "(" ++ show x ++ ")"

-- data Shape
--   = Circle Radius
--   | Rect Width Height
--   deriving (Eq, Ord, Show)