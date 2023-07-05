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

List<String> getTokenizable(String sourceCode) {
  final List<String> tokenizable = <String>[];
  final List<String> delimiters = <String>[
    ' ',
    '\n',
    '\t',
    '(',
    ')',
    '+',
    '-',
    '*',
    '/',
    '%',
    '=',
  ];

  String buffer = '';

  for (final String char in sourceCode.split('')) {
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

  return tokenizable.where((String token) => token.trim().isNotEmpty).toList();
}
