# Class Schedule App

A Flutter application featuring a class schedule management system with a horizontal scroll snap carousel and day-based filtering.

## Features

- Day-based filtering with easy tab navigation
- Horizontal scroll snap carousel with smooth transitions and animations
- Indicator dots that highlight the current schedule card
- Schedule cards with teacher name, subject, room, and time information
- Clean UI using ShadCN UI components
- BLoC pattern for state management
- Responsive design that works across different screen sizes

## Project Structure

This project follows a clean architecture with feature-first organization:

```
lib/
  ├── core/
  │   └── di/
  │       └── injection.dart
  ├── features/
  │   └── schedule/
  │       ├── domain/
  │       │   └── entities/
  │       │       └── schedule_entity.dart
  │       └── presentation/
  │           ├── bloc/
  │           │   ├── schedule_bloc.dart
  │           │   ├── schedule_event.dart
  │           │   └── schedule_state.dart
  │           ├── pages/
  │           │   └── schedule_page.dart
  │           └── widgets/
  │               ├── schedule_card.dart
  │               └── schedule_carousel.dart
  └── main.dart
```

## Implementation Details

- Uses Flutter's BLoC pattern for state management
- Implements dependency injection for better testability
- Features a custom carousel using PageView with controller
- Animated indicators show the current page
- Uses a clean architecture approach for better maintainability
- Integrates ShadCN UI for modern, consistent styling

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

- Flutter SDK ^3.8.1
- flutter_bloc: for state management
- equatable: for value equality
- get_it: for dependency injection
- shadcn_ui: for UI components

## Development Commands

```
flutter pub run build_runner build --delete-conflicting-outputs
```