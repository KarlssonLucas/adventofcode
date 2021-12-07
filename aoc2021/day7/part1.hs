import Data.List.Split
import Data.List

main = do
    filecontent <- readFile "input"
    let a = (Prelude.map (read :: String -> Int) (splitOn "," filecontent))
    print $ sumItUp (cheapestDistance a) [0..(maximum a)]

cheapestDistance :: [Int] -> [(Int, Int)]
cheapestDistance ls = [cheapestFromSub x ls n | x <- ls, n <- [0..(maximum ls)] ]

cheapestFromSub :: Int ->  [Int] -> Int -> (Int, Int)
cheapestFromSub x ls n = (abs (n-x), n)

sumItUp :: [(Int, Int)] -> [Int] -> Int
sumItUp [] ns = minimum $ zipMapList ns [0..100]
sumItUp ((x, c):ls) ns = sumItUp ls (bbequals ns c (x + ns !! c))

bbequals :: [Int] -> Int -> Int -> [Int]
bbequals ls i n = take i ls ++ [n] ++ drop (i+1) ls

zipMapList :: Num a => [a] -> [a] -> [a]
zipMapList xs ys = zipWith (-) xs ys