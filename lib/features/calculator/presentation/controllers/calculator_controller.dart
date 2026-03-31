import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/calculator_entity.dart';
import '../../data/repositories/calculator_repository_impl.dart';
import '../../domain/usecases/calculate_usecase.dart';

final calculatorRepositoryProvider = Provider<CalculatorRepositoryImpl>(
  (ref) => CalculatorRepositoryImpl(),
);

final calculateUseCaseProvider = Provider<CalculateUseCase>(
  (ref) => CalculateUseCase(ref.watch(calculatorRepositoryProvider)),
);

class CalculatorController extends Notifier<CalculatorEntity> {
  String _firstOperand = '';
  String _secondOperand = '';
  String _currentOperation = '';
  bool _shouldResetDisplay = false;

  @override
  CalculatorEntity build() {
    return const CalculatorEntity();
  }

  void onDigitPressed(String digit) {
    if (_shouldResetDisplay) {
      _firstOperand = digit;
      _shouldResetDisplay = false;
    } else {
      if (_currentOperation.isEmpty) {
        _firstOperand = _firstOperand == '0' ? digit : _firstOperand + digit;
      } else {
        _secondOperand = _secondOperand == '0' ? digit : _secondOperand + digit;
      }
    }
    _updateDisplay();
  }

  void onOperationPressed(String operation) {
    if (_firstOperand.isNotEmpty && _secondOperand.isNotEmpty) {
      _calculateResult();
    }
    _currentOperation = operation;
    _shouldResetDisplay = true;
    _updateDisplay();
  }

  void onEqualsPressed() {
    if (_firstOperand.isNotEmpty && _secondOperand.isNotEmpty && _currentOperation.isNotEmpty) {
      _calculateResult();
    }
  }

  void onClearPressed() {
    _firstOperand = '';
    _secondOperand = '';
    _currentOperation = '';
    _shouldResetDisplay = false;
    state = const CalculatorEntity();
  }

  void onPercentPressed() {
    if (_firstOperand.isNotEmpty) {
      final value = double.tryParse(_firstOperand) ?? 0;
      final result = value / 100;
      _firstOperand = _formatResult(result);
      _updateDisplay();
    }
  }

  void onNegatePressed() {
    if (_firstOperand.isNotEmpty && _currentOperation.isEmpty) {
      final value = double.tryParse(_firstOperand) ?? 0;
      final result = -value;
      _firstOperand = _formatResult(result);
      _updateDisplay();
    }
  }

  void onDecimalPressed() {
    if (_shouldResetDisplay) {
      _firstOperand = '0.';
      _shouldResetDisplay = false;
    } else if (_currentOperation.isEmpty) {
      if (!_firstOperand.contains('.')) {
        _firstOperand = _firstOperand.isEmpty ? '0.' : '$_firstOperand.';
      }
    } else {
      if (!_secondOperand.contains('.')) {
        _secondOperand = _secondOperand.isEmpty ? '0.' : '$_secondOperand.';
      }
    }
    _updateDisplay();
  }

  void _calculateResult() {
    final useCase = ref.read(calculateUseCaseProvider);
    final a = double.tryParse(_firstOperand) ?? 0;
    final b = double.tryParse(_secondOperand) ?? 0;

    final result = useCase(
      a: a,
      b: b,
      operation: _currentOperation,
    );

    result.fold(
      (failure) {
        state = CalculatorEntity(
          displayValue: failure.message,
          hasError: true,
        );
      },
      (value) {
        _firstOperand = _formatResult(value);
        _secondOperand = '';
        _currentOperation = '';
        _shouldResetDisplay = true;
        _updateDisplay();
      },
    );
  }

  String _formatResult(double value) {
    if (value == value.truncateToDouble()) {
      return value.truncate().toString();
    }
    return value.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  void _updateDisplay() {
    String expression = _firstOperand;
    if (_currentOperation.isNotEmpty) {
      expression += ' $_currentOperation ';
      if (_secondOperand.isNotEmpty) {
        expression += _secondOperand;
      }
    }
    state = CalculatorEntity(
      displayValue: _firstOperand.isEmpty ? '0' : _firstOperand,
      expression: expression,
    );
  }
}

final calculatorControllerProvider =
    NotifierProvider<CalculatorController, CalculatorEntity>(
  CalculatorController.new,
);
