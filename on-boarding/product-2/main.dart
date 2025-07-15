import 'dart:io';
import 'product.dart';
import 'product_manager.dart';

void main() {
  final manager = ProductManager();

  print('\nWelcome to the Simple eCommerce App!');
  print('--------------------------------------');

  while (true) {
    print('''
      Menu Options:
        1. Add a New Product
        2. View All Products
        3. View Single Product
        4. Edit a Product
        5. Delete a Product
        6. Exit
      ''');

    stdout.write('Enter your choice (1-6): ');
    final input = stdin.readLineSync();

    switch (input) {
      case '1':
        _handleAddProduct(manager);
        break;
      case '2':
        manager.viewAllProducts();
        break;
      case '3':
        _handleViewSingleProduct(manager);
        break;
      case '4':
        _handleEditProduct(manager);
        break;
      case '5':
        _handleDeleteProduct(manager);
        break;
      case '6':
        print('\nExiting... Thank you for using the app!\n');
        return;
      default:
        print('Invalid choice. Please try again.\n');
    }
  }
}

void _handleAddProduct(ProductManager manager) {
  print('\nAdd a New Product');

  stdout.write('Enter product name: ');
  final name = stdin.readLineSync() ?? '';

  stdout.write('Enter product description: ');
  final description = stdin.readLineSync() ?? '';

  stdout.write('Enter product price: ');
  final price = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  final product = Product(name, description, price);
  manager.addProduct(product);
}

void _handleViewSingleProduct(ProductManager manager) {
  stdout.write('\nEnter product ID to view: ');
  final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
  manager.viewProduct(index);
}

void _handleEditProduct(ProductManager manager) {
  print('\nEdit a Product');

  stdout.write('Enter product ID to edit: ');
  final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

  stdout.write('Enter new name: ');
  final name = stdin.readLineSync() ?? '';

  stdout.write('Enter new description: ');
  final description = stdin.readLineSync() ?? '';

  stdout.write('Enter new price: ');
  final price = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  manager.editProduct(index, name, description, price);
}

void _handleDeleteProduct(ProductManager manager) {
  stdout.write('\nEnter product ID to delete: ');
  final index = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

  manager.deleteProduct(index);
}
