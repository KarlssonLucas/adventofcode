import Data.List.Split
import Data.Set hiding (filter, map)

main :: IO ()
main = do
    inputs <- readFile "input"
    let clusters = [filter (not . (`elem` "\n")) x | x <- (splitOn "\n\n" inputs)]
    putStrLn $ show $ sum $ map size $ map fromList $ clusters
