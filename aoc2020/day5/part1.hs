main :: IO ()
main = do
    inputs <- readFile "input"
    let ls = [ (toRowCol line) | line <- lines inputs]
    let finish = [ (fst x) * 8 + (snd x) | x <- ls]
    putStrLn $ show $ maximum finish

toRowCol :: String -> (Int, Int)
toRowCol s = ((binSearch 0 127 (take 7 s)), (binSearch 0 7 (drop 7 s)))

binSearch :: Int -> Int -> [Char] -> Int 
binSearch _ hi [] = hi
binSearch lo hi (s:ss) 
                   | ss == [] && (s == 'F' || s == 'L')  = lo
                   | ss == [] && (s == 'B' || s == 'R')   = hi
                   | s == 'F' || s == 'L'  = binSearch lo ((hi+lo) `div` 2) ss
                   | s == 'B' || s == 'R'  = binSearch ((hi+lo) `div` 2 + 1) hi ss
                   | otherwise = 0
