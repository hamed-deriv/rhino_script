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

  Expression _parseExpression() => _parseAssignmentExpression();

  Expression _parseAssignmentExpression() {
    Expression left = _parseObjectExpression();

    if (_getCurrentToken().type == TokenType.equals) {
      _consume();

      final Expression right = _parseAssignmentExpression();

      left = AssignmentExpression(left, right);
    }

    return left;
  }

  Expression _parseObjectExpression() {
    if (_getCurrentToken().type != TokenType.openBrace) {
      return _parseAdditiveExpression();
    }

    _consume();

    final List<Property> properties = <Property>[];

    while (_getCurrentToken().type != TokenType.endOfFile &&
        _getCurrentToken().type != TokenType.closeBrace) {
      final String key = _consume(expectedType: TokenType.identifier).value;

      if (_getCurrentToken().type == TokenType.comma ||
          _getCurrentToken().type == TokenType.closeBrace) {
        if (_getCurrentToken().type == TokenType.comma) {
          _consume();
        }

        properties.add(Property(key));
      } else {
        _consume(expectedType: TokenType.colon);

        final Expression value = _parseExpression();

        properties.add(Property(key, value));

        if (_getCurrentToken().type != TokenType.closeBrace) {
          _consume(expectedType: TokenType.comma);
        }
      }
    }

    _consume(expectedType: TokenType.closeBrace);

    return ObjectLiteral(properties);
  }

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
      _tokens.isEmpty ? const Token('EOF', TokenType.endOfFile) : _tokens.first;

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
