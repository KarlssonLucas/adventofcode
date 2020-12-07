import Data.List.Split 
import Data.Char

testString = [["mutedyellow"],["2 shiny gold bags", "9 faded blue bags"]]

main :: IO ()
main = do
    inputs <- readFile "input"
    let list = init [(((take 2 (words x) !! 0) ++ (take 2 (words x) !! 1)), parse' $ (splitOn "bags contain" x) !! 1) | x <- splitOn "\n" inputs]
    putStrLn $ show $ getChildren ["fadedblue", "mutedyellow"] list

parse' :: String -> [String]
parse' str = map tail $ map concat $ map init $ map words $ splitOn "," str

check :: [Char] -> [Char] -> Bool
check l s = check' l s True where
    check' _ [] h          = True
    check' [] _ h          = False
    check' (x:xs) (y:ys) h = (y == x && check' xs ys False) || (h && check' xs (y:ys) h)

getChildren :: [String] -> [(String, [String])] -> [String]
getChildren [] _ = [] 
getChildren (l:ls) allBags = (getChild l allBags) ++ getChildren ls allBags

getChild :: String -> [(String, [String])] -> [String]
getChild _ []         = []
getChild name (f:rest) | name == "shinygold" = ["shinygold"]
                       | name == (fst f) = getChildren (snd f) (f:rest)
                       | otherwise = getChild name rest

findGold :: [(String, [String])] -> [String] -> [(String, [String])] -> [String]
findGold [] shinyBags _                   = shinyBags
findGold (b:bs) shinyBags alreadyBeenBags 
  | length (getChildren (snd b) (alreadyBeenBags ++ bs)) == 0 = findGold bs (shinyBags ++ (getChildren (snd b) (alreadyBeenBags ++ bs))) (alreadyBeenBags ++ bs)
  | otherwise = findGold bs shinyBags (b:alreadyBeenBags) 
