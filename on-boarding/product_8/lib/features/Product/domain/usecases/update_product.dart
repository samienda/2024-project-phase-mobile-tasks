import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUseCase extends Usecase<ProductEntity, UpdateParams> {
  final ProductRepository productRepository;
  UpdateProductUseCase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(UpdateParams params) {
    return productRepository.updateProduct(params.product);
  }
}

class UpdateParams extends Equatable {
  final ProductEntity product;

  UpdateParams({required this.product});

  @override
  List<Object?> get props => [product];
}
