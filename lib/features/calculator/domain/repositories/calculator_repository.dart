import '../entities/calculation_result.dart';

abstract class CalculatorRepository {
  Future<String> calculate(String expression);
  Future<List<CalculationResult>> getHistory();
  Future<void> saveResult(CalculationResult result);
}
