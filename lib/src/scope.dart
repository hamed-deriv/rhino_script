import 'runtime_value.dart';

class Scope {
  Scope({this.parent});

  final Scope? parent;
  final Map<String, RuntimeValue> values = <String, RuntimeValue>{};

  RuntimeValue define(String name, RuntimeValue value) {
    if (values.containsKey(name)) {
      throw Exception('Variable ($name) is already defined.');
    }

    return values[name] = value;
  }

  RuntimeValue assign(String name, RuntimeValue value) =>
      _resolve(name).values[name] = value;

  RuntimeValue get(String name) => _resolve(name).values[name]!;

  Scope _resolve(String name) {
    if (values.containsKey(name)) {
      return this;
    }

    if (parent != null) {
      return parent!._resolve(name);
    }

    throw Exception('Cannot resolve variable ($name).');
  }
}
