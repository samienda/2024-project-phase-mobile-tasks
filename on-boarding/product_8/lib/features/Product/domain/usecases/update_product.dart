import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository productRepository;
  const UpdateProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> updateProduct(ProductEntity product) {
    return productRepository.updateProduct(product);
  }
}
