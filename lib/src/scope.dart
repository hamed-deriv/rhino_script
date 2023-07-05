import 'runtime_value.dart';

class Scope {
  Scope({this.parent});

  final Scope? parent;
  final Map<String, RuntimeValue> _values = <String, RuntimeValue>{};
  final Set<String> _constants = <String>{};

  RuntimeValue get(String name) => _resolve(name)._values[name]!;

  RuntimeValue define(String name, RuntimeValue value, bool isConstant) {
    if (_isDefined(name)) {
      throw Exception('Variable ($name) is already defined.');
    }

    if (isConstant) {
      _setConstant(name);
    }

    return _set(name, value);
  }

  RuntimeValue assign(String name, RuntimeValue value) {
    if (_isConstant(name)) {
      throw Exception('Cannot reassign constant value ($name).');
    }

    return _set(name, value);
  }

  RuntimeValue _set(String name, RuntimeValue value) => _values[name] = value;

  void _setConstant(String name) => _constants.add(name);

  bool _isDefined(String name) => _values.containsKey(name);

  bool _isConstant(String name) => _constants.contains(name);

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
