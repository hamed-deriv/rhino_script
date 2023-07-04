import 'dart:io';

import 'package:rhino_script/src/lexer.dart';
import 'package:rhino_script/src/token.dart';

void main(List<String> args) {
  final String sourceCode = File('example/sample.rhs').readAsStringSync();

  final List<Token> tokens = Lexer.tokenize(sourceCode);

  print('source code:\n$sourceCode');
  print('tokens:');
  tokens.forEach(print);
}
