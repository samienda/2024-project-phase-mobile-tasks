import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/error/failure.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';
import 'package:product_8/features/Product/domain/usecases/insert_product.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late InsertProductUseCase insertProductUseCase;
  late MockProductRepository mockProductRepository;

  setUp(
    () {
      mockProductRepository = MockProductRepository();
      insertProductUseCase = InsertProductUseCase(mockProductRepository);
    },
  );

  const testProduct = ProductEntity(
    id: '1',
    name: 'T-Shirt',
    price: .99,
    description: 'A comfortable cotton t-shirt',
    imageUrl: 'image',
  );

  test(
    ('should insert a new product to the product collection'),
    () async {
      when(mockProductRepository.insertProduct(testProduct)).thenAnswer(
        (_) async => const Right(testProduct),
      );

      final result = await insertProductUseCase.insertProduct(testProduct);

      expect(result, const Right(testProduct));
    },
  );

  const serverFailure = ServerFailure('failed');

  test(
    'should return failure in when there is a failure',
    () async {
      when(mockProductRepository.insertProduct(testProduct)).thenAnswer(
        (_) async => const Left(serverFailure),
      );

      final result = await insertProductUseCase.insertProduct(testProduct);

      expect(result, const Left(serverFailure));
    },
  );
}
