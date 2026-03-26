import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/perform_calculation.dart';
import '../../data/repositories/calculator_repository_impl.dart';
import '../models/calculator_state.dart';

final calculatorRepositoryProvider = Provider((ref) => CalculatorRepositoryImpl());

final performCalculationProvider = Provider((ref) {
  final repository = ref.read(calculatorRepositoryProvider);
  return PerformCalculation(repository);
});

final calculatorControllerProvider = StateNotifierProvider<CalculatorController, CalculatorState>((ref) {
  final usecase = ref.read(performCalculationProvider);
  return CalculatorController(usecase);
});

class CalculatorController extends StateNotifier<CalculatorState> {
  final PerformCalculation _performCalculation;

  CalculatorController(this._performCalculation) : super(CalculatorState.initial());

  void onDigitPressed(String digit) {
    if (state.isResultShown) {
      state = state.copyWith(
        expression: digit,
        isResultShown: false,
      );
    } else {
      state = state.copyWith(
        expression: state.expression + digit,
      );
    }
  }

  void onOperatorPressed(String operator) {
    if (state.expression.isEmpty) return;
    
    // Don't add multiple operators
    final lastChar = state.expression.substring(state.expression.length - 1);
    if ('+-×÷'.contains(lastChar)) {
      state = state.copyWith(
        expression: state.expression.substring(0, state.expression.length - 1) + operator,
      );
    } else {
      state = state.copyWith(
        expression: state.expression + operator,
        isResultShown: false,
      );
    }
  }

  void onClear() {
    state = CalculatorState.initial();
  }

  void onDelete() {
    if (state.expression.isNotEmpty) {
      state = state.copyWith(
        expression: state.expression.substring(0, state.expression.length - 1),
      );
    }
  }

  Future<void> onEqualPressed() async {
    if (state.expression.isEmpty) return;
    
    state = state.copyWith(isLoading: true);
    
    final result = await _performCalculation.execute(state.expression);
    
    state = state.copyWith(
      result: result,
      isLoading: false,
      isResultShown: true,
    );
  }
}
