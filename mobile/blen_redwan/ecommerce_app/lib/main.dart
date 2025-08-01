import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import './screens/details_page.dart';
import './screens//add_update_page.dart';
import './screens//search_page.dart';

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
      // home: HomePage(),
      // home: DetailsPage(product: dummyProducts[0]),
      // home: AddUpdatePage(),
      // home: SearchPage(),
    );
  }
}
