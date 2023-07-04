import 'enums.dart';

abstract class RuntimeValue {
  const RuntimeValue(this.value, this.type);

  final Object? value;

  final RuntimeType type;

  @override
  String toString() => 'type: ${type.name}, value: $value';
}

class RuntimeNull extends RuntimeValue {
  const RuntimeNull() : super(null, RuntimeType.nil);
}

class RuntimeNumber extends RuntimeValue {
  RuntimeNumber(num value) : super(value, RuntimeType.number);
}

class RuntimeBoolean extends RuntimeValue {
  RuntimeBoolean(bool value) : super(value, RuntimeType.boolean);
}

class RuntimeString extends RuntimeValue {
  RuntimeString(String value) : super(value, RuntimeType.string);
}
