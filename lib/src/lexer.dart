import 'enums.dart';
import 'helpers.dart';
import 'keywords.dart';
import 'token.dart';

class Lexer {
  static List<Token> tokenize(String sourceCode) {
    final List<Token> tokens = <Token>[];
    final Iterable<String> tokenizables = getTokenizable(sourceCode);

    for (final String tokenizable in tokenizables) {
      switch (tokenizable) {
        case '(':
          tokens.add(Token(tokenizable, TokenType.openParenthesis));
          break;
        case ')':
          tokens.add(Token(tokenizable, TokenType.closeParenthesis));
          break;
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
          tokens.add(Token(tokenizable, TokenType.binaryOperator));
          break;
        case '=':
          tokens.add(Token(tokenizable, TokenType.equals));
          break;

        default:
          if (isNumber(tokenizable)) {
            tokens.add(Token(tokenizable, TokenType.number));
          } else if (isAlpha(tokenizable)) {
            if (keywords.containsKey(tokenizable)) {
              tokens.add(Token(tokenizable, keywords[tokenizable]!));
            } else {
              tokens.add(Token(tokenizable, TokenType.identifier));
            }
          } else {
            tokens.add(Token(tokenizable, TokenType.unknown));
          }
      }
    }

    return tokens;
  }
}
