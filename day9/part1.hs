import Data.Set hiding (drop, take)

main :: IO ()
main = do
    s <- readFile "input"
    let ls = parseList [p | x <- lines s, let p = read x :: Int]
    let ps = [ y | (x,y) <- ls, x1 <- x, x2 <- x, y == (x1+x2)]
    putStrLn $ show $ [x | (y,x) <- ls, x `notElem` ps]

parseList :: [Int] -> [([Int],Int)]
parseList list   
  | length list < 20 = []
  | otherwise = [(take 25 list, (last (take 26 list)))] ++ parseList (drop 1 list)
