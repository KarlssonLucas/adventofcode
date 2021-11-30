main :: IO ()
main = do
    inputs <- readFile "input"
    let rows = [ x | x <- lines inputs]
    putStrLn $ show $ product [traverse' c 0 0 rows | c <- [1,3,5,7]] * (travDub 1 0 0 rows)

traverse' :: Int -> Int -> Int -> [String] -> Int
traverse' _ _ n [] = n
traverse' c col n (l:ls) | l !! col == '#' = traverse' c ((col+c) `mod` (length l)) (n+1) ls
                         | otherwise = traverse' c ((col+c) `mod` (length l)) n ls

travDub :: Int -> Int -> Int -> [String] -> Int
travDub c col n (l:ls)
                    | ls == [] = n
                    | l !! col == '#' = travDub c ((col+c) `mod`(length l)) (n+1) (tail ls)
                    | otherwise = travDub c ((col+c) `mod`(length l)) n (tail ls)
