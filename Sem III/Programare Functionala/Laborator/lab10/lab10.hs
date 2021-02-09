import Test.QuickCheck
import Test.QuickCheck.Gen

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c = (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity a = (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity a = (a <> mempty) == a

-- Exercițiul 1 - Trivial

data Trivial = Trivial
  deriving (Eq, Show)

instance Semigroup Trivial where
  _ <> _ = Trivial

instance Monoid Trivial where
  mempty = Trivial
  mappend = (<>)

instance Arbitrary Trivial where
  arbitrary = return Trivial

type TrivAssoc = Trivial -> Trivial -> Trivial -> Bool

type TrivId = Trivial -> Bool

-- >    quickCheck (semigroupAssoc :: TrivAssoc)
-- >    quickCheck (monoidLeftIdentity :: TrivId)
-- >    quickCheck (monoidRightIdentity :: TrivId)

-- Exercițiul 2 - Conjuncții

newtype BoolConj = BoolConj Bool
  deriving (Eq, Show)

instance Semigroup BoolConj where
  BoolConj a <> BoolConj b = BoolConj (a && b)

instance Monoid BoolConj where
  mempty = BoolConj True

boolConjGen :: Gen BoolConj
boolConjGen = elements [BoolConj False, BoolConj True]

instance Arbitrary BoolConj where
  arbitrary = boolConjGen

-- arbitrary = MkGen (\s i -> BoolConj ((unGen arbitrary) s i))

--      MkGen ( \s i -> BoolConj  (f s i))
--                     where
--                       f = unGen (arbitrary :: Gen Bool)

type BoolConjAssoc = BoolConj -> BoolConj -> BoolConj -> Bool

type BoolConjId = BoolConj -> Bool

-- >    quickCheck (semigroupAssoc :: BoolConjAssoc)
-- >    quickCheck (monoidLeftIdentity :: BoolConjId)
-- >    quickCheck (monoidRightIdentity :: BoolConjId)

-- Exercițiul 3 - Disjuncții

newtype BoolDisj = BoolDisj Bool
  deriving (Eq, Show)

instance Semigroup BoolDisj where
  (BoolDisj False) <> (BoolDisj False) = BoolDisj False
  (BoolDisj False) <> (BoolDisj _) = BoolDisj True
  (BoolDisj True) <> (BoolDisj _) = BoolDisj True

instance Monoid BoolDisj where
  mempty = BoolDisj True
  mappend = (<>)

boolDisjGen :: Gen BoolDisj
boolDisjGen =
  elements [BoolDisj False, BoolDisj True]

instance Arbitrary BoolDisj where
  arbitrary = boolDisjGen

type BoolDisjAssoc = BoolDisj -> BoolDisj -> BoolDisj -> Bool

type BoolDisjId = BoolDisj -> Bool

-- >    quickCheck (semigroupAssoc :: BoolDisjAssoc)
-- >    quickCheck (monoidLeftIdentity :: BoolDisjId)
-- >    quickCheck (monoidRightIdentity :: BoolDisjId)

-- Exercițiul 4 - Identity

newtype Identity a = Identity a
  deriving (Eq, Show)

instance Semigroup a => Semigroup (Identity a) where
  (Identity a) <> (Identity b) = Identity (a <> b)

-- instance Monoid a => Monoid (Identity a) where

identityGen :: Arbitrary a => Gen (Identity a)
identityGen = do
  a <- arbitrary
  return (Identity a)

instance Arbitrary a => Arbitrary (Identity a) where
  arbitrary = identityGen

type IdentityAssoc a = Identity a -> Identity a -> Identity a -> Bool

type IdentityId a = Identity a -> Bool

-- >  quickCheck (semigroupAssoc :: IdentityAssoc String)
-- >  quickCheck (monoidLeftIdentity :: IdentityId [Int])
-- >  quickCheck (monoidRightIdentity :: IdentityId [Int])

-- Exercițiul 5 - Pereche

data Two a b = Two a b
  deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
  Two x y <> Two z t = Two (x <> z) (y <> t)

instance (Monoid a, Monoid b) => Monoid (Two a b) where
  mempty = Two mempty mempty
  mappend = (<>)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  -- arbitrary = MkGen (\s i -> Two ((unGen (arbitrary)) s i) ((unGen (arbitrary)) s i))
  arbitrary = twoGen

twoGen :: (Arbitrary a, Arbitrary b) => Gen (Two a b)
twoGen = do
  a <- arbitrary
  b <- arbitrary
  return (Two a b)

type TwoAssoc a b = Two a b -> Two a b -> Two a b -> Bool

type TwoId a b = Two a b -> Bool

-- >    quickCheck (semigroupAssoc :: TwoAssoc String [Int])
-- >    quickCheck (monoidLeftIdentity :: TwoId [Int] String)
-- >    quickCheck (monoidRightIdentity :: TwoId [Int] [Int])

-- Exercițiul 6 - Alternative

data Or a b = Fst a | Snd b
  deriving (Eq, Show)

instance Semigroup (Or a b) where
  Snd a <> _ = Snd a
  Fst _ <> Snd a = Snd a
  Fst a <> _ = Fst a

orGen :: (Arbitrary a, Arbitrary b) => Gen (Or a b)
orGen = do
  a <- arbitrary
  b <- arbitrary
  elements [Fst a, Snd b]

instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
  --  arbitrary = oneof [undefined, undefined]
  arbitrary = orGen

type OrAssoc a b = Or a b -> Or a b -> Or a b -> Bool

-- >    quickCheck (semigroupAssoc :: OrAssoc String Int)
-- >    quickCheck (semigroupAssoc :: OrAssoc String [Int])
