# 🎬 Cine App

A modern Flutter application for browsing movies, discovering new releases, and managing your favorite films. Built with Clean Architecture principles and state-of-the-art Flutter technologies.

## ✨ Features

- 🎥 **Movie Discovery**: Browse popular, now playing, and upcoming movies
- 🔍 **Search**: Search for movies by title
- ⭐ **Favorites**: Save your favorite movies locally for offline access
- 🎭 **Movie Details**: View comprehensive information about movies including:
  - Synopsis and overview
  - Cast and crew information
  - Ratings and release dates
  - Genres and categories
- 🎨 **Dark Mode**: Toggle between light and dark themes
- 📱 **Responsive Design**: Optimized for various screen sizes
- 🚀 **Offline Support**: Access your favorite movies even without internet connection

## 🏗️ Architecture

This project follows **Clean Architecture** principles, ensuring separation of concerns and maintainability:

```
lib/
├── config/          # Configuration files (theme, routes, constants)
├── domain/          # Business logic layer
│   ├── entities/    # Domain models
│   ├── repositories/ # Repository interfaces
│   └── datasources/ # Data source interfaces
├── infrastructure/  # External data layer
│   ├── datasource/  # API and local data sources
│   ├── models/      # Data models (DTOs)
│   ├── mappers/     # Entity to Model mappers
│   └── repositories/ # Repository implementations
└── presentation/    # UI layer
    ├── screens/     # Full-screen views
    ├── views/       # Reusable view components
    ├── widgets/     # UI widgets
    └── providers/   # Riverpod state providers
```

### Architecture Layers

- **Domain Layer**: Contains business entities and repository interfaces (pure Dart, no dependencies)
- **Infrastructure Layer**: Implements data sources and repositories (API calls, local storage)
- **Presentation Layer**: UI components and state management (Flutter widgets, Riverpod providers)

## 🛠️ Technologies

### Core
- **Flutter** 3.9.0+
- **Dart** 3.9.0+

### State Management
- **Riverpod** 3.0.0 - Reactive state management

### Networking
- **Dio** 5.9.0 - HTTP client for API requests

### Local Storage
- **Drift** 2.29.0 - Type-safe SQLite database
- **Shared Preferences** 2.3.3 - Key-value storage

### Navigation
- **GoRouter** 16.2.1 - Declarative routing

### UI/UX
- **Animate Do** 4.2.0 - Animation library
- **Flutter Animate** 4.5.2 - Animation utilities
- **Card Swiper** 3.0.1 - Swipeable card widgets
- **Flutter Staggered Grid View** 0.7.0 - Staggered grid layouts

### Utilities
- **Flutter Dotenv** 6.0.0 - Environment variables
- **Intl** 0.20.2 - Internationalization

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.9.0 or higher)
- **Dart SDK** (3.9.0 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development on macOS)
- **Android SDK** (for Android development)

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone <repository-url>
cd cine_app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure environment variables

Create a `.env` file in the root directory:

```env
MOVIE_KEY=your_api_key_here
```

**Note**: You'll need to obtain an API key from [The Movie Database (TMDB)](https://www.themoviedb.org/settings/api).

### 4. Generate code

Run the code generator for Drift database:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Run the app

```bash
# For development
flutter run

# For a specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

## 📱 Building for Production

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## 🧪 Testing

Run tests with:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## 📂 Project Structure

```
lib/
├── config/
│   ├── constants/      # App constants (env, genres)
│   ├── database/       # Database configuration
│   ├── helpers/        # Utility helpers
│   ├── routes/         # Navigation routes
│   └── theme/          # App theme configuration
├── domain/
│   ├── datasources/    # Data source contracts
│   ├── entities/       # Domain entities
│   └── repositories/   # Repository contracts
├── infrastructure/
│   ├── datasource/     # API and local data sources
│   ├── mappers/        # Data mappers
│   ├── models/         # Data transfer objects
│   └── repositories/   # Repository implementations
├── presentation/
│   ├── delegates/      # Search delegates
│   ├── providers/      # Riverpod providers
│   ├── screens/        # Full-screen views
│   ├── views/          # View components
│   └── widgets/        # Reusable widgets
└── main.dart           # App entry point
```

## 🎯 Key Features Implementation

### State Management with Riverpod

The app uses Riverpod for reactive state management:

- **Movie Providers**: Manage movie data and loading states
- **Actor Providers**: Handle cast information
- **Storage Providers**: Manage favorite movies
- **Theme Provider**: Control app theme (light/dark)

### Local Storage with Drift

Favorites are stored locally using Drift:

- Type-safe database queries
- Automatic code generation
- Efficient data persistence

### API Integration

The app integrates with The Movie Database (TMDB) API:

- Popular movies
- Now playing movies
- Upcoming releases
- Movie details and cast information

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Code Style

This project follows Flutter and Dart best practices:

- Clean Architecture principles
- SOLID principles
- Repository pattern
- Provider pattern with Riverpod
- Type-safe code (no dynamic types)
- Comprehensive error handling

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the movie API
- Flutter team for the amazing framework
- All the open-source contributors of the packages used in this project

---

Made with ❤️ using Flutter
