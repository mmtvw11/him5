# E-Commerce Flutter App

Полностью рабочее Flutter приложение для просмотра товаров с использованием:
- **Clean Architecture** - разделение кода на слои (presentation, domain, data)
- **MVVM + BLOC** - управление состоянием через BLoC паттерн
- **GetIt** - Service Locator для dependency injection
- **Dio** - HTTP клиент с интерцепторами
- **Cached Network Image** - кеширование изображений
- **dartz** - функциональное программирование (Either для обработки ошибок)

## Структура проекта

```
lib/
├── core/
│   ├── constants/
│   │   └── api_constants.dart
│   ├── error/
│   │   └── failures.dart
│   ├── network/
│   │   ├── dio_client.dart
│   │   └── interceptors/
│   │       └── logging_interceptor.dart
│   └── usecase/
│       └── usecase.dart
├── data/
│   ├── datasources/
│   │   └── product_remote_datasource.dart
│   ├── models/
│   │   ├── product_model.dart
│   │   └── products_response_model.dart
│   └── repositories/
│       └── product_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── product_entity.dart
│   ├── repositories/
│   │   └── product_repository.dart
│   └── usecases/
│       ├── get_products.dart
│       └── get_product_by_id.dart
├── presentation/
│   ├── bloc/
│   │   └── product/
│   │       ├── product_bloc.dart
│   │       ├── product_event.dart
│   │       └── product_state.dart
│   └── screens/
│       ├── product_list/
│       │   └── product_list_screen.dart
│       ├── product_detail/
│       │   └── product_detail_screen.dart
│       └── widgets/
│           ├── product_card.dart
│           └── product_image_carousel.dart
├── service_locator.dart
└── main.dart
```

## Основные компоненты

### 1. **Core Layer (ядро приложения)**
- **ApiConstants** - константы API (базовый URL, timeouts)
- **Failures** - классы для обработки ошибок
- **DioClient** - настройка HTTP клиента с интерцепторами
- **LoggingInterceptor** - логирование запросов и ответов
- **UseCase** - базовый класс для use cases

### 2. **Data Layer (получение данных)**
- **ProductModel** - модель данных из API
- **ProductsResponseModel** - обертка для ответа API
- **ProductRemoteDataSource** - источник данных из сети
- **ProductRepositoryImpl** - реализация репозитория

### 3. **Domain Layer (бизнес-логика)**
- **ProductEntity** - сущность товара
- **ProductRepository** - интерфейс репозитория
- **GetProducts** - use case для получения всех товаров
- **GetProductById** - use case для получения одного товара

### 4. **Presentation Layer (UI)**
- **ProductBloc** - управление состоянием списка и деталей товаров
- **ProductListScreen** - экран списка товаров в виде Grid
- **ProductDetailScreen** - экран деталей товара
- **ProductCard** - карточка товара в списке
- **ProductImageCarousel** - карусель изображений товара

### 5. **Service Locator (GetIt)**
Центральная регистрация всех зависимостей:
- DioClient
- ProductRemoteDataSource
- ProductRepository
- Use Cases
- ProductBloc

## Возможности

✅ **Список товаров** - вывод товаров в виде сетки (2 колонки)  
✅ **Детальный просмотр** - полная информация о товаре  
✅ **Изображения** - карусель с фотографиями товара  
✅ **Цены и скидки** - отображение скидок в процентах  
✅ **Рейтинг** - звездочки рейтинга товара  
✅ **Статус наличия** - информация о доступности товара  
✅ **Обработка ошибок** - корректная обработка сетевых ошибок  
✅ **Loading состояния** - индикаторы загрузки  
✅ **Кеширование** - кеширование загруженных изображений  

## API

Приложение использует **https://dummyjson.com/**:
- `GET /products` - получить все товары
- `GET /products/{id}` - получить товар по ID

## Установка и запуск

```bash
# Получить зависимости
flutter pub get

# Запустить приложение
flutter run
```

## Архитектура

Приложение следует принципам **Clean Architecture**:

1. **Независимость слоев** - каждый слой независим от других
2. **Тестируемость** - легко писать unit тесты
3. **Масштабируемость** - простое добавление новых features
4. **Maintainability** - легко поддерживать и обновлять код

## Dependency Injection (GetIt)

Все зависимости регистрируются в `service_locator.dart`:

```dart
void setupServiceLocator() {
  // Network
  getIt.registerSingleton<DioClient>(DioClient());
  
  // DataSource
  getIt.registerSingleton<ProductRemoteDataSource>(
    ProductRemoteDataSourceImpl(dio: getIt<DioClient>().dio),
  );
  
  // Repository
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(remoteDataSource: getIt<ProductRemoteDataSource>()),
  );
  
  // Use Cases
  getIt.registerSingleton<GetProducts>(GetProducts(getIt<ProductRepository>()));
  getIt.registerSingleton<GetProductById>(GetProductById(getIt<ProductRepository>()));
  
  // BLOCs
  getIt.registerSingleton<ProductBloc>(
    ProductBloc(
      getProducts: getIt<GetProducts>(),
      getProductById: getIt<GetProductById>(),
    ),
  );
}
```

## BLOC паттерн

**ProductBloc** управляет двумя событиями:
- `FetchProductsEvent` - получение списка товаров
- `FetchProductByIdEvent` - получение деталей товара

**Состояния:**
- `ProductInitial` - начальное состояние
- `ProductLoading` - загрузка данных
- `ProductsLoaded` - список товаров загружен
- `ProductDetailLoaded` - детали товара загружены
- `ProductError` - ошибка

## Интерцепторы Dio

**LoggingInterceptor** логирует:
- Все исходящие запросы (метод, путь, headers, data)
- Все входящие ответы (статус код, data)
- Все ошибки (код ошибки, сообщение)

## Автор

Created with Clean Architecture & MVVM pattern
