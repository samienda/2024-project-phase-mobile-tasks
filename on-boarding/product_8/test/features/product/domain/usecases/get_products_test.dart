import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/error/failure.dart';
import 'package:product_8/core/usecase/usecase.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';
import 'package:product_8/features/Product/domain/usecases/get_products.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late GetProductsUseCase getProductsUseCase;
  late MockProductRepository mockProductRepository;

  setUp(
    () {
      mockProductRepository = MockProductRepository();
      getProductsUseCase =
          GetProductsUseCase(productRepository: mockProductRepository);
    },
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
    'should get current products from repository',
    () async {
      when(mockProductRepository.getProducts())
          .thenAnswer((_) async => Right(testProducts));

      final result = await getProductsUseCase.call(NoParams());

      expect(result, Right(testProducts));
    },
  );

  const serverFailure = ServerFailure('failed');

  test(
    'should return failure in when there is a failure',
    () async {
      when(mockProductRepository.getProducts()).thenAnswer(
        (_) async => const Left(serverFailure),
      );

      final result = await getProductsUseCase.call(NoParams());

      expect(result, const Left(serverFailure));
    },
  );
}
