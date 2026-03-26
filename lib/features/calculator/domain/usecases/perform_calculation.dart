import '../repositories/calculator_repository.dart';

class PerformCalculation {
  final CalculatorRepository repository;

  PerformCalculation(this.repository);

  Future<String> execute(String expression) {
    return repository.calculate(expression);
  }
}
