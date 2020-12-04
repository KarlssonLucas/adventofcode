import Data.List

main = do 
  x <- readFile "input"
  putStr$show$g$lines x

g :: [String] -> Int
g x = product [f (n,1) n x|n <- [1,3,5,7]]*(f (1,2) 1 x)

f :: (Int,Int) -> Int -> [String] -> Int
f (i,j) x (a:[]) = if a !! (mod x 31) == '#' then 1 else 0
f (i,1) x (a:(b:cs)) = if b !! (mod x 31) == '#' then 1+ f (i,1) (x+i) (b:cs) else f (i,1) (x+i) (b:cs)
f (i,2) x (a:(b:(c:ds))) = if c !! (mod x 31) == '#' then 1 + f (i,2) (x+i) (c:ds) else f (i,2) (x+i) (c:ds)
