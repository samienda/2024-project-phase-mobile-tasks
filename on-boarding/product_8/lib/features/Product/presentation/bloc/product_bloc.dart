import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_one_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/insert_product.dart';
import '../../domain/usecases/update_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetOneProductUseCase getOneProductUseCase;
  final GetProductsUseCase getProductsUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final InsertProductUseCase insertProductUseCase;

  ProductBloc(
  {
    required this.getOneProductUseCase,
    required this.getProductsUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
    required this.insertProductUseCase,
  }) : super(IntialState()) {
    on<GetSingleProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result =
            await getOneProductUseCase.call(GetParams(id: event.id));
        result.fold(
          (failure) {
            emit(ProductLoadFailure(failure.message));
          },
          (data) {
            emit(LoadedSingleProductState(data));
          },
        );
      },
      transformer: debounce(const Duration(microseconds: 500)),
    );

    on<LoadAllProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result = await getProductsUseCase.call(NoParams());
        result.fold(
          (failure) {
            emit(ProductLoadFailure(failure.message));
          },
          (data) {
            emit(LoadedAllProductState(data));
          },
        );
      },
      transformer: debounce(const Duration(microseconds: 500)),
    );

    on<UpdateProductEvent>(
      (event, emit) async {
        emit(ProductUpdating());
        final result = await updateProductUseCase
            .call(UpdateParams(product: event.product));
        result.fold(
          (failure) {
            emit(ProductUpdatedFailure(failure.message));
          },
          (data) {
            emit(ProductUpdated(data));
          },
        );
      },
      transformer: debounce(const Duration(microseconds: 500)),
    );

    on<DeleteProductEvent>((event, emit) async {
      emit(ProductDeleting());
      final result =
          await deleteProductUseCase.call(DeleteParams(id: event.id));

      result.fold((failure) {
        emit(ProductDeletedFailure(failure.message));
      }, (data) {
        emit(ProductDeleted());
      });
    }, transformer: debounce(const Duration(microseconds: 500)));

    on<InsertProductEvent>((event, emit) async {
      emit(ProductInserting());
      final result =
          await insertProductUseCase
          .call(InsertParams(product: event.product));
      
      result.fold(
        (failure) => emit(ProductInsertedFailure(failure.message)),
        (data) => emit(ProductInserted(data)),
      );
    }, transformer: debounce(const Duration(microseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
