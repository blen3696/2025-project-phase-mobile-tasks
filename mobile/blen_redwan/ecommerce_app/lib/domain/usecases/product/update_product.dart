import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class UpdateProductUsecase {
  final ProductRepository repository;

  UpdateProductUsecase(this.repository);

  void call(Product updatedProduct) => repository.updateProduct(updatedProduct);
}
