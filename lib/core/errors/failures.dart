import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CalculationFailure extends Failure {
  const CalculationFailure(super.message);
}

class DivisionByZeroFailure extends Failure {
  const DivisionByZeroFailure() : super('Cannot divide by zero');
}

class OverflowFailure extends Failure {
  const OverflowFailure() : super('Number overflow');
}
