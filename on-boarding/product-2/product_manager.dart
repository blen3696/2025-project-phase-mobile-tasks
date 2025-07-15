import 'product.dart';

class ProductManager {
  final List<Product> _product = [];

  void addProduct(Product product) {
    _product.add(product);
    print('Product added sucessfully \n');
  }

  void viewAllProducts() {
    if (_product.isEmpty) {
      print('No products are available right now \n');
    }

    for (int i = 0; i < _product.length; i++) {
      print('\nProduct ID: $i');
      print(_product[i]);
    }
  }

  void viewProduct(int index) {
    if (isValidIndex(index)) {
      print('\nProduct Detail: \n${_product[index]}');
    }
  }

  void editProduct(int index, String name, String description, double price) {
    if (isValidIndex(index)) {
      _product[index].name = name;
      _product[index].description = description;
      _product[index].price = price;
      print('Product updated Sucessfully \n');
    }
  }

  void deleteProduct(int index) {
    if (isValidIndex(index)) {
      _product.removeAt(index);
      print('Product deleted sucessfully \n');
    }
  }

  bool isValidIndex(int index) {
    if (index < 0 || index >= _product.length) {
      print('Invalid Product Id  \n');
      return false;
    }

    return true;
  }
}
