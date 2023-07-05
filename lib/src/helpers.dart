import 'dart:convert';

bool isIntegerNumber(String value) => RegExp(r'^[0-9]+$').hasMatch(value);

bool isDecimalNumber(String value) =>
    RegExp(r'^[0-9]+[.][0-9]+$').hasMatch(value);

bool isNumber(String value) => isIntegerNumber(value) || isDecimalNumber(value);

bool isBoolean(String value) => RegExp(r'^(true|false)$').hasMatch(value);

bool isAlpha(String value) => RegExp(r'^[a-zA-Z]+$').hasMatch(value);

bool isMathOperator(String value) => RegExp(r'^[-+*/%]+$').hasMatch(value);

bool isAdditiveOperator(String value) => RegExp(r'^[-+]$').hasMatch(value);

bool isMultiplicativeOperator(String value) =>
    RegExp(r'^[*%/]$').hasMatch(value);

String formatJson(Map<String, dynamic> statement) =>
    const JsonEncoder.withIndent('  ').convert(statement);

Iterable<String> getTokenizable(String input) {
  final List<String> delimiters = '\t\r\n ()+-*/%=[]{}'.split('');
  final List<String> parts = input.split('');
  final List<String> tokenizable = <String>[];

  String buffer = '';

  for (final String char in parts) {
    if (delimiters.contains(char)) {
      if (buffer.isNotEmpty) {
        tokenizable.add(buffer);
        buffer = '';
      }

      tokenizable.add(char);
    } else {
      buffer += char;
    }
  }

  if (buffer.isNotEmpty) {
    tokenizable.add(buffer);
  }

  return tokenizable.where((String token) => token.trim().isNotEmpty);
}
