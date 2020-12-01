main = do
    filecontent <- readFile "file.txt"
    let a = [read x | x <- (words filecontent)]
    putStrLn $ show $ head [x*y | x <- (a), y <- (a), x+y == 2020]
