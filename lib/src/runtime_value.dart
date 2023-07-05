import 'enums.dart';

abstract class RuntimeValue {
  const RuntimeValue(this.value, this.type);

  final Object? value;
  final RuntimeType type;

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'value': value, 'runtimeType': type.name};
}

class RuntimeNull extends RuntimeValue {
  const RuntimeNull() : super(null, RuntimeType.nil);
}

class RuntimeNumber extends RuntimeValue {
  const RuntimeNumber([num value = 0]) : super(value, RuntimeType.number);
}

class RuntimeBoolean extends RuntimeValue {
  const RuntimeBoolean([bool value = false])
      : super(value, RuntimeType.boolean);
}

class RuntimeString extends RuntimeValue {
  const RuntimeString([String value = '']) : super(value, RuntimeType.string);
}
