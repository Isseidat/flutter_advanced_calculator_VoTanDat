import 'package:math_expressions/math_expressions.dart';
import '../models/calculator_mode.dart';

class ExpressionParser {
  double evaluate(String expression, {AngleMode angleMode = AngleMode.degrees}) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);

      ContextModel cm = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, cm);

      return result;
    } catch (_) {
      throw Exception("Invalid Expression");
    }
  }
}
