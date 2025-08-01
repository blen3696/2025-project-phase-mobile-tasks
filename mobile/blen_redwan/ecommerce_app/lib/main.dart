import 'features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'features/product/presentation/screens/home_page.dart';
import 'features/product/presentation/screens/details_page.dart';
import 'features/product/presentation/screens/add_update_page.dart';
import 'features/product/presentation/screens/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/add-update':
            final product = settings.arguments as Product?;
            return MaterialPageRoute(
              builder: (_) => AddUpdatePage(product: product),
            );
          case '/details':
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (_) => DetailsPage(product: product),
            );
          case '/search':
            return MaterialPageRoute(builder: (_) => const SearchPage());
          default:
            return null;
        }
      },
    );
  }
}
