import 'abstract_syntax_tree.dart';
import 'enums.dart';
import 'runtime_value.dart';

class Interpreter {
  RuntimeValue evaluate(Statement node) {
    switch (node.nodeType) {
      case NodeType.program:
        return _evaluateProgram(node as Program);
      case NodeType.nullLiteral:
        return const RuntimeNull();
      case NodeType.numericLiteral:
        return RuntimeNumber(num.parse((node as NumericLiteral).token.value));
      case NodeType.binaryExpression:
        return _evaluateBinaryExpression(node as BinaryExpression);

      default:
        throw Exception('Unknown node type: ${node.nodeType.name}.');
    }
  }

  RuntimeValue _evaluateProgram(Program node) {
    RuntimeValue result = const RuntimeNull();

    for (final Statement statement in node.statements) {
      result = evaluate(statement);
    }

    return result;
  }

  RuntimeValue _evaluateBinaryExpression(BinaryExpression node) {
    final RuntimeValue left = evaluate(node.left);
    final RuntimeValue right = evaluate(node.right);

    if (left.type == RuntimeType.number && right.type == RuntimeType.number) {
      final num leftNumber = (left as RuntimeNumber).value as num;
      final num rightNumber = (right as RuntimeNumber).value as num;

      return _evalNumericExpression(
        node.operator.value,
        leftNumber,
        rightNumber,
      );
    } else {
      return const RuntimeNull();
    }
  }

  RuntimeValue _evalNumericExpression(String operator, num left, num right) {
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
          throw Exception('Division by zero.');
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
}
