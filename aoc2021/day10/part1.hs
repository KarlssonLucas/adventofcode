import Data.Maybe
import Data.List

data Stack a = Stack [a] deriving Show

empty :: Stack a
empty = Stack []

push :: a -> Stack a -> Stack a
push x (Stack xs)= Stack (x:xs)

pop :: Stack a -> (Maybe a, Stack a)
pop (Stack []) = (Nothing, Stack [])
pop (Stack (x:xs)) = (Just x, Stack xs)

------

opening = "{[(<"
closing = "}])>"

test = "(())<><]"

main = do
    filecontent <- readFile "input"
    let a = words filecontent
    print $ calculatSum $ filter (/='.') [func x (empty) | x <- a]

func :: String -> Stack Char -> Char
func [] st     = '.'
func (s:ss) st | s `elem` opening = func ss (push s st)
               | s `elem` closing && fromJust (fst (pop st)) /= (opening !! (fromJust $ elemIndex s closing)) = s
               | otherwise = func ss (snd (pop st))

calculatSum :: String -> Int
calculatSum [] = 0
calculatSum (s:ss) = ([1197, 57, 3, 25137] !! (fromJust $ elemIndex s closing)) + (calculatSum ss)