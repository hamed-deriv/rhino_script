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

  Statement _parseStatement() => _parseExpression();

  Expression _parseExpression() => _parseAdditiveExpression();

  Expression _parseAdditiveExpression() {
    Expression left = _parseMultiplicativeExpression();

    while (isAdditiveOperator(_getCurrentToken().value)) {
      final Token operator = _consume();
      final Expression right = _parseMultiplicativeExpression();

      left = BinaryExpression(left, right, operator);
    }

    return left;
  }

  Expression _parseMultiplicativeExpression() {
    Expression left = _parsePrimaryExpression();

    while (isMultiplicativeOperator(_getCurrentToken().value)) {
      final Token operator = _consume();
      final Expression right = _parsePrimaryExpression();

      left = BinaryExpression(left, right, operator);
    }

    return left;
  }

  Expression _parsePrimaryExpression() {
    final TokenType operatorType = _getCurrentToken().type;

    switch (operatorType) {
      case TokenType.identifier:
        return Identifier(_consume());
      case TokenType.number:
        return NumericLiteral(_consume());

      default:
        throw Exception(
          '$runtimeType unexpected token: ${_getCurrentToken()}.',
        );
    }
  }

  Token _getCurrentToken() => _tokens.first;

  Token _consume() => _tokens.removeAt(0);
}
