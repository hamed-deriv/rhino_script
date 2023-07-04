import 'enums.dart';
import 'helpers.dart';
import 'keywords.dart';
import 'token.dart';

class Lexer {
  static List<Token> tokenize(String sourceCode) {
    final List<Token> tokens = <Token>[];
    final Iterable<String> sections =
        sourceCode.split(' ').map((String item) => item.trim());

    for (final String section in sections) {
      switch (section) {
        case '(':
          tokens.add(Token(section, TokenType.openParenthesis));
          break;
        case ')':
          tokens.add(Token(section, TokenType.closeParenthesis));
          break;
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
          tokens.add(Token(section, TokenType.binaryOperator));
          break;
        case '=':
          tokens.add(Token(section, TokenType.equals));
          break;
        case '~':
          tokens.add(Token(section, TokenType.endOfFile));
          break;

        default:
          if (isNumber(section)) {
            tokens.add(Token(section, TokenType.number));
          } else if (isAlpha(section)) {
            if (keywords.contains(section)) {
              tokens.add(Token(section, TokenType.keyword));
            } else {
              tokens.add(Token(section, TokenType.identifier));
            }
          } else {
            tokens.add(Token(section, TokenType.unknown));
          }
      }
    }

    return tokens;
  }
}
