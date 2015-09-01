module Translator (translate) where

import Types

translate :: [LispVal] -> Maybe Program
translate ((List xs):exps) =
  do xs' <- mapM translate' xs
     Program rest <- translate exps
     return . Program $ (Pipeline xs'):rest
translate [] = return $ Program []
translate _ = Nothing

translate' :: LispVal -> Maybe PipelineVal
translate' (List xs) =
  do xs' <- mapM translate' xs
     return $ List' xs'
translate' (Atom xs) = return $ Atom' xs
translate' (String xs) = return $ String' xs
translate' (Number xs) = return $ Number' xs
translate' (Bool xs) = return $ Bool' xs

