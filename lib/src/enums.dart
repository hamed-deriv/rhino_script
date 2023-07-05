enum TokenType {
  identifier,
  number,
  string,

  nullable,
  constant,
  variable,

  unaryOperator,
  binaryOperator,
  ternaryOperator,
  equals,
  comma,
  colon,
  openParenthesis,
  closeParenthesis,
  openBrace,
  closeBrace,

  comment,
  endOfFile,
  unknown,
}

enum NodeType {
  program,

  identifier,
  variableDeclaration,

  property,

  assignmentExpression,
  numericLiteral,
  booleanLiteral,
  stringLiteral,
  objectLiteral,
  nullLiteral,

  binaryExpression,
}

enum RuntimeType {
  nil,
  number,
  string,
  boolean,
}
