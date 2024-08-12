import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetOneProductUseCase {
  final ProductRepository productRepository;
  GetOneProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> getOneProduct(String id) {
    return productRepository.getOneProduct(id);
  }
}
