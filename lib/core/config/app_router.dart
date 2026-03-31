import 'package:go_router/go_router.dart';
import '../../features/calculator/presentation/screens/calculator_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'calculator',
        builder: (context, state) => const CalculatorScreen(),
      ),
    ],
  );
}
