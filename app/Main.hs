module Main (main) where

import AlwaysSucceeds qualified

import System.Directory (createDirectoryIfMissing, doesDirectoryExist)
import Utils (writePlutusScript)

main :: IO ()
main = do
  exist <- doesDirectoryExist "compiled"
  createDirectoryIfMissing exist "compiled"
  writePlutusScript "AlwaysSucceeds" "./compiled/AlwaysSucceeds.json" AlwaysSucceeds.validator
