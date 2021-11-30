import Data.List.Split

main :: IO ()
main = do
    input <- readFile "input"
    let wd = [toPair (words x) | x <- (splitOn "\n\n" input)]
    let ls = [ x | x <- wd, acceptedPassports x]
    putStrLn $ show $ length ls

toPair []     = []
toPair (s:ss) = a ++ (toPair ss)
                    where a = splitOn ":" s

acceptedPassports :: [String] -> Bool
acceptedPassports []     = False 
acceptedPassports list 
  | length [s | s <- ["ecl","pid","hcl","eyr","hgt","iyr","byr"], s `elem` list] >= 7 = True
  | otherwise = False
