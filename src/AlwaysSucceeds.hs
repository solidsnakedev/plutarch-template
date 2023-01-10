module AlwaysSucceeds (validator) where

import Plutarch.Prelude
import Plutarch.Api.V2 (
  PValidator,
 )

validator :: ClosedTerm PValidator
validator = plam $ \_ _ _ -> popaque $ pconstant True
