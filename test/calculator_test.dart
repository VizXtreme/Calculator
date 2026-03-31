import 'package:flutter_test/flutter_test.dart';
import 'package:calculator_app/features/calculator/domain/usecases/calculate_usecase.dart';
import 'package:calculator_app/features/calculator/domain/repositories/calculator_repository.dart';
import 'package:calculator_app/features/calculator/data/repositories/calculator_repository_impl.dart';
import 'package:dartz/dartz.dart';

void main() {
  late CalculateUseCase useCase;
  late CalculatorRepository repository;

  setUp(() {
    repository = CalculatorRepositoryImpl();
    useCase = CalculateUseCase(repository);
  });

  group('CalculateUseCase', () {
    test('should add two numbers correctly', () {
      final result = useCase(a: 5, b: 3, operation: '+');
      expect(result, const Right(8.0));
    });

    test('should subtract two numbers correctly', () {
      final result = useCase(a: 10, b: 4, operation: '-');
      expect(result, const Right(6.0));
    });

    test('should multiply two numbers correctly', () {
      final result = useCase(a: 6, b: 7, operation: '*');
      expect(result, const Right(42.0));
    });

    test('should divide two numbers correctly', () {
      final result = useCase(a: 20, b: 4, operation: '/');
      expect(result, const Right(5.0));
    });

    test('should return error when dividing by zero', () {
      final result = useCase(a: 10, b: 0, operation: '/');
      expect(result.isLeft(), true);
    });
  });
}
