import Data.List.Split 
import Data.Char
import Data.Set hiding (filter, map, take, drop)

main :: IO ()
main = do
    inputs <- readFile "input"
    let list1 = init [((((take 2 (words x) !! 0) ++ (take 2 (words x) !! 1)), parse' $ (splitOn "bags contain" x) !! 1)) | x <- lines inputs]
    putStrLn $ show $ subBags "shinygold" list1

parse' :: String -> [String]
parse' str = removeNo $ map concat $ map init $ map words $ splitOn "," str

removeNo :: [String] ->  [String]
removeNo ("noother":_) = []
removeNo s             = s

getChildren :: String -> [(String, [String])]-> [String]
getChildren [] _ = []
getChildren name bags = getChild name bags

getChild :: String -> [(String, [String])] -> [String]
getChild _ []     = []
getChild s (t:ts) | s == fst t = snd t
                  | otherwise = getChild s ts

subBags :: String -> [(String, [String])] -> Int
subBags s allBags = sum $ [digitToInt $ head x | x <- (getChildren s allBags)] ++ [subBags (tail x) allBags | x <- getChildren s allBags, _ <- [1..(digitToInt $ head x)]]

