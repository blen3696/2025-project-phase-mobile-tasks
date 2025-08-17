import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUsecase {
  final ProductRepository repository;

  GetProductByIdUsecase(this.repository);

  Future<Product?> call(int id) async {
    return await repository.getProductById(id);
  }
}
