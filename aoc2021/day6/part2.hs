import Data.List.Split
import Data.List

main = do
    filecontent <- readFile "input"
    let a = (Prelude.map (read :: String -> Int) (splitOn "," filecontent))
    print $ run [count x a | x <- [0..8]] 256
        where count x = length . filter (x==)

run :: [Int] -> Int -> Int
run ls 0 = sum ls
run [a,b,c,d,e,f,g,h,i] n = run [b,c,d,e,f,g,h+a,i,a] (n-1)
