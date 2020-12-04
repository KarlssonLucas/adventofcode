import Data.List.Split

main :: IO ()
main = do
    input <- readFile "input"
    let wd = [ (splitOn "\n" x) | x <- (splitOn "\n\n" input)]
    putStrLn $ show $ wd 



