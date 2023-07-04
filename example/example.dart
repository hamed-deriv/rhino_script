import 'dart:io';

import 'package:rhino_script/src/abstract_syntax_tree.dart';
import 'package:rhino_script/src/interpreter.dart';
import 'package:rhino_script/src/parser.dart';
import 'package:rhino_script/src/runtime_value.dart';
import 'package:rhino_script/src/scope.dart';

void main(List<String> args) {
  final String sourceCode = File('example/sample.rhs').readAsStringSync();
  final Scope scope = Scope();
  final Parser parser = Parser();
  final Program program = parser.produceAST(sourceCode);

  scope.define('x', RuntimeNumber(10));

  print('Rhino Script v0.01\n');
  print('source code:\n$sourceCode\n');

  print('parser result:');
  program.statements.forEach(print);
  print('\ninterpreter result:\n${Interpreter().evaluate(program, scope)}');
}
