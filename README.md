# Modern Calculator

A production-grade, premium calculator application built with Flutter using Clean Architecture and Riverpod.

## 🚀 Features
- **Clean Architecture**: Modular structure (`Presentation -> Domain -> Data -> Core`)
- **State Management**: powered by `riverpod` (StateNotifier)
- **Modern Routing**: using `go_router`
- **Premium Design**: Material 3 Expressive design with Outfit typography
- **CI/CD**: Automatic linting, testing, and APK release via GitHub Actions

## 🏗️ Architecture
The project follows a "Feature-First" clean architecture approach:
- **lib/core**: Shared logic, themes, routes, and utilities.
- **lib/features/calculator**: The main calculator feature.
  - **domain**: Business logic (entities, repository interfaces, usecases).
  - **data**: Implementation (repository implementations, external libraries like `math_expressions`).
  - **presentation**: UI (controllers, screens, widgets).

## 🛠️ Build & Development
Since the user mentioned not having Flutter locally:
1. Push this folder to your GitHub repository.
2. Enable GitHub Actions.
3. Pull requests to `main` will trigger CI (lint/test).
4. Tagging with `v*` (e.g., `v1.0.0`) will build and release the APK automatically.

### Commands
- Get dependencies: `flutter pub get`
- Run the app: `flutter run`
- Build release APK: `flutter build apk --release --split-per-abi`
