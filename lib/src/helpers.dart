bool isNumber(String value) => RegExp(r'^[0-9]+$').hasMatch(value);

bool isAlpha(String value) => RegExp(r'^[a-zA-Z]+$').hasMatch(value);

bool isMathOperator(String value) => RegExp(r'^[-+*/%]+$').hasMatch(value);

bool isAdditiveOperator(String value) => RegExp(r'^[-+]$').hasMatch(value);

bool isMultiplicativeOperator(String value) =>
    RegExp(r'^[*%/]$').hasMatch(value);
