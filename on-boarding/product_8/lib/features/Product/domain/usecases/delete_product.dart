import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProductUseCase implements Usecase<void, DeleteParams> {
  final ProductRepository productRepository;
  const DeleteProductUseCase(this.productRepository);

  
  
  @override
  Future<Either<Failure, void>> call(DeleteParams params) {
    return productRepository.deleteProduct(params.id);
 
  }
  
}

class DeleteParams extends Equatable {
  final String id;

  DeleteParams({required this.id});

  @override
  List<Object?> get props => [id];
}
