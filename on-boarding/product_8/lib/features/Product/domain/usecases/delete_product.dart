import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository productRepository;
  const DeleteProductUseCase(this.productRepository);

  Future<Either<Failure, void>> deleteProduct(ProductEntity product) {
    return productRepository.deleteProduct(product);
  }
}
