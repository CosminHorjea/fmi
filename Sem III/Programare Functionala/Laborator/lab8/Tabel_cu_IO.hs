

centre :: Int -> String -> String
centre w s  =  replicate h ' ' ++ s ++ replicate (w-n-h) ' '
            where
            n = length s
            h = (w - n) `div` 2

dash :: String -> String
dash s  =  replicate (length s) '-'

fort :: Bool -> String
fort False  =  "F"
fort True   =  "T"


-- Prelude> unlines ["Hello", "World", "!"]
-- "Hello\nWorld\n!\n"
-- Prelude> zipWith (+) [1, 2, 3] [4, 5, 6]
-- [5,7,9]
-- Prelude> unwords ["Lorem", "ipsum", "dolor"]
-- "Lorem ipsum dolor"


showTable :: [[String]] -> IO ()
showTable tab  =  putStrLn (
  unlines [ unwords (zipWith centre widths row) | row <- tab ] )
    where
      widths  = map length (head tab)
      
-- Prelude> import Data.List
-- Prelude Data.List> nub [1,2,3,4,3,2,1,2,4,3,5]
-- [1,2,3,4,5]

table p = tables [p]

tables :: [Prop] -> IO ()
tables ps  =
  let xs = nub (concatMap names ps) in
    showTable (
      [ xs            ++ ["|"] ++ [showProp p | p <- ps]           ] ++
      [ dashvars xs   ++ ["|"] ++ [dash (showProp p) | p <- ps ]   ] ++
      [ evalvars e xs ++ ["|"] ++ [fort (eval e p) | p <- ps ] | e <- envs xs]
    )
    where  dashvars xs        =  [ dash x | x <- xs ]
           evalvars e xs      =  [ fort (eval e (Var x)) | x <- xs ]

 