main :: IO ()
main = do
    input <- readFile "input"
    let wd = [ x | x <- lines input]
    putStrLn $ show $ concatRows wd

concatRows :: [String] -> [String]
concatRows []                 = []
concatRows (l:ls) | l == []   = "" ++ (concatRows ls)
                  | otherwise = l ++ (concatRows ls)

checkOcc :: [String] -> Bool
checkOcc []     = True
checkOcc (l:ls) | l == "" = checkOcc ls

