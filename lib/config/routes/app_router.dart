import 'package:flutter/material.dart';
import '../../presentation/screens/product_list/product_list_screen.dart';
import '../../presentation/screens/product_detail/product_detail_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const ProductListScreen(),
        );
      case '/product-detail':
        final productId = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            productId: productId ?? 0,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
