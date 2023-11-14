module Main (main) where

import AlwaysSucceeds qualified

import Cardano.Binary qualified as CBOR
import Data.Aeson (KeyValue ((.=)), object)
import Data.Aeson.Encode.Pretty (encodePretty)
import Data.Bifunctor (
    first,
 )
import Data.ByteString.Base16 qualified as Base16
import Data.ByteString.Lazy qualified as LBS
import Data.Text (
    Text,
    pack,
 )
import Data.Text.Encoding qualified as Text
import Plutarch (
    Config (Config),
    TracingMode (DoTracing),
    compile,
 )
import Plutarch.Evaluate (
    evalScript,
 )
import Plutarch.Prelude
import Plutarch.Script (Script, serialiseScript)
import PlutusLedgerApi.V2 (
    Data,
    ExBudget,
 )
import System.Directory (createDirectoryIfMissing, doesDirectoryExist)
import "liqwid-plutarch-extra" Plutarch.Extra.Script (
    applyArguments,
 )

encodeSerialiseCBOR :: Script -> Text
encodeSerialiseCBOR = Text.decodeUtf8 . Base16.encode . CBOR.serialize' . serialiseScript

evalT :: ClosedTerm a -> Either Text (Script, ExBudget, [Text])
evalT x = evalWithArgsT x []

evalWithArgsT :: ClosedTerm a -> [Data] -> Either Text (Script, ExBudget, [Text])
evalWithArgsT x args = do
    cmp <- compile (Config DoTracing) x
    let (escr, budg, trc) = evalScript $ applyArguments cmp args
    scr <- first (pack . show) escr
    pure (scr, budg, trc)

writePlutusScript :: String -> FilePath -> ClosedTerm a -> IO ()
writePlutusScript title filepath term = do
    case evalT term of
        Left e -> putStrLn (show e)
        Right (script, _, _) -> do
            let
                scriptType = "PlutusScriptV2" :: String
                plutusJson = object ["type" .= scriptType, "description" .= title, "cborHex" .= encodeSerialiseCBOR script]
                content = encodePretty plutusJson
            LBS.writeFile filepath content

main :: IO ()
main = do
    exist <- doesDirectoryExist "compiled"
    createDirectoryIfMissing exist "compiled"
    writePlutusScript "AlwaysSucceeds" "./compiled/AlwaysSucceeds.json" AlwaysSucceeds.validator
