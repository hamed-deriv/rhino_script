import 'dart:io';

import 'package:rhino_script/src/abstract_syntax_tree.dart';
import 'package:rhino_script/src/helpers.dart';
import 'package:rhino_script/src/interpreter.dart';
import 'package:rhino_script/src/parser.dart';
import 'package:rhino_script/src/scope.dart';

void main(List<String> args) {
  final String sourceCode = File('example/sample.rhs').readAsStringSync();
  final Scope scope = Scope();
  final Parser parser = Parser();
  final Program program = parser.produceAST(sourceCode);

  print('Rhino Script v0.01\n');

  print('source code:');
  print(sourceCode);

  print('parser result:');
  for (final Statement statement in program.statements) {
    print(formatJson(statement.toJson()));
  }

  print('\ninterpreter result:');
  print('${formatJson(Interpreter().evaluate(program, scope).toJson())}');
}
