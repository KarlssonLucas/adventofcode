main = do
    filecontent <- readFile "input"
    let a = func [x | x <- words filecontent]
    putStrLn $ show $ (count "down" a - count "up" a) * (count "forward" a)

count :: Eq a => a -> [a] -> Int
count x ls = length $ filter (==x) ls

func :: [String] -> [String]
func []       = []
func (l:s:ls) = replicate (read s :: Int) l ++ func ls