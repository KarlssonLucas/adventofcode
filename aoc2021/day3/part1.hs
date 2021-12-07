main = do
    filecontent <- readFile "input"
    let a = [map repl x | x <- words filecontent]
    putStrLn $ show $ (bintodec $ fromDigits $ map bin (foldl1 (zipWith (+)) a)) * (bintodec $ fromDigits $ invert $ map bin (foldl1 (zipWith (+)) a))
        where bin n | n<0  = 0
                    | n>=0 = 1 
              repl '0' = -1
              repl '1' = 1

invert :: [Int] -> [Int]
invert [] = []
invert (n:ns) | n==0 = 1:(invert ns)
              | n==1 = 0:(invert ns)

fromDigits = foldl addDigit 0
   where addDigit num d = 10*num + d

bintodec :: Integral i => i -> i
bintodec 0 = 0
bintodec i = 2 * bintodec (div i 10) + (mod i 10)
