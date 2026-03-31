import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class CalculatorRepository {
  double calculate(double a, double b, String operation);
}
