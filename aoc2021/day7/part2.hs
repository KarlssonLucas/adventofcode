import Data.List.Split
import Data.List

main = do
    filecontent <- readFile "test"
    let a = (Prelude.map (read :: String -> Int) (splitOn "," filecontent))
    print $ sum [distanceTo (minimum [average a - 1, average a + 1]) x | x <- a ] 
        where average a = (sum a) `div` (length a)

distanceTo :: Int -> Int -> Int 
distanceTo h h1 = sum [1..(abs $ h-h1)]
