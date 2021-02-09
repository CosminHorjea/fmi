-- {-# LANGUAGE FlexibleInstances #-}

import Data.Char (isUpper)
import Data.Foldable (foldMap, foldr)
import Data.Monoid
import Data.Semigroup (Max (..), Min (..))

elem :: (Foldable t, Eq a) => a -> t a -> Bool
elem x = getAny . foldMap (\y -> Any (y == x))

null :: (Foldable t) => t a -> Bool
null x = Prelude.length x == 0

length :: (Foldable t) => t a -> Int
length = foldr (\_ a -> a + 1) 0

toList :: (Foldable t) => t a -> [a]
toList = foldr (:) []

fold :: (Foldable t, Monoid m) => t m -> m
fold = foldMap id -- Hint: folosiți foldMap

data Constant a b = Constant b deriving (Eq, Show)

instance Foldable (Constant a) where
  foldMap _ _ = mempty

data Two a b = Two a b

instance Foldable (Two a) where
  foldMap f (Two _ b) = f b

data Three a b c = Three a b c

instance Foldable (Three a b) where
  foldMap f (Three _ _ c) = f c

data Three' a b = Three' a b b

instance Foldable (Three' a) where
  foldMap (Three' _ b c) = (f b) <> (f c)

data Four' a b = Four' a b b b

instance Foldable (Four' a) where
  foldMap f (Four' _ b c d) = (f b) <> (f c) <> (f d)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)

filterF ::
  ( Applicative f,
    Foldable t,
    Monoid (f a)
  ) =>
  (a -> Bool) ->
  t a ->
  f a
filterF = foldMap (\x -> if p x then pure x else mempty) -- Hint folosiți foldMap

unit_testFilterF1 = filterF Data.Char.isUpper "aNA aRe mEre" == "NARE"

unit_testFilterF2 = filterF Data.Char.isUpper "aNA aRe mEre" == First (Just 'N')

unit_testFilterF3 = filterF Data.Char.isUpper "aNA aRe mEre" == Min 'A'

unit_testFilterF4 = filterF Data.Char.isUpper "aNA aRe mEre" == Max 'R'

unit_testFilterF5 = filterF Data.Char.isUpper "aNA aRe mEre" == Last (Just 'E')

newtype Identity a = Identity a

data Pair a = Pair a a

-- scrieți instanță de Functor pentru tipul Two de mai sus
instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

-- scrieți instanță de Functor pentru tipul Three de mai sus
instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

-- scrieți instanță de Functor pentru tipul Three' de mai sus

instance Functor (Three' a) where
  fmap f (Three' a b c) = Three' a (f b) (f c)

data Four a b c d = Four a b c d

data Four'' a b = Four'' a a a b

-- scrieți o instanță de Functor penru tipul Constant de mai sus
instance Functor (Constant a) where
  fmap f (Constant a) = Constant (f a)

data Quant a b = Finance | Desk a | Bloor b

data K a b = K a deriving (Eq, Show)

newtype Flip f a b = Flip (f b a) deriving (Eq, Show)

-- pentru Flip nu trebuie să faceți instanță
instance Functor (K a) where
  fmap _ (K a) = K a

newtype K' a b = K' a

instance Functor (Flip K' a) where -- ??
  fmap f (Flip (K' x)) = Flip $ K' (f x)

data LiftItOut f a = LiftItOut (f a)

instance Functor f => Functor (LiftItOut f) where
  fmap f (LiftItOut a) = LiftItOut (fmap f a)

data Parappa f g a = DaWrappa (f a) (g a)

instance (Functor f, Functor f1) => Functor (Parappa f f1) where
  fmap f (DaWrappa fa ga) = DaWrappa (fmap f fa) (fmap f ga)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)

instance Functor g => Functor (IgnoreOne f g a) where
  fmap f (IgnoringSomething fa ga) = IgnoringSomething fa (f ga)

data Notorious g o a t = Notorious (g o) (g a) (g t)

instance Functor f => Functor (Notorious f o a) where
  fmap f (Notorious go ga gt) = Notorious go ga (fmap f gt)

-- scrieți o instanță de Functor pentru tipul GoatLord de mai sus

instance Functor GoatLord where
  fmap _ NoGoat = NoGoat
  fmap f (OneGoat a) = OneGoat (f a)
  fmap f (MoreGoats a b c) = MoreGoats (fmap f a) (fmap f b) (fmap f c)

data TalkToMe a = Halt | Print String a | Read (String -> a)
