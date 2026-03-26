class CalculationResult {
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationResult({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  factory CalculationResult.empty() => CalculationResult(
        expression: '',
        result: '0',
        timestamp: DateTime.now(),
      );
}
