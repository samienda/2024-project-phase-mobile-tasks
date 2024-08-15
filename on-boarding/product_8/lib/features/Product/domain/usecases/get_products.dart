import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase implements Usecase<List<ProductEntity>, NoParams> {
  final ProductRepository productRepository;
  GetProductsUseCase(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) {
    return productRepository.getProducts();
  }
}
