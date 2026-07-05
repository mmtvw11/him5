# E-Commerce Flutter App - Complete Setup Guide

## 🎯 Quick Start

### 1. Clone and Setup
```bash
# Clone the repository
git clone https://github.com/mmtvw11/him5.git
cd him5

# Checkout the feature branch
git checkout feature/ecommerce-app

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### 2. Verify Installation
After running the app, you should see:
- ✅ Product list screen with grid view (2 columns)
- ✅ Each product card showing image, title, rating, price, and discount
- ✅ Tap any product to view details
- ✅ Detail screen with image carousel, full description, and add to cart button

## 📱 Features Implemented

### Product List Screen
- Grid view with 2 columns
- Product cards with:
  - Product image (cached)
  - Product title (truncated)
  - Star rating display
  - Discounted price (green)
  - Original price (strikethrough)
  - Discount badge (-20%)
  - Loading indicator
  - Error handling with retry button

### Product Detail Screen
- Image carousel with swipeable images
- Current page indicator (e.g., "1/5")
- Full product information:
  - Title and category
  - Full description
  - Ratings with star display
  - Price breakdown (original, discounted, discount %)
  - Stock status (In Stock / Out of Stock)
  - Add to cart button
- Loading states
- Error handling

## 🏗️ Architecture Layers

### Core Layer
```
core/
├── constants/          # API constants
├── error/              # Error handling
├── extensions/         # String, Double, List extensions
├── network/            # Dio client & interceptors
├── theme/              # App theme configuration
├── usecase/            # UseCase base class
└── utils/              # Utility functions
```

### Data Layer
```
data/
├── datasources/        # Remote data sources
├── models/             # API models
└── repositories/       # Repository implementations
```

### Domain Layer
```
domain/
├── entities/           # Business entities
├── repositories/       # Repository interfaces
└── usecases/           # Business logic
```

### Presentation Layer
```
presentation/
├── bloc/               # BLoC pattern
├── screens/            # UI Screens
└── widgets/            # Reusable widgets
```

## 🔌 Dependency Injection (GetIt)

All dependencies are registered in `lib/service_locator.dart`:

```dart
void setupServiceLocator() {
  // Network layer
  getIt.registerSingleton<DioClient>(DioClient());
  
  // Data layer
  getIt.registerSingleton<ProductRemoteDataSource>(
    ProductRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );
  
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(remoteDataSource: getIt<ProductRemoteDataSource>()),
  );
  
  // Domain layer
  getIt.registerSingleton<GetProducts>(GetProducts(getIt<ProductRepository>()));
  getIt.registerSingleton<GetProductById>(GetProductById(getIt<ProductRepository>()));
  
  // Presentation layer
  getIt.registerSingleton<ProductBloc>(
    ProductBloc(
      getProducts: getIt<GetProducts>(),
      getProductById: getIt<GetProductById>(),
    ),
  );
}
```

## 📡 Network Layer

### DioClient Configuration
- Base URL: `https://dummyjson.com`
- Connection timeout: 30 seconds
- Receive timeout: 30 seconds
- Default headers: `Content-Type: application/json`

### LoggingInterceptor
Logs all network traffic:
```
[REQUEST] METHOD => PATH
HEADERS: {...}
DATA: {...}

[RESPONSE] STATUS_CODE => PATH
DATA: {...}

[ERROR] STATUS_CODE => PATH
MESSAGE: {...}
```

## 🎯 State Management (BLoC)

### ProductBloc Events
```dart
FetchProductsEvent()        // Fetch all products
FetchProductByIdEvent(id)   // Fetch single product
```

### ProductBloc States
```dart
ProductInitial()           // Initial state
ProductLoading()           // Data loading
ProductsLoaded(products)   // List loaded
ProductDetailLoaded(product) // Detail loaded
ProductError(message)      // Error occurred
```

## 🎨 UI Components

### Reusable Widgets
- `ProductCard` - Product item in list
- `ProductImageCarousel` - Image swiper
- `RatingWidget` - Star rating display
- `PriceDisplayWidget` - Price breakdown
- `CustomAppBar` - Custom app bar
- `LoadingWidget` - Loading indicator
- `ErrorWidget` - Error display with retry

### Theme
- Primary Color: `#2563EB` (Blue)
- Success Color: `#10B981` (Green)
- Error Color: `#EF4444` (Red)
- Background: `#F9FAFB` (Light Gray)

## 🔒 Error Handling

Three types of failures:
```dart
ServerFailure(message)    // API errors (5xx, etc.)
NetworkFailure(message)   // Network connectivity issues
CacheFailure(message)     // Local storage errors
```

Using `Either<Failure, Success>` for type-safe error handling:
```dart
final result = await getProducts(NoParams());
result.fold(
  (failure) => emit(ProductError(failure.message)),
  (products) => emit(ProductsLoaded(products)),
);
```

## 📦 Dependencies

```yaml
flutter_bloc: ^8.1.3       # State management
bloc: ^8.1.1              # Core BLoC library
get_it: ^7.6.0            # Service locator
dio: ^5.3.1               # HTTP client
equatable: ^2.0.5         # Value equality
cached_network_image: ^3.3.0  # Image caching
dartz: ^0.10.1            # Functional programming
```

## 🚀 Extending the App

### Add New Feature (e.g., Cart)

1. **Create Entity**
```dart
// domain/entities/cart_item_entity.dart
class CartItemEntity extends Equatable {
  final int productId;
  final int quantity;
  // ...
}
```

2. **Create Model**
```dart
// data/models/cart_item_model.dart
class CartItemModel {
  factory CartItemModel.fromJson(Map<String, dynamic> json) { ... }
}
```

3. **Create Use Case**
```dart
// domain/usecases/add_to_cart.dart
class AddToCart implements UseCase<void, CartItemEntity> { ... }
```

4. **Create BLoC**
```dart
// presentation/bloc/cart/cart_bloc.dart
class CartBloc extends Bloc<CartEvent, CartState> { ... }
```

5. **Create UI**
```dart
// presentation/screens/cart/cart_screen.dart
class CartScreen extends StatelessWidget { ... }
```

6. **Register in ServiceLocator**
```dart
getIt.registerSingleton<CartBloc>(
  CartBloc(...),
);
```

## 🧪 Testing

### Unit Test Example
```dart
test('GetProducts returns list of products', () async {
  // Arrange
  final mockRepository = MockProductRepository();
  final usecase = GetProducts(mockRepository);
  final tProducts = [ProductEntity(...)];
  
  when(mockRepository.getProducts())
    .thenAnswer((_) async => Right(tProducts));
  
  // Act
  final result = await usecase(NoParams());
  
  // Assert
  expect(result, Right(tProducts));
  verify(mockRepository.getProducts()).called(1);
});
```

## 📚 File Structure Summary

```
lib/
├── config/
│   ├── constants.dart
│   └── routes/
│       ├── app_routes.dart
│       └── app_router.dart
├── core/
│   ├── constants/
│   ├── error/
│   ├── extensions/
│   ├── network/
│   ├── theme/
│   ├── usecase/
│   └── utils/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── screens/
│   └── widgets/
├── service_locator.dart
└── main.dart
```

## 🎓 Learning Resources

- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)
- [Dio Documentation](https://pub.dev/packages/dio)
- [Dartz Documentation](https://pub.dev/packages/dartz)

## 📝 Notes

- All images are cached for better performance
- API requests have logging enabled for debugging
- Error messages are user-friendly
- Loading states show progress indicators
- Retry buttons are available on error screens
- Navigation is handled via named routes

## 🐛 Troubleshooting

### App won't start
```bash
flutter clean
flutter pub get
flutter run
```

### No images loading
- Check internet connection
- Verify API is accessible: https://dummyjson.com/products
- Check Dio logs in console

### BLoC not updating UI
- Ensure BLoC is provided in the widget tree
- Check BlocBuilder is listening to correct state
- Verify events are being added to BLoC

## 📞 Support

For issues or questions:
1. Check existing GitHub issues
2. Review API documentation at dummyjson.com
3. Check Flutter/BLoC documentation
4. Open a new GitHub issue with details

---
**Happy Coding! 🚀**
