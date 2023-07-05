import 'abstract_syntax_tree.dart';
import 'enums.dart';
import 'runtime_value.dart';
import 'scope.dart';

class Interpreter {
  static RuntimeValue evaluate(Statement? node, Scope scope) {
    if (node == null) {
      return const RuntimeNull();
    }

    switch (node.nodeType) {
      case NodeType.program:
        return _evaluateProgram(node as Program, scope);
      case NodeType.variableDeclaration:
        return _evaluateVariableDeclaration(node as VariableDeclaration, scope);
      case NodeType.assignmentExpression:
        return _evaluateAssignmentExpression(
          node as AssignmentExpression,
          scope,
        );
      case NodeType.identifier:
        return _evaluateIdentifier(node as Identifier, scope);
      case NodeType.nullLiteral:
        return const RuntimeNull();
      case NodeType.numericLiteral:
        return RuntimeNumber(num.parse((node as NumericLiteral).token.value));
      case NodeType.binaryExpression:
        return _evaluateBinaryExpression(node as BinaryExpression, scope);

      default:
        throw Exception('Unknown node type: ${node.nodeType.name}.');
    }
  }

  static RuntimeValue _evaluateProgram(Program node, Scope scope) {
    RuntimeValue result = const RuntimeNull();

    for (final Statement statement in node.statements) {
      result = evaluate(statement, scope);
    }

    return result;
  }

  static RuntimeValue _evaluateIdentifier(Identifier node, Scope scope) =>
      scope.get(node.token.value);

  static RuntimeValue _evaluateBinaryExpression(
      BinaryExpression node, Scope scope) {
    final RuntimeValue left = evaluate(node.left, scope);
    final RuntimeValue right = evaluate(node.right, scope);

    if (left.type == RuntimeType.number && right.type == RuntimeType.number) {
      final num leftNumber = (left as RuntimeNumber).value as num;
      final num rightNumber = (right as RuntimeNumber).value as num;

      return _evalNumericExpression(
        node.token.value,
        leftNumber,
        rightNumber,
      );
    } else {
      return const RuntimeNull();
    }
  }

  static RuntimeValue _evalNumericExpression(
      String operator, num left, num right) {
    num result = 0;

    switch (operator) {
      case '+':
        result = left + right;
        break;
      case '-':
        result = left - right;
        break;
      case '*':
        result = left * right;
        break;
      case '/':
        if (right == 0) {
          throw Exception(
            'Division by zero is not allowed. {left: $left, right: $right}',
          );
        }
        result = left / right;
        break;
      case '%':
        result = left % right;
        break;

      default:
        throw Exception('Unknown operator: $operator.');
    }

    return RuntimeNumber(result);
  }

  static RuntimeValue _evaluateVariableDeclaration(
    VariableDeclaration node,
    Scope scope,
  ) {
    if (node.isConst && node.value == null) {
      throw Exception('Constant variable must have been initialized.');
    }

    return scope.define(
      node.identifier.token.value,
      evaluate(node.value, scope),
      node.isConst,
    );
  }

  static RuntimeValue _evaluateAssignmentExpression(
    AssignmentExpression node,
    Scope scope,
  ) {
    if (node.assignee.nodeType != NodeType.identifier) {
      throw Exception(
        'Assignee must be an identifier. (${node.assignee.toJson()})',
      );
    }

    return scope.assign(
      (node.assignee as Identifier).token.value,
      evaluate(node.value, scope),
    );
  }
}
