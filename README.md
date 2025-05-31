# Profile Carousel App

A Flutter application featuring a horizontal scroll snap profile carousel with indicators.

## Features

- Horizontal scroll snap carousel with smooth transitions
- Three indicator dots that highlight the current profile
- Profile cards with avatar, name, role, bio, and action button
- Color-coded avatars with initials when no image is available
- Responsive design that works across different screen sizes

## Project Structure

This project follows a feature-first architecture:

```
lib/
  ├── features/
  │   └── profile/
  │       ├── domain/
  │       │   └── entities/
  │       │       └── profile_entity.dart
  │       └── presentation/
  │           ├── pages/
  │           │   └── profile_carousel_page.dart
  │           └── widgets/
  │               └── profile_carousel.dart
  └── main.dart
```

## Implementation Details

- Uses Flutter's native Material components for UI elements
- Implements custom carousel using PageView with controller
- Features animated indicators that show the current page
- Uses a feature-first architecture for better maintainability

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

- Flutter SDK ^3.8.1

flutter pub run build_runner build --delete-conflicting-outputs
