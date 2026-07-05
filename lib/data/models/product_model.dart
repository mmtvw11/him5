class ProductModel {
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

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] ?? '',
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'stock': stock,
      'thumbnail': thumbnail,
      'images': images,
      'category': category,
      'discountPercentage': discountPercentage,
    };
  }
}
