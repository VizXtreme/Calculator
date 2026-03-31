import 'package:equatable/equatable.dart';

enum Operation { add, subtract, multiply, divide, equals, clear, percent, negate }

class CalculatorEntity extends Equatable {
  final String displayValue;
  final String expression;
  final bool hasError;

  const CalculatorEntity({
    this.displayValue = '0',
    this.expression = '',
    this.hasError = false,
  });

  CalculatorEntity copyWith({
    String? displayValue,
    String? expression,
    bool? hasError,
  }) {
    return CalculatorEntity(
      displayValue: displayValue ?? this.displayValue,
      expression: expression ?? this.expression,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object> get props => [displayValue, expression, hasError];
}
