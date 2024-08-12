import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository productRepository;
  GetProductsUseCase(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> getProduct() {
    return productRepository.getProducts();
  }
}
