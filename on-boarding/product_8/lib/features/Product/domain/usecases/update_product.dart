import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase extends Usecase<ProductEntity, GetParams> {
  final ProductRepository productRepository;
  UpdateProductUseCase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(GetParams params) {
    return productRepository.updateProduct(params.product);
  }
}

class GetParams extends Equatable {
  final ProductEntity product;

  GetParams({required this.product});

  @override
  List<Object?> get props => [product];
}
