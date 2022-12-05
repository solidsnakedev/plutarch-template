module Main (main) where

import qualified AlwaysSucceeds
import Plutarch
import Data.Default

main :: IO ()
main = do
  case compile def AlwaysSucceeds.validator of
    Left x -> error $ show x
    Right script -> putStrLn $ show script
