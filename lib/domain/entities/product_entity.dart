import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final int stock;
  final String thumbnail;
  final List<String> images;
  final String category;
  final double discountPercentage;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.images,
    required this.category,
    required this.discountPercentage,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        rating,
        stock,
        thumbnail,
        images,
        category,
        discountPercentage,
      ];
}
