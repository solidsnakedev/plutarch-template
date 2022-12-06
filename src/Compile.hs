module Compile where

import Plutarch
import qualified Data.Default (def)
import qualified AlwaysSucceeds(validator)

compileTest = compile def validator