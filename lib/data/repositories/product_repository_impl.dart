import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final models = await remoteDataSource.getProducts();
      final entities = models
          .map(
            (model) => ProductEntity(
              id: model.id,
              title: model.title,
              description: model.description,
              price: model.price,
              rating: model.rating,
              stock: model.stock,
              thumbnail: model.thumbnail,
              images: model.images,
              category: model.category,
              discountPercentage: model.discountPercentage,
            ),
          )
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final model = await remoteDataSource.getProductById(id);
      final entity = ProductEntity(
        id: model.id,
        title: model.title,
        description: model.description,
        price: model.price,
        rating: model.rating,
        stock: model.stock,
        thumbnail: model.thumbnail,
        images: model.images,
        category: model.category,
        discountPercentage: model.discountPercentage,
      );
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
