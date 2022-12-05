module Main (main) where

import AlwaysSucceeds qualified
import Data.Default
import Plutarch (compile)

main :: IO ()
main = do
  case compile def AlwaysSucceeds.validator of
    Left x -> error $ show x
    Right script -> putStrLn $ show script
