module Main where

import Text.ParserCombinators.Parsec

import Types
import Parser
import Translator

(~>) = flip (.)
main = getContents
   >>= parseScript
    ~> translateScript
    ~> renderScript
    ~> putStrLn

renderScript (Right (Just program)) = show program
renderScript (Right Nothing) = "Could not be translated."
renderScript (Left error) = show error

translateScript :: Either ParseError [LispVal] -> Either ParseError (Maybe Program)
translateScript (Right exp) = Right $ translate exp
translateScript (Left error) = Left error

parseScript script = parse parsePipeline "pipeline" script

