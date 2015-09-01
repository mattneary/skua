module Parser (parsePipeline) where

import Text.ParserCombinators.Parsec
import Control.Monad

import Types

symbol :: Parser Char
symbol = oneOf "!#$%&*+-:<=>?^_~@"

parsePipeline = endBy parseExpr spaces

parseExpr :: Parser LispVal
parseExpr = parseAtom
        <|> parseRegex
        <|> parseString
        <|> parseNumber
        <|> parseSExpr

parseAtom :: Parser LispVal
parseAtom =
  do first <- letter <|> symbol
     rest <- many (letter <|> digit <|> symbol)
     let atom = first:rest
     return $ case atom of
			 "#t" -> Bool True
			 "#f" -> Bool False
			 _    -> Atom atom

parseString :: Parser LispVal
parseString =
  do char '"'
     x <- many (noneOf "\"")
     char '"'
     return $ String x

parseRegex :: Parser LispVal
parseRegex =
  do char '/'
     x <- many (noneOf "/")
     char '/'
     return $ List [List [(Atom "constructN"), (Number 1), (Atom "RegExp")], String x]

parseNumber :: Parser LispVal
parseNumber = liftM (Number . read) $ many1 digit

parseSExpr =
  do char '('
     x <- parseList
     char ')'
     return x

parseList :: Parser LispVal
parseList = liftM List $ sepBy parseExpr spaces

