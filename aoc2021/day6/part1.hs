import Data.List.Split
import Data.List

main = do
    filecontent <- readFile "input"
    let a = (Prelude.map (read :: String -> Int) (splitOn "," filecontent))
    print $ run a 80

run :: [Int] -> Int -> Int
run ls 0 = length ls
run ls n = run (func ls) (n-1)

func :: [Int] -> [Int]
func [] = []
func (l:ls) | l == 0    = [6,8] ++ (func ls)
            | otherwise = (l-1):(func ls)

