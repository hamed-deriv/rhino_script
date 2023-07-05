import 'enums.dart';

class Token {
  Token(this.value, this.type);

  final String value;
  final TokenType type;

  @override
  String toString() =>
      <String, dynamic>{'value': value, 'type': type.name}.toString();
}
