import 'enums.dart';
import 'token.dart';

abstract class Statement {
  Statement(this.nodeType);

  final NodeType nodeType;

  @override
  String toString() => <String, dynamic>{'nodeType': nodeType.name}.toString();
}

abstract class Expression extends Statement {
  Expression(this.token, NodeType nodeType) : super(nodeType);

  final Token token;

  @override
  String toString() => <String, dynamic>{
        'token': '$token',
        'nodeType': nodeType.name,
      }.toString();
}

class Program extends Statement {
  Program() : super(NodeType.program);

  final List<Statement> statements = <Statement>[];
}

class Identifier extends Expression {
  Identifier(Token token) : super(token, NodeType.identifier);
}

class NumericLiteral extends Expression {
  NumericLiteral(Token token) : super(token, NodeType.numericLiteral);
}

class NullLiteral extends Expression {
  NullLiteral(Token token) : super(token, NodeType.nullLiteral);
}

class BinaryExpression extends Expression {
  BinaryExpression(Token operator, this.left, this.right)
      : super(operator, NodeType.binaryExpression);

  final Expression left;
  final Expression right;

  @override
  String toString() => <String, dynamic>{
        'operator': '$token',
        'left': '$left',
        'right': '$right',
        'nodeType': nodeType.name,
      }.toString();
}
