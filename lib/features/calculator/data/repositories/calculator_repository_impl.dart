import 'package:math_expressions/math_expressions.dart';
import '../../domain/entities/calculation_result.dart';
import '../../domain/repositories/calculator_repository.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  @override
  Future<String> calculate(String expression) async {
    try {
      if (expression.isEmpty) return '0';
      
      // Clean up expression (replace symbols if needed)
      String cleanExpression = expression.replaceAll('×', '*').replaceAll('÷', '/').replaceAll('−', '-');
      
      Parser p = Parser();
      Expression exp = p.parse(cleanExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      
      // Handle integer result
      if (eval == eval.toInt().toDouble()) {
        return eval.toInt().toString();
      }
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Future<List<CalculationResult>> getHistory() async {
    // In-memory history for now as per minimal demo
    return [];
  }

  @override
  Future<void> saveResult(CalculationResult result) async {
    // Logic to save
  }
}
