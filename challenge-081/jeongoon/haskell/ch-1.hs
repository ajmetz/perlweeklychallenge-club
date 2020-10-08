import System.Environment
import System.Exit
import Data.List (intercalate)

--commonDivisors :: (Integral a) => [a] -> [a]
commonDivisors [] = []
commonDivisors xs = filter (\cd -> all ((==0).(flip rem) cd) xs) [1..(gcd')]
  where gcd' = foldr1 (\acc x -> gcd acc x) xs

--isRepeated :: [Char] -> [Char] -> Bool
isRepeated a inStr = ((foldr1 (++).replicate count) a) == inStr where
  lenStr = length inStr
  lenA   = length a
  count  = lenStr `div` lenA

commonBaseStrings :: [String] -> [String]
commonBaseStrings []  = []
commonBaseStrings [a] = [a]
commonBaseStrings strls =
  filter (\cbs' -> (all (cbs' `isRepeated`) strls)) cbsls
  where
    strA = strls !! 0
    cbsls = (map ((flip take) strA).commonDivisors.map length) strls

main = do
  strs <- getArgs
  if length strs  < 2
    then die $ "usage: runhaskell ch-1.hs <string> <string>"
    else putStrLn $ ((intercalate " ").commonBaseStrings) strs
