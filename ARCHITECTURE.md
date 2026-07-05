/// Project Documentation
///
/// ## Architecture Overview
///
/// This project implements **Clean Architecture** with **MVVM + BLOC** pattern.
/// The codebase is organized into three main layers:
///
/// ### 1. **Data Layer** (`lib/data/`)
/// - Handles all data operations (API calls, local storage, etc.)
/// - Contains models and data source implementations
/// - Converts API responses to domain entities
///
/// ### 2. **Domain Layer** (`lib/domain/`)
/// - Contains business logic and use cases
/// - Defines entities and repository interfaces
/// - Independent from other layers
///
/// ### 3. **Presentation Layer** (`lib/presentation/`)
/// - UI screens and widgets
/// - State management with BLOC pattern
/// - User interactions and navigation
///
/// ## Key Technologies
///
/// - **Flutter BLoC**: State management
/// - **GetIt**: Dependency Injection
/// - **Dio**: HTTP client with interceptors
/// - **Dartz**: Functional programming (Either type)
/// - **Cached Network Image**: Image caching
/// - **Equatable**: Value equality
///
/// ## Project Structure
///
/// ```
/// lib/
/// ├── config/           # App configuration
/// ├── core/             # Core utilities and constants
/// ├── data/             # Data layer (models, repositories)
/// ├── domain/           # Domain layer (entities, use cases)
/// ├── presentation/     # Presentation layer (UI, BLOCs)
/// ├── service_locator.dart
/// └── main.dart
/// ```
///
/// ## How to Add New Features
///
/// 1. **Create Entity** in `domain/entities/`
/// 2. **Create Model** in `data/models/`
/// 3. **Create DataSource** in `data/datasources/`
/// 4. **Create Repository** implementing domain repository
/// 5. **Create UseCase** in `domain/usecases/`
/// 6. **Create BLoC** in `presentation/bloc/`
/// 7. **Create UI Screens** in `presentation/screens/`
/// 8. **Register in ServiceLocator** in `service_locator.dart`
///
/// ## Testing
///
/// To write unit tests:
/// ```dart
/// test('test name', () {
///   // arrange
///   final usecase = MockUseCase();
///   
///   // act
///   final result = await usecase(params);
///   
///   // assert
///   expect(result, expectedValue);
/// });
/// ```
///
/// ## API Integration
///
/// All API calls go through `DioClient` which has `LoggingInterceptor` enabled.
/// This means all requests and responses are logged to the console.
///
/// Base URL: https://dummyjson.com/
///
/// Available endpoints:
/// - GET `/products` - Get all products
/// - GET `/products/{id}` - Get product by ID
///
/// ## State Management Flow
///
/// ```
/// UI (Screen) 
///   → Event (ProductEvent)
///   → BLoC (ProductBloc)
///   → UseCase (GetProducts)
///   → Repository (ProductRepository)
///   → DataSource (ProductRemoteDataSource)
///   → API (Dio)
///   → Response converted to Entity
///   → State emitted
///   → UI rebuilds
/// ```
///
/// ## Error Handling
///
/// Errors are wrapped in `Failure` classes defined in `core/error/failures.dart`:
/// - `ServerFailure` - Server-side errors
/// - `CacheFailure` - Local storage errors
/// - `NetworkFailure` - Network connectivity errors
///
/// The `Either<Failure, Success>` type from dartz is used to handle errors
/// in a functional programming way.
///
/// ## Performance Optimization
///
/// - Images are cached using `CachedNetworkImage`
/// - BLoC singleton instances are reused
/// - API responses are efficiently parsed
/// - Lazy loading patterns can be implemented in pagination
///
/// ## Code Quality
///
/// - Follow Clean Code principles
/// - Use meaningful variable and function names
/// - Add comments for complex logic
/// - Keep methods small and focused
/// - Avoid nested if-else statements
///
/// ## Future Enhancements
///
/// - Add local database (Hive/SQLite)
/// - Implement pagination
/// - Add product search/filter
/// - Implement shopping cart
/// - Add user authentication
/// - Implement order history
/// - Add push notifications
/// - Implement dark mode
///
/// ---
/// Created with Clean Architecture principles and best practices.
