import Data.List.Split

main :: IO ()
main = do
    s <- readFile "input"
    let parsedList = [(splitOn " " x !! 0, splitOn " " x !! 1) | x <- lines s]
    let ppl = [(x, p) | (x,y) <- parsedList, let p | head y == '-' = -1 * read (tail y) :: Int
                                                   | otherwise     = read (tail y) :: Int]
    print $ findLoop ppl [] [] 0 0

findLoop :: [(String,Int)] -> [Int] -> [Int] -> Int -> Int -> Int
findLoop operations alreadyDone oldVar index var 
  | index `elem` alreadyDone = var
  | fst (operations !! index) == "acc" = findLoop operations (alreadyDone ++ [index]) (oldVar ++ [var]) (index + 1) (var + (snd (operations !! index)))
  | fst (operations !! index) == "jmp" = findLoop operations (alreadyDone ++ [index]) (oldVar ++ [var]) (index + (snd (operations !! index))) var
  | fst (operations !! index) == "nop" = findLoop operations (alreadyDone ++ [index]) (oldVar ++ [var]) (index + 1) var

