tdata = [199,200,208,210,200,207,240,269,260,263] :: [Int]

test = [5, 10, 15] :: [Int]
main = do
	filecontent <- readFile "input"
	let a = [read x | x <- words filecontent] 
	putStrLn $ show $ count $ parse a

parse :: [Int] -> [Int]
parse (l:i:s:[]) = [(l + i + s)]
parse (l:i:s:ls) = (l + i + s):(parse (i:s:ls))

count :: [Int] -> Int
count (i:[]) = 0
count (i:is) | i < (head is) = 1 + count is
			 | otherwise = 0 + count is