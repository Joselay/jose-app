### Feature-First Organization

- Organize code by features instead of technical layers
- Each feature is a self-contained module with its own implementation of all layers
- Core or shared functionality goes in a separate 'core' directory
- Features should have minimal dependencies on other features
- Common directory structure for each feature:

```
lib/
├── main.dart                      # Application entry point
├── app.dart                       # App widget configuration
│
├── core/                          # Shared/common code across all features
│   ├── config/                    # Application configuration
│   │   ├── app_config.dart        # Environment configs (dev, staging, prod)
│   │   ├── constants.dart         # App-wide constants
│   │   └── env.dart              # Environment variables
│   │
│   ├── di/                        # Dependency Injection
│   │   ├── injection_container.dart # Service locator setup
│   │   └── injection_modules.dart   # DI modules
│   │
│   ├── error/                     # Error handling
│   │   ├── exceptions.dart        # Custom exceptions
│   │   ├── failures.dart          # Failure classes
│   │   └── error_handler.dart     # Global error handling
│   │
│   ├── network/                   # Network layer
│   │   ├── api_client.dart        # HTTP client setup
│   │   ├── api_endpoints.dart     # API endpoints
│   │   ├── interceptors/          # Network interceptors
│   │   │   ├── auth_interceptor.dart
│   │   │   ├── logging_interceptor.dart
│   │   │   └── error_interceptor.dart
│   │   └── network_info.dart      # Network connectivity checker
│   │
│   ├── storage/                   # Local storage
│   │   ├── local_storage.dart     # Local storage interface
│   │   ├── shared_preferences.dart      # shared_preferences implementation
│   │   └── secure_storage.dart    # Secure storage (tokens, etc.)
│   │
│   ├── routing/                   # Application routing
│   │   ├── app_router.dart        # Main router configuration
│   │   ├── route_names.dart       # Route name constants
│   │   └── route_guards.dart      # Route protection/guards
│   │
│   ├── theme/                     # Application theming
│   │   ├── app_theme.dart         # Theme configuration
│   │   ├── colors.dart            # Color palette
│   │   ├── text_styles.dart       # Typography
│   │   └── dimensions.dart        # Spacing, sizes
│   │
│   ├── utils/                     # Utility functions
│   │   ├── extensions/            # Dart/Flutter extensions
│   │   │   ├── string_extensions.dart
│   │   │   ├── datetime_extensions.dart
│   │   │   └── widget_extensions.dart
│   │   ├── helpers/               # Helper functions
│   │   │   ├── validation_helper.dart
│   │   │   ├── date_helper.dart
│   │   │   └── format_helper.dart
│   │   └── logger.dart            # Logging utility
│   │
│   ├── widgets/                   # Reusable UI components
│   │   ├── buttons/               # Custom buttons
│   │   │   ├── primary_button.dart
│   │   │   └── secondary_button.dart
│   │   ├── forms/                 # Form components
│   │   │   ├── custom_text_field.dart
│   │   │   └── form_validators.dart
│   │   ├── loading/               # Loading indicators
│   │   │   ├── loading_widget.dart
│   │   │   └── shimmer_widget.dart
│   │   ├── dialogs/               # Custom dialogs
│   │   │   ├── confirmation_dialog.dart
│   │   │   └── error_dialog.dart
│   │   └── common/                # Other common widgets
│   │       ├── custom_app_bar.dart
│   │       ├── empty_state.dart
│   │       └── error_widget.dart
│   │
│   └── usecases/                  # Base use case classes
│       ├── usecase.dart           # Base use case interface
│       └── params.dart            # Common parameter classes
│
├── features/                      # Feature modules
│   ├── authentication/            # Authentication feature
│   │   ├── data/                  # Data layer
│   │   │   ├── datasources/       # Data sources
│   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/            # Data models (DTOs)
│   │   │   │   ├── login_request_model.dart
│   │   │   │   ├── login_response_model.dart
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/      # Repository implementations
│   │   │       └── auth_repository_impl.dart
│   │   │
│   │   ├── domain/                # Domain layer (business logic)
│   │   │   ├── entities/          # Business entities
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/      # Repository interfaces
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/          # Use cases
│   │   │       ├── login_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       └── get_current_user_usecase.dart
│   │   │
│   │   └── presentation/          # Presentation layer
│   │       ├── bloc/              # State management
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/             # Screen pages
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       │   └── forgot_password_page.dart
│   │       └── widgets/           # Feature-specific widgets
│   │           ├── login_form.dart
│   │           └── social_login_buttons.dart
│   │
│   ├── profile/                   # User profile feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── profile_local_datasource.dart
│   │   │   │   └── profile_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── profile_model.dart
│   │   │   └── repositories/
│   │   │       └── profile_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── profile_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── profile_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_profile_usecase.dart
│   │   │       └── update_profile_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── profile_bloc.dart
│   │       │   ├── profile_event.dart
│   │       │   └── profile_state.dart
│   │       ├── pages/
│   │       │   ├── profile_page.dart
│   │       │   └── edit_profile_page.dart
│   │       └── widgets/
│   │           ├── profile_avatar.dart
│   │           └── profile_info_card.dart
│   │
│   ├── home/                      # Home/Dashboard feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   └── settings/                  # Settings feature
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
├── shared/                        # Shared business logic across features
│   ├── domain/                    # Shared domain layer
│   │   ├── entities/              # Common entities
│   │   │   ├── base_entity.dart
│   │   │   └── pagination_entity.dart
│   │   └── repositories/          # Shared repository interfaces
│   │       └── base_repository.dart
│   │
│   ├── data/                      # Shared data layer
│   │   ├── models/                # Common models
│   │   │   ├── base_response_model.dart
│   │   │   ├── error_model.dart
│   │   │   └── pagination_model.dart
│   │   └── repositories/          # Shared repository implementations
│   │       └── base_repository_impl.dart
│   │
│   └── presentation/              # Shared presentation components
│       ├── bloc/                  # Global state management
│       │   ├── app_bloc.dart      # App-level state (theme, language)
│       │   ├── connectivity_bloc.dart
│       │   └── navigation_bloc.dart
│       └── widgets/               # Complex shared widgets
│           ├── infinite_scroll_list.dart
│           └── pull_to_refresh_list.dart
│
└── l10n/                          # Internationalization
    ├── app_localizations.dart     # Generated localizations
    ├── arb/                       # Translation files
    │   ├── app_en.arb
    │   ├── app_es.arb
    │   └── app_fr.arb
    └── l10n.yaml                  # Localization configuration
```
