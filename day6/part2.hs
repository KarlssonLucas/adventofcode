import Data.List.Split
import Data.Set hiding (map, filter)

main :: IO ()
main = do
    inputs <- readFile "input"
    let input = [lines x | x <- splitOn "\n\n" inputs]
    print $ sum $ map fun $ input


