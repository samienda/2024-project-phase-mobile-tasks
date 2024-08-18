import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetOneProductUseCase implements Usecase<ProductEntity, GetParams> {
  final ProductRepository productRepository;
  GetOneProductUseCase({required this.productRepository});

  
  @override
  Future<Either<Failure, ProductEntity>> call(GetParams params) {
    return productRepository.getOneProduct(params.id);
  }
}

class GetParams extends Equatable {
  final String id;

  GetParams({required this.id});

  @override
  List<Object?> get props => [id];
}
