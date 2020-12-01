main = do
    filecontent <- readFile "file.txt"
    let a = [read x | x <- (words filecontent)]
    putStrLn $ show $ head [x*y*z | x <- (a), y <- (a), z <- (a), x+y+z == 2020]
