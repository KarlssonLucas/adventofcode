main = do
    filecontent <- readFile "input"
    let a = [x | x <- words filecontent]
    putStrLn $ show $ oper a (0,0,0)

oper :: [String] -> (Int, Int, Int) -> Int
oper [] (x,y,z) = y * z
oper (l:s:ls) (aim,hor,dep) | l == "forward" = oper ls (aim, hor+(read s :: Int), dep + ((read s :: Int) * aim))
                              | l == "down"    = oper ls (aim+(read s :: Int), hor, dep) 
                              | l == "up"      = oper ls (aim-(read s :: Int), hor, dep)