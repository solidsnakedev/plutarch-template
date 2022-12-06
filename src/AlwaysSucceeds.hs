module AlwaysSucceeds (validator) where

-- import Plutarch.Api.V1.Contexts
-- import Plutarch.Api.V1.Scripts
import Plutarch.Api.V1 (PValidator)
import Plutarch.Prelude

-- validator :: Term s (PAsData PDatum :--> PAsData PRedeemer :--> PAsData PScriptContext :--> PUnit)
-- validator = plam $ \_ _ _ -> pconstant ()
validator :: ClosedTerm PValidator
validator = plam $ \_ _ _ -> popaque $ pconstant True
