import '../entities/product.dart';

class ViewAllProductsUsecase {
  final List<Product> _products;
  ViewAllProductsUsecase(this._products);
  List<Product> call() => _products;
}

class ViewProductUsecase {
  final List<Product> _products;
  ViewProductUsecase(this._products);
  Product? call(int id) =>
      _products.firstWhere((p) => p.id == id, orElse: () => Product.empty());
}

class CreateProductUsecase {
  final List<Product> _products;
  CreateProductUsecase(this._products);
  void call(Product product) {
    _products.add(product);
  }
}

class UpdateProductUsecase {
  final List<Product> _products;
  UpdateProductUsecase(this._products);
  void call(Product updatedProduct) {
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }
}

class DeleteProductUsecase {
  final List<Product> _products;
  DeleteProductUsecase(this._products);
  void call(int id) {
    _products.removeWhere((p) => p.id == id);
  }
}
