import '../../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase(this.repository);

  void call(int id) => repository.deleteProduct(id);
}
