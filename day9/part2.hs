import Data.List

main = do
    s <- readFile "input"
    let ls = [p | x <- lines s, let p = read x :: Int]
    print $ [ minimum x + maximum x | x <-  filter (not . null) . concatMap inits . tails $ ls, sum x == 177777905]
