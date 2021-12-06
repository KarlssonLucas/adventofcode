import Data.List.Split
import Data.HashMap as HM 

main = do
    filecontent <- readFile "test"
    let a = populate (zip [0..] (Prelude.map (read :: String -> Int) (splitOn "," filecontent)))
    print $ run a 2

populate :: [(Int, Int)] -> HM.Map Int Int
populate ((k, v):[]) = HM.insert k v HM.empty
populate ((k, v):ls) = HM.insert k v (populate ls)

run :: HM.Map Int Int -> Int -> HM.Map Int Int
run ls 0 = ls
run ls n = run (HM.map (\v -> if v == 0 then 6 else v) (helper (length (HM.filter (==0) $ HM.map (\v -> v - 1) ls)) ls)) (n-1)
                    
helper :: Int -> HM.Map Int Int -> HM.Map Int Int
helper 1 ls = HM.insert (HM.size ls + 1) 8 (ls)
helper a ls = HM.insert (HM.size ls + a) 8 (helper (a-1) ls)