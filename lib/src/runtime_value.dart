import 'enums.dart';

abstract class RuntimeValue {
  const RuntimeValue(this.type);

  final RuntimeType type;

  @override
  String toString() => 'type: ${type.name}';
}

class RuntimeNull extends RuntimeValue {
  const RuntimeNull() : super(RuntimeType.nil);
}

class RuntimeNounNull extends RuntimeValue {
  const RuntimeNounNull(this.value) : super(RuntimeType.number);

  final Object value;

  @override
  String toString() => 'type: ${type.name}, value: $value';
}

class RuntimeNumber extends RuntimeNounNull {
  RuntimeNumber(num value) : super(value);
}

class RuntimeBoolean extends RuntimeNounNull {
  RuntimeBoolean(bool value) : super(value);
}

class RuntimeString extends RuntimeNounNull {
  RuntimeString(String value) : super(value);
}
