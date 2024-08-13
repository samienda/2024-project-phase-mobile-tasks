import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository productRepository;
  const DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> deleteProduct(String id) {
    return productRepository.deleteProduct(id);
  }
}
