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
