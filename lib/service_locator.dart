import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/get_product_by_id.dart';
import 'presentation/bloc/product/product_bloc.dart';

final getIt = GetIt.instance;

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

  // UseCases
  getIt.registerSingleton<GetProducts>(GetProducts(getIt<ProductRepository>()));
  getIt.registerSingleton<GetProductById>(
    GetProductById(getIt<ProductRepository>()),
  );

  // BLOCs
  getIt.registerSingleton<ProductBloc>(
    ProductBloc(
      getProducts: getIt<GetProducts>(),
      getProductById: getIt<GetProductById>(),
    ),
  );
}
