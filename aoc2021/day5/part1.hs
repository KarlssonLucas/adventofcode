import Data.List.Split
import Data.List
import Data.HashMap as HM hiding (map)

type Cord = (Int, Int)
type Line = (Cord, Cord)

main = do
    filecontent <- readFile "input"
    let b = map (splitOn " -> ") (lines filecontent);
    let a = parse (map (splitOn " -> ") (lines filecontent))
    print $ length $ HM.filter(>1) $ inserts $ concat $ map lineList (removeNotOk a)
        where inserts []     = HM.empty
              inserts (l:ls) = HM.insertWith (\v1 v2 -> v1 + v2) l 1 (inserts ls)

parse :: [[String]] -> [Line]
parse [] = []
parse (l:ls) = (parseLine l):(parse ls)

parseLine :: [String] -> Line
parseLine (f:s:[]) = ((read (c1 !! 0) :: Int, read (c1 !! 1) :: Int),(read (c2 !! 0) :: Int, read (c2 !! 1) :: Int)) 
    where c1 = splitOn "," f
          c2 = splitOn "," s

removeNotOk :: [Line] -> [Line] 
removeNotOk [] = []
removeNotOk ((cord1, cord2):ls) | fst cord1 == fst cord2 || snd cord1 == snd cord2 = (cord1, cord2):(removeNotOk ls)
                                | otherwise = removeNotOk ls

lineList :: Line -> [Cord] 
lineList (c1, c2) = [ (x,y) | x <- [(min (fst c1) (fst c2))..(max (fst c1) (fst c2))], y <- [(min (snd c1) (snd c2))..(max (snd c1) (snd c2))]]

