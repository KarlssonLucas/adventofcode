tdata = [199,200,208,210,200,207,240,269,260,263] :: [Int]

test = [5, 10, 15] :: [Int]
main = do
	filecontent <- readFile "input"
	let a = [read x | x <- words filecontent] 
	putStrLn $ show $ parse a

parse :: [Int] -> Int
parse (i:[]) = 0
parse (i:is) | i < (head is) = 1 + parse is
			 | otherwise = 0 + parse is