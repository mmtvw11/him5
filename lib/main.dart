import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/product_list/product_list_screen.dart';
import 'presentation/bloc/product/product_bloc.dart';
import 'config/routes/app_router.dart';
import 'config/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.productList,
      onGenerateRoute: AppRouter.generateRoute,
      home: BlocProvider(
        create: (context) => getIt<ProductBloc>(),
        child: const ProductListScreen(),
      ),
    );
  }
}
