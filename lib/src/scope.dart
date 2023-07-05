import 'runtime_value.dart';

class Scope {
  Scope({this.parent});

  final Scope? parent;
  final Map<String, RuntimeValue> _values = <String, RuntimeValue>{};
  final Set<String> _constants = <String>{};

  RuntimeValue define(
    String name,
    RuntimeValue value, {
    bool isConstant = false,
  }) {
    if (_values.containsKey(name)) {
      throw Exception('Variable ($name) is already defined.');
    }

    if (isConstant) {
      _constants.add(name);
    }

    return _values[name] = value;
  }

  RuntimeValue assign(String name, RuntimeValue value) {
    if (_constants.contains(name)) {
      throw Exception('Cannot reassign constant ($name).');
    }

    return _resolve(name)._values[name] = value;
  }

  RuntimeValue get(String name) => _resolve(name)._values[name]!;

  Scope _resolve(String name) {
    if (_values.containsKey(name)) {
      return this;
    }

    if (parent != null) {
      return parent!._resolve(name);
    }

    throw Exception('Cannot resolve variable ($name).');
  }
}
