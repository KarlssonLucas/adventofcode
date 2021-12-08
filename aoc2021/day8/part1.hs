main = do
    filecontent <- readFile "input"
    let a = map (drop 11) [ words x | x <- (lines filecontent)]
    print $ count1478 $ concat a

count1478 :: [String] -> Int
count1478 [] = 0
count1478 (c:cs) | (length c) `elem` [2,4,3,7] = 1 + (count1478 cs)
                 | otherwise = count1478 cs

