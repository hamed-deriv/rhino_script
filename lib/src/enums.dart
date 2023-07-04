enum TokenType {
  number,
  string,
  identifier,
  nullable,
  unaryOperator,
  binaryOperator,
  ternaryOperator,
  equals,
  openParenthesis,
  closeParenthesis,
  keyword,
  comment,
  unknown,
  endOfFile,
}

enum NodeType {
  program,
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
