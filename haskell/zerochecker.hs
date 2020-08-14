module Main where

import qualified System.Environment
import qualified Data.ByteString.Lazy.Char8 as BL

main :: IO ()
main = do
  args <- System.Environment.getArgs
  let filename = head args
  contents <- BL.readFile filename
  let result = BL.find (/= '\NUL') contents
  if result == Nothing
    then putStrLn filename
    else return ()