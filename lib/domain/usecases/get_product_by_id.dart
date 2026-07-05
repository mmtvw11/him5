import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductById implements UseCase<ProductEntity, int> {
  final ProductRepository repository;

  GetProductById(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(int id) {
    return repository.getProductById(id);
  }
}
