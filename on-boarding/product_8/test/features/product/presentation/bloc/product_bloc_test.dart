import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/error/failure.dart';
import 'package:product_8/core/usecase/usecase.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';
import 'package:product_8/features/Product/domain/usecases/delete_product.dart';
import 'package:product_8/features/Product/domain/usecases/get_one_product.dart';
import 'package:product_8/features/Product/domain/usecases/insert_product.dart';
import 'package:product_8/features/Product/domain/usecases/update_product.dart';
import 'package:product_8/features/Product/presentation/bloc/product_bloc.dart';
import 'package:product_8/features/Product/presentation/bloc/product_event.dart';
import 'package:product_8/features/Product/presentation/bloc/product_state.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late MockGetOneProductUseCase mockGetOneProductUseCase;
  late MockGetProductsUseCase mockGetProductsUseCase;
  late MockUpdateProductUseCase mockUpdateProductUseCase;
  late MockDeleteProductUseCase mockDeleteProductUseCase;
  late MockInsertProductUseCase mockInsertProductUseCase;
  late ProductBloc productBloc;

  setUp(
    () {
      mockGetOneProductUseCase = MockGetOneProductUseCase();
      mockGetProductsUseCase = MockGetProductsUseCase();
      mockUpdateProductUseCase = MockUpdateProductUseCase();
      mockDeleteProductUseCase = MockDeleteProductUseCase();
      mockInsertProductUseCase = MockInsertProductUseCase();
      productBloc = ProductBloc(
        mockGetOneProductUseCase,
        mockGetProductsUseCase,
        mockUpdateProductUseCase,
        mockDeleteProductUseCase,
        mockInsertProductUseCase,
      );
    },
  );

  const testProduct = ProductEntity(
    id: '1',
    name: 'T-Shirt',
    price: .99,
    description: 'A comfortable cotton t-shirt',
    imageUrl: 'image',
  );

  List<ProductEntity> testProducts = [
    const ProductEntity(
        id: '1',
        name: 'T-Shirt',
        price: .99,
        description: 'A comfortable cotton t-shirt',
        imageUrl: 'image'),
    const ProductEntity(
        id: '2',
        name: 'Jeans',
        price: 49.99,
        description: 'Stylish blue jeans',
        imageUrl: 'image'),
    const ProductEntity(
        id: '3',
        name: 'Jacket',
        price: 89.99,
        description: 'Warm winter jacket',
        imageUrl: 'image'),
    const ProductEntity(
        id: '4',
        name: 'Sneakers',
        price: 59.99,
        description: 'Casual sneakers for everyday wear',
        imageUrl: 'image'),
    const ProductEntity(
        id: '5',
        name: 'Hat',
        price: 14.99,
        description: 'A trendy baseball cap',
        imageUrl: 'image'),
  ];

  test(
    'intial state should be empty',
    () {
      expect(productBloc.state, IntialState());
    },
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [product loading , product loaded ] when data is gotten successfully',
    build: () {
      when(mockGetOneProductUseCase.call(GetParams(id: '1'))).thenAnswer(
        (_) async => const Right(testProduct),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(GetSingleProductEvent(id: '1')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoadingState(),
      const LoadedSingleProductState(testProduct),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [product loading , product load Failure ] when get data is  unsuccessfull',
    build: () {
      when(mockGetOneProductUseCase.call(GetParams(id: '1'))).thenAnswer(
        (_) async => const Left(ServerFailure('server failure')),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(GetSingleProductEvent(id: '1')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoadingState(),
      const ProductLoadFailure('server failure'),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [product loading , products loaded ] when data is gotten successfully',
    build: () {
      when(mockGetProductsUseCase.call(NoParams())).thenAnswer(
        (_) async => Right(testProducts),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(LoadAllProductEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoadingState(),
      LoadedAllProductState(testProducts),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [product loading , product load failure ] when data is not gotten successfully',
    build: () {
      when(mockGetProductsUseCase.call(NoParams())).thenAnswer(
        (_) async => const Left(ServerFailure('server failure')),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(LoadAllProductEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoadingState(),
      const ProductLoadFailure('server failure'),
    ],
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [productupdateloading, productupdated] when data is updated successfully',
    build: () {
      when(mockUpdateProductUseCase.call(UpdateParams(product: testProduct)))
          .thenAnswer(
        (_) async => const Right(testProduct),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(
      UpdateProductEvent(product: testProduct),
    ),
    wait: const Duration(microseconds: 500),
    expect: () => {
      ProductUpdating(),
      const ProductUpdated(testProduct),
    },
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [productupdateloading, productupdatedfailure] when data is not updated successfully',
    build: () {
      when(mockUpdateProductUseCase.call(UpdateParams(product: testProduct)))
          .thenAnswer(
        (_) async => const Left(ServerFailure('server failure')),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(
      UpdateProductEvent(product: testProduct),
    ),
    wait: const Duration(microseconds: 500),
    expect: () => {
      ProductUpdating(),
      ProductUpdatedFailure('server failure'),
    },
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [productdeleteloading, productdeleted] when data is  deleted successfully',
    build: () {
      when(mockDeleteProductUseCase.call(DeleteParams(id: '1'))).thenAnswer(
        (_) async => const Right(unit),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(
      DeleteProductEvent(id: '1'),
    ),
    wait: const Duration(microseconds: 500),
    expect: () => {
      ProductDeleting(),
      ProductDeleted(),
    },
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [productdeleteloading, productdeletedFailue] when data is not deleted successfully',
    build: () {
      when(mockDeleteProductUseCase.call(DeleteParams(id: '1'))).thenAnswer(
        (_) async => const Left(ServerFailure('server failure')),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(
      DeleteProductEvent(id: '1'),
    ),
    wait: const Duration(microseconds: 500),
    expect: () => {
      ProductDeleting(),
      ProductDeletedFailure('server failure'),
    },
  );
  blocTest<ProductBloc, ProductState>(
    'should emit [productinserting, productinserted] when data is  inserted successfully',
    build: () {
      when(mockInsertProductUseCase.call(InsertParams(product: testProduct)))
          .thenAnswer(
        (_) async => const Right(testProduct),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(
      InsertProductEvent(testProduct),
    ),
    wait: const Duration(microseconds: 500),
    expect: () => {
      ProductInserting(),
      ProductInserted(testProduct),
    },
  );

  blocTest<ProductBloc, ProductState>(
    'should emit [productinserting, productinsertedFailue] when data is not inserted successfully',
    build: () {
      when(mockInsertProductUseCase.call(InsertParams(product: testProduct)))
          .thenAnswer(
        (_) async => const Left(ServerFailure('server failure')),
      );

      return productBloc;
    },
    act: (bloc) => bloc.add(
      InsertProductEvent(testProduct),
    ),
    wait: const Duration(microseconds: 500),
    expect: () => {
      ProductInserting(),
      ProductInsertedFailure('server failure'),
    },
  );
}
