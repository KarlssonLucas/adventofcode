import Data.List.Split

main :: IO ()
main = do
    inputs <- readFile "input"
    let rows = [words x | x <- lines inputs]
    let rowsOpt = [(splitOn "-" (head x)) ++ [take 1 (head (tail x))] ++ [last x]| x <- rows]
    let done = [ x | x <- rowsOpt, ((x !! 2) == [(x !! 3) !! (read (x !! 0) - 1)]) 
                       `xor` ((x !! 2) == [(x !! 3) !! (read (x !! 1) - 1)])]
    print (length done) 

xor :: Bool -> Bool -> Bool
xor a b = a /= b
