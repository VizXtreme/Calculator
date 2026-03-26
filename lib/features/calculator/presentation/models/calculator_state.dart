class CalculatorState {
  final String expression;
  final String result;
  final bool isLoading;
  final bool isResultShown;

  CalculatorState({
    required this.expression,
    required this.result,
    required this.isLoading,
    this.isResultShown = false,
  });

  factory CalculatorState.initial() => CalculatorState(
        expression: '',
        result: '0',
        isLoading: false,
      );

  CalculatorState copyWith({
    String? expression,
    String? result,
    bool? isLoading,
    bool? isResultShown,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      isResultShown: isResultShown ?? this.isResultShown,
    );
  }
}
