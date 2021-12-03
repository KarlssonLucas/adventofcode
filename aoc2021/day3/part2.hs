import Data.Char(digitToInt)

b = ["11110", "10110", "10111", "10101", "11100", "10000", "11001"]

main = do
    filecontent <- readFile "input"
    let a = [x | x <- words filecontent]
    putStrLn $ show $ bintodec(read (run' (leastCommon [map repl x | x <- a]) a 0) :: Int) * bintodec(read (run (mostCommon [map repl x | x <- a]) a 0) :: Int)
    
run :: [Int] -> [String] -> Int -> String
run _ [] _ = ""
run _ (l:[]) _ = l
run cs ls n = run (mostCommon [map repl x | x <- new]) new (n+1)
    where new = func ls n cs

run' :: [Int] -> [String] -> Int -> String
run' _ [] _ = ""
run' _ (l:[]) _ = l
run' cs ls n = run' (leastCommon [map repl x | x <- new]) new (n+1)
    where new = func ls n cs

func :: [String] -> Int -> [Int] -> [String]
func [] _ _ = []
func (l:ls) n c | (digitToInt (l !! n)) == (c !! n) = l:(func ls n c)
                | otherwise = func ls n c

repl :: Char -> Int
repl '0' = -1
repl '1' = 1

mostCommon :: [[Int]] -> [Int]
mostCommon ls = map bin (foldl1 (zipWith (+)) ls)
    where bin n | n<0 = 0
                | n>=0 = 1

leastCommon :: [[Int]] -> [Int]
leastCommon ls = map bin (foldl1 (zipWith (+)) ls)
    where bin n | n>=0 = 0
                | n<0 = 1

bintodec :: Integral i => i -> i
bintodec 0 = 0
bintodec i = 2 * bintodec (div i 10) + (mod i 10)