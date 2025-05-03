# Flowery App

*An Elegant Floral E-Commerce Platform*

## Overview

Flowery is a comprehensive mobile commerce application designed for browsing, purchasing, and delivering premium floral arrangements. Developed with Flutter for cross-platform compatibility, the application features a robust architecture, state-of-the-art UI components, and seamless backend integration.

## Key Features

| Feature | Description |
|---------|-------------|
| **Modern UI/UX** | Material Design implementation with custom theming and animations |
| **Authentication System** | Secure email/password authentication with guest access capabilities |
| **Product Catalog** | Dynamic categorization with filtered browsing and featured collections |
| **Advanced Search** | Real-time product search with faceted filtering and pull-to-refresh |
| **Shopping Experience** | Intuitive cart management and streamlined checkout process |
| **Localization** | Complete i18n support for English and Arabic using Easy Localization |
| **Optimized Performance** | Efficient image loading and caching system for minimal resource usage |
| **Secure Storage** | Encrypted credential management with token caching implementation |
| **Order Management** | Comprehensive order placement, tracking, and history features |

## Architecture

The application implements Clean Architecture principles with a feature-first organization structure:

```
lib/
│
├── core/                # Foundation components and utilities
│   ├── di/              # Dependency injection with GetIt and Injectable
│   ├── network/         # API layer with Dio implementation
│   ├── routes/          # Navigation system with route generation
│   ├── storage/         # Persistence layer utilizing secure storage
│   └── theme/           # Global styling and theming configuration
│
├── features/            # Feature modules with domain-driven design
│   ├── auth/            # Authentication feature with BLoC state management
│   ├── cart/            # Shopping cart functionality and state
│   ├── home/            # Home screen components and state management
│   ├── nav/             # Navigation control and UI components
│   └── search/          # Product search implementation with filters
│
└── main.dart            # Application entry point and configuration
```

## Technical Stack

| Category | Technologies |
|----------|--------------|
| **Framework** | Flutter SDK 3.5.3+ |
| **State Management** | BLoC/Cubit with flutter_bloc |
| **Networking** | Dio HTTP client with interceptors |
| **Dependency Injection** | GetIt & Injectable |
| **Localization** | Easy Localization |
| **Local Storage** | Hive, SharedPreferences & Flutter Secure Storage |
| **UI Components** | Material Design & Custom Widgets |
| **Analytics & Monitoring** | Firebase Analytics & Crashlytics |
| **Testing** | Unit & Widget Testing with Mockito |

## Getting Started

### Environment Requirements

- Flutter SDK (version ^3.5.3)
- Dart SDK (compatible with Flutter version)
- Android Studio / Visual Studio Code with Flutter extensions
- Android SDK / Xcode for mobile development

### Development Setup

1. Clone the repository
   ```bash
   git clone https://github.com/organization/flower_app.git
   cd flower_app
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Generate required code
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Launch the application
   ```bash
   flutter run
   ```

## API Integration

The application integrates with a RESTful backend service for product data, authentication tokens, and order management. The network layer is implemented with Dio client featuring:

- Interceptor-based authentication
- Error handling middleware
- Connectivity monitoring
- Response transformation

## Security Implementation

- Token-based authentication with secure storage
- Memory caching mechanism to reduce secure storage access
- Proper token lifecycle management
- Input validation and sanitization


![1](https://github.com/user-attachments/assets/fa1df738-2575-48b4-aec2-c40cb502b70d)
![2](https://github.com/user-attachments/assets/26e896cb-996c-4746-934e-e44be7cfcc65)
![3](https://github.com/user-attachments/assets/3ab7a517-8372-4c04-b214-b43c55f176aa)

