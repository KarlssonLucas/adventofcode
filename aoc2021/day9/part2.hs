import Data.List.Split
import Data.Char
import Data.List
import Data.HashMap as HM hiding (map)

type Point = (Int, Int)

main = do
    filecontent <- readFile "input"
    let a = parse $ words filecontent
    print $ product $ take 3 $ reverse $ sort $ map length $ func (doWork a) [(r, c) | r <- [0..((length a) - 1)], c <- [0..((length (a !! 0))-1)], and $ getRoots a r c] 

func :: [(Point, Point)] -> [Point] -> [[Point]]
func ls [] = []
func ls (p:ps) = [ point | (point,root) <- ls, root == p]:(func ls ps)

doWork :: [[Int]] -> [(Point, Point)]
doWork ls = [((r,c), travelToRoot ls (r,c)) | r <- [0..((length ls) - 1)], c <- [0..((length (ls !! 0))-1)], (ls !! r !! c) /= 9]

travelToRoot :: [[Int]] -> Point -> Point
travelToRoot ls (r, c) | and $ getRoots ls r c = (r,c)
                       | otherwise = (travelToRoot ls (head [(r1,c1) | (r1,c1) <- [(r+1, c), (r-1, c), (r, c+1), (r, c-1)], legitPos ls (r1,c1) && (ls !! r !! c) > (ls !! r1 !! c1) && (ls !! r1 !! c1) /= 9]))

getRoots :: [[Int]] -> Int -> Int -> [Bool]
getRoots ls r c = [ (ls !! r !! c) < (ls !! r1 !! c1) | (r1, c1) <- [(r+1, c), (r-1, c), (r, c+1), (r, c-1)], legitPos ls (r1,c1)]

legitPos :: [[Int]] -> Point -> Bool
legitPos ls (r,c) | r >= length ls || r < 0 = False
                  | c >= length (ls !! 0) ||c < 0 = False  
                  | otherwise = True

parse :: [String] -> [[Int]]
parse []     = []
parse (s:ss) = (map digitToInt s):(parse ss)

