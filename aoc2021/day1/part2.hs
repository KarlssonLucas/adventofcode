main = do
    filecontent <- readFile "input"
    let a = [read x | x <- words filecontent] 
    putStrLn $ show $ count $ parse a
        where count (i:is) | is == [] = 0
                           | i < head is = 1 + count is
                           | otherwise = 0 + count is

parse :: [Int] -> [Int]
parse (l:i:s:[]) = [(l + i + s)]
parse (l:i:s:ls) = (l + i + s):(parse (i:s:ls))

