module Types where

import qualified Data.Text as T

joinStr x ys = T.unpack $ T.intercalate (T.pack x) (map T.pack ys)
listToArgs :: (Show s) => [s] -> String
listToArgs = (("("++) . (++")")) . (joinStr ", ") . (map show)

data Program = Program [Pipeline]
instance Show Program where
  show (Program xs) = joinStr " . " $ (map show xs)

data Pipeline = Pipeline [PipelineVal]
instance Show Pipeline where
  show (Pipeline (fn:args)) = (show fn) ++ (listToArgs args)

data PipelineVal = Atom' String
                 | List' [PipelineVal]
                 | Number' Integer
                 | String' String
                 | Bool' Bool
instance Show PipelineVal where
  show (List' (fn:args)) = (show fn) ++ (listToArgs args)
  show (Atom' a) = a
  show (String' a) = show a
  show (Number' a) = show a
  show (Bool' True) = "true"
  show (Bool' False) = "false"

data LispVal = Atom String
             | List [LispVal]
             | Number Integer
             | String String
             | Bool Bool

