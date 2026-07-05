import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {
  const FetchProductsEvent();
}

class FetchProductByIdEvent extends ProductEvent {
  final int productId;

  const FetchProductByIdEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
