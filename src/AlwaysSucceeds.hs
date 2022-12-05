module AlwaysSucceeds (validator) where

import Plutarch.Prelude
import Plutarch.Api.V1.Contexts
import Plutarch.Api.V1.Scripts


validator :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
validator = plam $ \_ _ _ -> pconstant ()