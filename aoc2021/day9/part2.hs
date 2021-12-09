import Data.List.Split
import Data.Char

main = do
    filecontent <- readFile "test"
    let a = words filecontent
    print $ (func a)

func :: [String] -> [[(Int, Int)]]
func ls = helper ls [(r, c) | r <- [0..((length ls) - 1)], c <- [0..((length (ls !! 0))-1)], and $ basin ls r c]

helper :: [String] -> [(Int, Int)] -> [[(Int, Int)]]
helper ls [] = []
helper ls ((r1,c1):ns) = (getBasin ls (r1,c1)):(helper ls ns)

getBasin :: [String] -> (Int, Int) -> [(Int, Int)]
getBasin ls (r, c) = [ (r1, c1) | (r1, c1) <- [(r+1, c), (r-1, c), (r, c+1), (r, c-1)], legitPos ls (r1, c1) && (digitToInt (ls !! (r1) !! c1)) == (digitToInt (ls !! r !! c) + 1) ]

basin :: [String] -> Int -> Int -> [Bool]
basin ls r c = [ (ls !! r !! c) < (ls !! r1 !! c1) | (r1, c1) <- [(r+1, c), (r-1, c), (r, c+1), (r, c-1)], legitPos ls (r1,c1)]

legitPos :: [String] -> (Int, Int) -> Bool
legitPos ls (r,c) | r >= length ls || r < 0 = False
                  | c >= length (ls !! 0) ||c < 0 = False  
                  | otherwise = True
