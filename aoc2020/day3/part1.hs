main :: IO ()
main = do
    inputs <- readFile "input"
    let rows = [ x | x <- lines inputs]
    putStrLn $ show $ (traverse' 0 0 rows)

traverse' :: Int -> Int -> [String] -> Int
traverse' _ n []       =  n
traverse' col n (l:ls) | l !! col == '#' = traverse' ((col+3) `mod` (length l)) (n+1) ls
                       | otherwise = traverse' ((col+3) `mod` (length l)) n (ls) 

                

