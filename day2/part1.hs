import Data.List.Split

main :: IO ()
main = do
    inputs <- readFile "input"
    let rows = [words x | x <- lines inputs]
    let rowsOpt = [(splitOn "-" (head x)) ++ [take 1 (head (tail x))] ++ [last x]| x <- rows]
    let done = [ x | x <- rowsOpt, (numTimesFound (toChar (x !! 2)) (toCharList (x !! 3))) < toInteger (read (x !! 1) + 1 :: Int)]
    let done2 = [x | x <- done, numTimesFound (toChar (x !! 2)) (toCharList (x !! 3)) > toInteger (read (x !! 0) - 1 :: Int)]
    print (length done2) 

numTimesFound :: Ord a => a -> [a] -> Integer
numTimesFound _ [] = 0
numTimesFound x list = sum $ map (\a -> 1) $ filter (== x) list

toCharList :: String -> [Char]
toCharList s = s

toChar :: [Char] -> Char
toChar [s] = s
