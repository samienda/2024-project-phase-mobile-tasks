import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class InsertProductUseCase implements Usecase<ProductEntity, InsertParams> {
  final ProductRepository productRepository;
  InsertProductUseCase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(InsertParams params) {
    return productRepository.insertProduct(params.product);
  }
}

class InsertParams extends Equatable {
  final ProductEntity product;

  InsertParams({required this.product});

  @override
  List<Object?> get props => [product];
}
