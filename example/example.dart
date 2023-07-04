import 'dart:io';

import 'package:rhino_script/src/abstract_syntax_tree.dart';
import 'package:rhino_script/src/parser.dart';

void main(List<String> args) {
  final String sourceCode = File('example/sample.rhs').readAsStringSync();

  final Parser parser = Parser();

  print('Rhino Script v0.01\n');
  print('source code:\n$sourceCode\n');

  final Program result = parser.produceAST(sourceCode);
  print('parser result:');
  result.statements.forEach(print);
}
