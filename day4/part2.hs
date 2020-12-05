import Data.List.Split
import Data.Char

main :: IO ()
main = do
    input <- readFile "input"
    let wd = [toPair (words x) | x <- (splitOn "\n\n" input)]
    let ls = [ x | x <- wd, acceptedPassports x]
    let ts = [ x | x <- ls, validPass x]
    putStrLn $ show $ length ts

toPair :: [String] -> [(String, String)]
toPair []     = []
toPair (s:ss) = [(list !! 0, list !! 1)] ++ toPair ss
   where list = splitOn ":" s

acceptedPassports :: [(String, String)] -> Bool
acceptedPassports []     = False 
acceptedPassports list 
  | length [s | s <- ["ecl","pid","hcl","eyr","hgt","iyr","byr"], l <- list, (fst l) == s] >= 7 = True
  | otherwise = False

validPass :: [(String, String)] -> Bool
validPass []     = True
validPass (s:ss) = validPair s && validPass ss

validPair :: (String, String) -> Bool
validPair ("byr", yr) = length yr == 4 && ryr >= 1920 && ryr <= 2002
    where ryr = read yr

validPair ("iyr", isy) = length isy == 4 && risy >= 2010 && risy <= 2020
    where risy = read isy

validPair ("eyr", ex) = length ex == 4 && rex >= 2020 && rex <= 2030
    where rex = read ex

validPair ("hgt", hg) = (afx == "in" && lng >= 59 && lng <= 76) || (afx == "cm" && lng >= 150 && lng <= 193)
    where afx = reverse $ take 2 $ reverse hg
          lng = read $ reverse $ drop 2 $ reverse hg

validPair ("hcl", hc) = head hc == '#' && length hc == 7 && (and [isLetterAf c | c <- drop 2 hc])
    where isLetterAf c = c `elem` ['a', 'b', 'c', 'd', 'e', 'f', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

validPair ("ecl", ec) = ec `elem` ["amb", "blu", "brn","gry", "grn", "hzl", "oth"]
validPair ("pid", p) = length p == 9 && and [isNumber x | x <- p]
validPair _ = True
