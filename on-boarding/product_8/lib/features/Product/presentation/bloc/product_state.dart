import 'package:equatable/equatable.dart';

import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class IntialState extends ProductState {}

class LoadingState extends ProductState {}

class LoadedSingleProductState extends ProductState {
  final ProductEntity result;

  const LoadedSingleProductState(this.result);

  @override
  List<Object?> get props => [result];
}

class LoadedAllProductState extends ProductState {
  final List<ProductEntity> products;

  const LoadedAllProductState(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductLoadFailure extends ProductState {
  final String message;

  const ProductLoadFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductUpdated extends ProductState {
  final ProductEntity product;
  const ProductUpdated(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductUpdatedFailure extends ProductState {
  final String message;

  ProductUpdatedFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductUpdating extends ProductState {
  ProductUpdating();

  @override
  List<Object?> get props => [];
}

class ProductDeleted extends ProductState {
  ProductDeleted();

  @override
  List<Object?> get props => [];
}

class ProductDeleting extends ProductState {
  ProductDeleting();

  @override
  List<Object?> get props => [];
}

class ProductDeletedFailure extends ProductState {
  final String message;
  ProductDeletedFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductInserted extends ProductState {
  final ProductEntity product;

  ProductInserted(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductInsertedFailure extends ProductState {
  final String message;

  ProductInsertedFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductInserting extends ProductState {
  ProductInserting();

  @override
  List<Object?> get props => [];
}
