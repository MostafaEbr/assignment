# E-Commerce App

A modern e-commerce application built with Flutter, featuring a clean architecture and beautiful UI.

## Features

- **Categories View**
  - Grid layout of product categories
  - Beautiful gradient cards with category-specific colors
  - Smooth navigation to product listings
  - Loading states with shimmer effect
  - Error handling with retry functionality

## Architecture

The project follows Clean Architecture principles with the following layers:

- **Presentation Layer**
  - Pages
  - BLoC (Business Logic Component) for state management
  - Widgets

- **Domain Layer**
  - Use Cases
  - Repository Interfaces
  - Entities

- **Data Layer**
  - Repository Implementations
  - Data Sources
  - Models

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
```

2. Navigate to the project directory:
```bash
cd e-commerce-app
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Dependencies

- **flutter_bloc**: For state management
- **go_router**: For navigation
- **shimmer**: For loading effects
- **dio**: For HTTP requests
- **freezed**: For code generation
- **equatable**: For value equality

## Project Structure

```
lib/
├── features/
│   ├── categories/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   └── products/
└── core/
    ├── error/
    ├── network/
    └── utils/
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
