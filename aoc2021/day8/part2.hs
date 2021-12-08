import Data.List

main = do
    filecontent <- readFile "input"
    let a = [ words x | x <- (lines filecontent)]
    print $ findNumber a
    print $ sum $ map digs (findNumber a)

digs :: [Int] -> Int
digs [x,y,z,w] = x*1000+y*100+z*10+w

findNumber :: [[String]] -> [[Int]]
findNumber []     = []
findNumber (c:cs) = (findRow c):(findNumber cs)

findRow :: [String] -> [Int]
findRow s = (func (drop 11 s) (sortByLenOrLex' $ parse (take 10 s)))

parse :: [String] -> [String]
parse [] = []
parse (s:ss) | length s == 2 = s:(parse ss) 
        | length s == 3 = s:(parse ss)
        | length s == 4 = s:(parse ss)
        | length s == 7 = s:(parse ss)
        | otherwise = parse ss

sortByLenOrLex' :: [String] -> [String]
sortByLenOrLex' as = fst <$> sortBy cmp (addLen <$> as) where
  cmp (a,n) (b,m) | n > m     = GT
                  | n < m     = LT
                  | otherwise = compare a b
  addLen x = (x, length x)

func :: [String] -> [String] -> [Int]
func [] _ = []
func (n:ns) list 
  | length n == 6 && length (n \\ one) == 4 && length (n \\ four) == 3 && length (eight \\ n) == 1 && length (n \\ seven) == 3 = (0:(func ns list))
            | length n == 5 && length (intersect n one) == 2 = (3:(func ns list))
            | length n == 5 && length (intersect n four) == 2 = (2:(func ns list))
            | length n == 5 && length (intersect n four) == 3 = (5:(func ns list))
            | length n == 6 && length (intersect n one) == 2 = (9:(func ns list))
            | length n == 6 && length (intersect n one) == 1 = (6:(func ns list))
            | length n == 2 = (1:(func ns list))
            | length n == 3 = (7:(func ns list))
            | length n == 4 = (4:(func ns list))
            | length n == 7 = (8:(func ns list))
            | otherwise = ((func ns list))
    where one = list !! 0
          seven = list !! 1
          four = list !! 2
          eight = list !! 3





-- 3 = 3 \ 1 && length == 5 = length 2
-- 5 = (5 \ 4) && length == 5 = length 3
-- 2 = (4 \ 2) && length == 5 = length 2
--
-- 9 = (9 \ 7) && length == 6 = length 3
-- 6 = (9\7) && length == 6 = length 2
