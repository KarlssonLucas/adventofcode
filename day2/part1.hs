import Data.List.Split

main :: IO ()
main = do
    inputs <- readFile "input"
    let rows = [words x | x <- lines inputs]
        rowsOpt = [(splitOn "-" (head x)) ++ [take 1 (head (tail x))] ++ [last x]| x <- rows]
        lower = [ x | x <- rowsOpt, (numTimesFound (toChar (x !! 2)) (toCharList (x !! 3))) < toInteger (read (x !! 1) + 1 :: Int)]
        higher = [x | x <- lower, numTimesFound (toChar (x !! 2)) (toCharList (x !! 3)) > toInteger (read (x !! 0) - 1 :: Int)]
        in print (length higher) 

numTimesFound :: Ord a => a -> [a] -> Integer
numTimesFound _ [] = 0
numTimesFound x list = sum $ map (\a -> 1) $ filter (== x) list

toCharList :: String -> [Char]
toCharList s = s

toChar :: [Char] -> Char
toChar [s] = s

