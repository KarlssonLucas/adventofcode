import Data.List.Split
import Data.List
import Data.HashMap as HM hiding (map)

type Cord = (Int, Int)
type Line = (Cord, Cord)

main = do
    filecontent <- readFile "input"
    let b = map (splitOn " -> ") (lines filecontent);
    let a = parse (map (splitOn " -> ") (lines filecontent))
    print $ length $ HM.filter(>1) $ inserts $ concat $ map (\(c1, c2) -> line c1 c2) a
        where inserts []     = HM.empty
              inserts (l:ls) = HM.insertWith (\v1 v2 -> v1 + v2) l 1 (inserts ls)

parse :: [[String]] -> [Line]
parse [] = []
parse (l:ls) = (parseLine l):(parse ls)

parseLine :: [String] -> Line
parseLine (f:s:[]) = ((read (c1 !! 0) :: Int, read (c1 !! 1) :: Int),(read (c2 !! 0) :: Int, read (c2 !! 1) :: Int)) 
    where c1 = splitOn "," f
          c2 = splitOn "," s

line :: Cord -> Cord -> [Cord]
line pa@(xa,ya) pb@(xb,yb) = map maySwitch . unfoldr go $ (x1,y1,0)
  where
    steep = abs (yb - ya) > abs (xb - xa)
    maySwitch = if steep then (\(x,y) -> (y,x)) else id
    [(x1,y1),(x2,y2)] = sort [maySwitch pa, maySwitch pb]
    deltax = x2 - x1
    deltay = abs (y2 - y1)
    ystep = if y1 < y2 then 1 else -1
    go (xTemp, yTemp, error)
        | xTemp > x2 = Nothing
        | otherwise  = Just ((xTemp, yTemp), (xTemp + 1, newY, newError))
        where
          tempError = error + deltay
          (newY, newError) = if (2*tempError) >= deltax
                            then (yTemp+ystep,tempError-deltax)
                            else (yTemp,tempError)
