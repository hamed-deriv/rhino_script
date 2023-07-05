import 'abstract_syntax_tree.dart';
import 'enums.dart';
import 'helpers.dart';
import 'lexer.dart';
import 'token.dart';

class Parser {
  final List<Token> _tokens = <Token>[];

  Program produceAST(String sourceCode) {
    final Program program = Program();

    _tokens.addAll(Lexer.tokenize(sourceCode));

    while (_getCurrentToken().type != TokenType.endOfFile) {
      program.statements.add(_parseStatement());
    }

    return program;
  }

  Statement _parseStatement() {
    switch (_getCurrentToken().type) {
      case TokenType.variable:
      case TokenType.constant:
        return _parseVariableDeclaration();

      default:
        return _parseExpression();
    }
  }

  Expression _parseExpression() => _parseAdditiveExpression();

  Expression _parseAdditiveExpression() {
    Expression left = _parseMultiplicativeExpression();

    while (isAdditiveOperator(_getCurrentToken().value)) {
      final Token operator = _consume();
      final Expression right = _parseMultiplicativeExpression();

      left = BinaryExpression(operator, left, right);
    }

    return left;
  }

  Expression _parseMultiplicativeExpression() {
    Expression left = _parsePrimaryExpression();

    while (isMultiplicativeOperator(_getCurrentToken().value)) {
      final Token operator = _consume();
      final Expression right = _parsePrimaryExpression();

      left = BinaryExpression(operator, left, right);
    }

    return left;
  }

  Expression _parsePrimaryExpression() {
    final TokenType tokenType = _getCurrentToken().type;

    switch (tokenType) {
      case TokenType.identifier:
        return Identifier(_consume());
      case TokenType.nullable:
        return NullLiteral(_consume());
      case TokenType.number:
        return NumericLiteral(_consume());
      case TokenType.openParenthesis:
        _consume();
        final Expression expression = _parseExpression();
        _consume(expectedType: TokenType.closeParenthesis);
        return expression;

      default:
        throw Exception(
          '$runtimeType unexpected token: ${_getCurrentToken().toJson()}.',
        );
    }
  }

  Statement _parseVariableDeclaration() {
    final Token keyword = _consume();
    final bool isConst = keyword.type == TokenType.constant;
    final Identifier identifier =
        Identifier(_consume(expectedType: TokenType.identifier));

    Expression? value;

    if (_getCurrentToken().type == TokenType.equals) {
      _consume();
      value = _parseExpression();
    }

    return VariableDeclaration(identifier, value, isConst);
  }

  Token _getCurrentToken() =>
      _tokens.isEmpty ? Token('', TokenType.endOfFile) : _tokens.first;

  Token _consume({TokenType? expectedType}) {
    final Token token = _tokens.removeAt(0);

    if (expectedType != null && token.type != expectedType) {
      throw Exception(
        '$runtimeType unexpected token: ${token.type} expected: $expectedType.',
      );
    }

    return token;
  }
}
