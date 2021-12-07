import Data.List.Split
import Data.List

main = do
    filecontent <- readFile "input"
    let a = (Prelude.map (read :: String -> Int) (splitOn "," filecontent))
    print $ sum $ map abs $ zipWith (-) (cycle [sort a !! (length a `div` 2)]) a

