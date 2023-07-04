enum TokenType {
  number,
  string,
  identifier,
  unaryOperator,
  binaryOperator,
  ternaryOperator,
  equals,
  openParenthesis,
  closeParenthesis,
  keyword,
  comment,
  unknown,
}

enum NodeType {
  program,
  numericLiteral,
  identifier,
  binaryExpression,
}
