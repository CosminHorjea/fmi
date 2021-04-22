import qualified Text.Parsec.Token as Token
import Text.Parsec.String ( Parser, parseFromFile )
import Text.Parsec.Expr
 ( buildExpressionParser,
 Assoc(..),
 Operator(..) )
import Text.ParserCombinators.Parsec.Language
 ( emptyDef,
 GenLanguageDef( .. ),
 LanguageDef)
import Text.Parsec ( alphaNum, letter, (<|>), eof, parse, parseTest )
import SIMPLE


impLanguageDef :: LanguageDef ()
impLanguageDef =
    emptyDef
    { commentStart = "/*"
    , commentEnd = "*/"
    , commentLine = "//"
    , nestedComments = False
    , caseSensitive = True
    , identStart = letter
    , identLetter = alphaNum
    , reservedNames =
    [ "while", "if", "else", "int", "bool"
    , "true", "false", "read", "print"
    ]
    , reservedOpNames =
    [ "+", "-", "*", "/", "%"
    , "==", "!=", "<", "<=", ">=", ">"
    , "&&", "||", "!", "="
    ]
    }
impLexer :: Token.TokenParser ()
impLexer = Token.makeTokenParser impLanguageDef

identifier :: Parser String
identifier = Token.identifier impLexer
reserved :: String -> Parser ()
reserved = Token.reserved impLexer
reservedOp :: String -> Parser ()
reservedOp = Token.reservedOp impLexer
parens :: Parser a -> Parser a
parens = Token.parens impLexer
braces :: Parser a -> Parser a
braces = Token.braces impLexer
semiSep :: Parser a -> Parser [a]
semiSep = Token.semiSep impLexer
integer :: Parser Integer
integer = Token.integer impLexer
whiteSpace :: Parser ()
whiteSpace = Token.whiteSpace impLexer

ifStmt :: Parser Stmt
ifStmt = do
  reserved "if"
  cond <- parens expression
  thenS <- statement
  reserved "else"
  elseS <- statement
  return (If cond thenS elseS)
  
whileStmt :: Parser Stmt
whileStmt = do
  reserved "while"
  cond <- parens expression
  sts <- statement
  return (While cond sts)

blockStmt :: Parser Stmt
blockStmt = do
  sts <- braces (semiSep statement)
  return (Block sts)
  
asgnStmt :: Parser Stmt
asgnStmt = do
  i <- identifier
  reservedOp "="
  e <- expression
  return (Asgn i e)  
  
declStmt :: Parser Stmt
declStmt = do
  reserved "var"
  i <- identifier
  reservedOp "="
  e <- expression
  return (Decl i e)  

statement :: Parser Stmt
statement = ifStmt <|> whileStmt  <|> asgnStmt <|> blockStmt <|> declStmt


expression :: Parser Exp
expression = buildExpressionParser operators term
  where
    operators =
      [ [ prefix "!" Not
      ]
      , [ binary "*" (BinA Mul) AssocLeft
      ]
      , [ binary "+" (BinA Add) AssocLeft
      ]
      , [ binary "==" (BinE Eq) AssocNone
      , binary "<=" (BinC Lte) AssocNone
      ]
      , [ binary "&&" (BinL And) AssocLeft
      , binary "||" (BinL Or) AssocLeft
      ]
      ]
    binary name fun = Infix ( reservedOp name >> return fun)
    prefix name fun = Prefix ( reservedOp name >> return fun)


boolT :: Parser Bool
boolT = do 
        b <- reserved "true"
        return True 
        
boolF :: Parser Bool
boolF = do 
        b <- reserved "false"
        return False 

bool = boolT <|> boolF        
        
term :: Parser Exp
term =
    parens expression
    <|> (I <$> integer)     
    <|> (B <$>  bool) 
    <|> (Id <$> identifier)
    
prog :: Parser [Stmt]
prog = do 
        sts <- semiSep statement
        return sts
