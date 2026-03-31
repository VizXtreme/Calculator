import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(calculatorControllerProvider.notifier);
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 2,
              child: CalculatorDisplay(),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.buttonSpacing),
                child: Column(
                  children: [
                    _buildRow(['C', '±', '%', '÷'], controller, context),
                    const SizedBox(height: AppConstants.buttonSpacing),
                    _buildRow(['7', '8', '9', '×'], controller, context),
                    const SizedBox(height: AppConstants.buttonSpacing),
                    _buildRow(['4', '5', '6', '-'], controller, context),
                    const SizedBox(height: AppConstants.buttonSpacing),
                    _buildRow(['1', '2', '3', '+'], controller, context),
                    const SizedBox(height: AppConstants.buttonSpacing),
                    _buildLastRow(controller, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<String> labels, CalculatorController controller, BuildContext context) {
    return Expanded(
      child: Row(
        children: labels.map((label) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CalculatorButton(
                label: label,
                onPressed: () => _onButtonPressed(label, controller),
                backgroundColor: _getButtonColor(label, context),
                textColor: _getTextColor(label, context),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLastRow(CalculatorController controller, BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CalculatorButton(
                label: '0',
                onPressed: () => controller.onDigitPressed('0'),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CalculatorButton(
                label: '.',
                onPressed: () => controller.onDecimalPressed(),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CalculatorButton(
                label: '=',
                onPressed: () => controller.onEqualsPressed(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onButtonPressed(String label, CalculatorController controller) {
    if (int.tryParse(label) != null) {
      controller.onDigitPressed(label);
    } else {
      switch (label) {
        case 'C':
          controller.onClearPressed();
          break;
        case '±':
          controller.onNegatePressed();
          break;
        case '%':
          controller.onPercentPressed();
          break;
        case '÷':
        case '×':
        case '-':
        case '+':
          controller.onOperationPressed(label == '÷' ? '/' : label == '×' ? '*' : label);
          break;
      }
    }
  }

  Color _getButtonColor(String label, BuildContext context) {
    if (['÷', '×', '-', '+', '='].contains(label)) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  Color _getTextColor(String label, BuildContext context) {
    if (['÷', '×', '-', '+', '='].contains(label)) {
      return Theme.of(context).colorScheme.onPrimary;
    }
    return Theme.of(context).colorScheme.onSurface;
  }
}
