import Data.List.Split

main :: IO ()
main = do
    s <- readFile "input"
    let parsedList = [(splitOn " " x !! 0, splitOn " " x !! 1) | x <- lines s]
    let ppl = [(x, p) | (x,y) <- parsedList, let p | head y == '-' = -1 * read (tail y) :: Int
                                                  | otherwise     =  1 * read (tail y) :: Int]
    print $ [findLoop (replaceElem ppl random "nop") [] [] 0 0 | random <- [0..600], (fst (ppl !! random)) == "jmp"]


replaceElem :: [(String, Int)] -> Int -> String -> [(String, Int)]
replaceElem operations index op = (take index operations) ++ [(op, (snd (operations !! index)))] ++ (drop (index+1) operations)

findLoop :: [(String,Int)] -> [Int] -> [Int] -> Int -> Int -> Int
findLoop operations alreadyDone oldVar index var 
  | index >= 632 = var
-- | length operations == length alreadyDone
  | index `elem` alreadyDone = 0
  | fst (operations !! index) == "acc" = findLoop operations (alreadyDone ++ [index]) (oldVar ++ [var]) (index + 1) (var + (snd (operations !! index)))
  | fst (operations !! index) == "jmp" = findLoop operations (alreadyDone ++ [index]) (oldVar ++ [var]) (index + (snd (operations !! index))) var
  | fst (operations !! index) == "nop" = findLoop operations (alreadyDone ++ [index]) (oldVar ++ [var]) (index + 1) var


