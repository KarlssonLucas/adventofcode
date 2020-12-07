import Data.List.Split 
import Data.Char
import Data.Set hiding (filter, map, take, drop)

testString = [["mutedyellow"],["2 shiny gold bags", "9 faded blue bags"]]

main :: IO ()
main = do
    inputs <- readFile "input"
    let list = init [(((take 2 (words x) !! 0) ++ (take 2 (words x) !! 1)), parse' $ (splitOn "bags contain" x) !! 1) | x <- splitOn "\n" inputs]
    putStrLn $ show $ length $ toList $ fromList $ getAllGold [] list

parse' :: String -> [String]
parse' str = map tail $ map concat $ map init $ map words $ splitOn "," str

getChildren :: String -> [(String, [String])]-> [String]
getChildren [] _ = []
getChildren name bags = getChild name bags

getChild :: String -> [(String, [String])] -> [String]
getChild _ []     = []
getChild s (t:ts) | s == fst t = snd t
                  | otherwise = getChild s ts

getAllGold :: [String] -> [(String, [String])] -> [String]
getAllGold alreadyBeen allBags = concat [getGold alreadyBeen allBags x | x <- allBags] 

getGold :: [String] -> [(String, [String])] -> (String, [String]) -> [String]
getGold alreadyBeenBags allBags (parent, children) | children == [] = []
                                                   | "shinygold" `elem` children = (parent:alreadyBeenBags)
                                                   | otherwise = concat [getGold (parent:alreadyBeenBags) allBags (x, getChildren x allBags) | x <- children]

