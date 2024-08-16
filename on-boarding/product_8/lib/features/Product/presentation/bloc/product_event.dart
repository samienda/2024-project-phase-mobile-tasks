import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetSingleProductEvent extends ProductEvent {
  final String id;

  GetSingleProductEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class LoadAllProductEvent extends ProductEvent {
  LoadAllProductEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;

  UpdateProductEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;

  DeleteProductEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class InsertProductEvent extends ProductEvent {
  final ProductEntity product;

  InsertProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}
