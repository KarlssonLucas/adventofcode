main = do
    filecontent <- readFile "input"
    let a = [read x :: Int | x <- words filecontent] 
    putStrLn $ show $ func a 
        where func (i:is) | is == [] = 0
                          | i < head is = 1 + func is
                          | otherwise = 0 + func is

