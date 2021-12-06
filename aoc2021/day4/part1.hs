import Data.List.Split
import Data.List

test = [[[("7",True),("42",True),("22",True),("92",True),("60",False)],[("8",False),("88",True),("99",True),("13",True),("12",True)]], [[("7",False),("42",True),("22",True),("92",True),("60",False)],[("8",False),("88",True),("99",True),("13",True),("12",True)]]]

main = do
    filecontent <- readFile "test"
    let a = splitOn "," (head $ lines filecontent)
    let b = [ map words x | x <- (tail $ map lines (splitOn "\n\n" (filecontent)))]
    print $ run a [map prep x | x <- b]

prep :: [String] -> [(String, Bool)]
prep []     = []
prep (s:ss) = (s, False):(prep ss) 

run :: [String] -> [[[(String, Bool)]]] -> ([[[(String, Bool)]]], String)
run (s:ss) list | (length $ checkOK list)+1 == length list = getLast list (checkOK list) s
                | otherwise = run ss (update s list)

getLast :: [[[(String, Bool)]]] -> [[[(String, Bool)]]] -> String -> ([[[(String, Bool)]]], String)
getLast old new s = ([ o | o <- old, not (o `elem` new) ], s)

checkOK :: [[[(String, Bool)]]] -> [[[(String, Bool)]]]
checkOK [] = []
checkOK (l:ls) | checkBingo l = (l):(checkOK ls)
               | checkBingo (transpose l) = (l):(checkOK ls)
               | otherwise = checkOK ls

checkBingo :: [[(String, Bool)]] -> Bool
checkBingo [] = False
checkBingo (l:ls) = (length [x | x <- l, snd x] == 5) || checkBingo ls

update :: String -> [[[(String, Bool)]]] -> [[[(String, Bool)]]] 
update _ [] = []
update s (l:ls) = (updateBingo s l):(update s ls)

updateBingo :: String -> [[(String, Bool)]] -> [[(String, Bool)]]
updateBingo _ [] = []
updateBingo s (l:ls) = [if fst x == s then (fst x, True) else x | x <- l]:(updateBingo s ls)
