import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import './data/dummy_products.dart';
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
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: DetailsPage(product: dummyProducts[0]),
      // home: AddUpdatePage(),
      // home: SearchPage(),
    );
  }
}
