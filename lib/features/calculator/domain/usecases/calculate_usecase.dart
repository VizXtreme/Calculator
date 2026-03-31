import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/calculator_repository.dart';

class CalculateUseCase {
  final CalculatorRepository repository;

  CalculateUseCase(this.repository);

  Either<Failure, double> call({
    required double a,
    required double b,
    required String operation,
  }) {
    try {
      if (operation == '/' && b == 0) {
        return const Left(DivisionByZeroFailure());
      }

      final result = repository.calculate(a, b, operation);
      
      if (result.isInfinite || result.isNaN) {
        return const Left(OverflowFailure());
      }

      return Right(result);
    } catch (e) {
      return Left(CalculationFailure(e.toString()));
    }
  }
}
