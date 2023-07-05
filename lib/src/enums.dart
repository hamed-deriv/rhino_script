enum TokenType {
  number,
  string,
  identifier,
  nullable,
  constant,
  variable,
  unaryOperator,
  binaryOperator,
  ternaryOperator,
  equals,
  openParenthesis,
  closeParenthesis,
  comment,
  unknown,
  endOfFile,
}

enum NodeType {
  program,
  variableDeclaration,
  numericLiteral,
  nullLiteral,
  identifier,
  binaryExpression,
}

enum RuntimeType {
  nil,
  number,
  string,
  boolean,
}
