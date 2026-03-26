import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/calculator_controller.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorControllerProvider);
    final notifier = ref.read(calculatorControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      state.expression,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.result,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: colorScheme.primary,
                        fontSize: 80,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Buttons Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CalculatorButton(
                        text: 'AC',
                        color: colorScheme.errorContainer,
                        textColor: colorScheme.onErrorContainer,
                        onPressed: notifier.onClear,
                      ),
                      CalculatorButton(
                        text: '()',
                        color: colorScheme.surfaceVariant,
                        onPressed: () {},
                      ),
                      CalculatorButton(
                        text: '%',
                        color: colorScheme.surfaceVariant,
                        onPressed: () {},
                      ),
                      CalculatorButton(
                        text: '÷',
                        color: colorScheme.primaryContainer,
                        textColor: colorScheme.onPrimaryContainer,
                        onPressed: () => notifier.onOperatorPressed('÷'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(text: '7', onPressed: () => notifier.onDigitPressed('7')),
                      CalculatorButton(text: '8', onPressed: () => notifier.onDigitPressed('8')),
                      CalculatorButton(text: '9', onPressed: () => notifier.onDigitPressed('9')),
                      CalculatorButton(
                        text: '×',
                        color: colorScheme.primaryContainer,
                        textColor: colorScheme.onPrimaryContainer,
                        onPressed: () => notifier.onOperatorPressed('×'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(text: '4', onPressed: () => notifier.onDigitPressed('4')),
                      CalculatorButton(text: '5', onPressed: () => notifier.onDigitPressed('5')),
                      CalculatorButton(text: '6', onPressed: () => notifier.onDigitPressed('6')),
                      CalculatorButton(
                        text: '−',
                        color: colorScheme.primaryContainer,
                        textColor: colorScheme.onPrimaryContainer,
                        onPressed: () => notifier.onOperatorPressed('−'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(text: '1', onPressed: () => notifier.onDigitPressed('1')),
                      CalculatorButton(text: '2', onPressed: () => notifier.onDigitPressed('2')),
                      CalculatorButton(text: '3', onPressed: () => notifier.onDigitPressed('3')),
                      CalculatorButton(
                        text: '+',
                        color: colorScheme.primaryContainer,
                        textColor: colorScheme.onPrimaryContainer,
                        onPressed: () => notifier.onOperatorPressed('+'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CalculatorButton(text: '0', onPressed: () => notifier.onDigitPressed('0')),
                      CalculatorButton(text: '.', onPressed: () => notifier.onDigitPressed('.')),
                      CalculatorButton(
                        text: '⌫',
                        onPressed: notifier.onDelete,
                      ),
                      CalculatorButton(
                        text: '=',
                        color: colorScheme.primary,
                        textColor: colorScheme.onPrimary,
                        onPressed: notifier.onEqualPressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
