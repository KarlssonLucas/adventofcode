import Data.List.Split
import Data.Char

main = do
    filecontent <- readFile "input"
    let a = words filecontent
    print $ sum $ map (\x -> x+1) (func a) 

func :: [String] -> [Int]
func ls = [ digitToInt (ls !! r !! c) | r <- [0..((length ls) - 1)], c <- [0..((length (ls !! 0))-1)], and $ lowPoint ls r c]

lowPoint :: [String] -> Int -> Int -> [Bool]
lowPoint ls r c = [ (ls !! r !! c) < (ls !! r1 !! c1) | (r1, c1) <- [(r+1, c), (r-1, c), (r, c+1), (r, c-1)], legitPos ls (r1,c1)]

legitPos :: [String] -> (Int, Int) -> Bool
legitPos ls (r,c) | r >= length ls || r < 0 = False
                  | c >= length (ls !! 0) ||c < 0 = False  
                  | otherwise = True
