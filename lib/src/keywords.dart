import 'package:rhino_script/src/enums.dart';

Map<String, TokenType> keywords = <String, TokenType>{
  'const': TokenType.constant,
  'var': TokenType.variable,
  'null': TokenType.nullable,
};
