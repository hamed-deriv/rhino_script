import 'enums.dart';
import 'token.dart';

abstract class Statement {
  Statement(this.nodeType);

  final NodeType nodeType;
}

abstract class Expression extends Statement {
  Expression(NodeType nodeType) : super(nodeType);
}

class Program extends Statement {
  Program() : super(NodeType.program);

  final List<Statement> statements = <Statement>[];
}

class Identifier extends Expression {
  Identifier(this.token) : super(NodeType.identifier);

  final Token token;
}

class NumericLiteral extends Expression {
  NumericLiteral(this.token) : super(NodeType.numericLiteral);

  final Token token;
}

class NullLiteral extends Expression {
  NullLiteral(this.token) : super(NodeType.nullLiteral);

  final Token token;
}

class BinaryExpression extends Expression {
  BinaryExpression(this.left, this.right, this.operator)
      : super(NodeType.binaryExpression);

  final Expression left;
  final Expression right;
  final Token operator;
}
