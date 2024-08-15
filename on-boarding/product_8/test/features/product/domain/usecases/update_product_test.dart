import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/error/failure.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';
import 'package:product_8/features/Product/domain/usecases/update_product.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late UpdateProductUseCase updateProductUseCase;

  setUp(
    () {
      mockProductRepository = MockProductRepository();
      updateProductUseCase = UpdateProductUseCase(mockProductRepository);
    },
  );

  const oldProduct = ProductEntity(
    id: '1',
    name: 'T-Shirt',
    price: .99,
    description: 'A comfortable cotton t-shirt',
    imageUrl: 'image',
  );

  const newProduct = ProductEntity(
    id: '1',
    name: 'T-Shirt',
    price: .99,
    description: 'A comfortable cotton t-shirt',
    imageUrl: 'image',
  );

  test(
    'should return the updated product',
    () async {
      when(mockProductRepository.updateProduct(oldProduct)).thenAnswer(
        (_) async => const Right(newProduct),
      );

      final result =
          await updateProductUseCase.call(GetParams(product: newProduct));

      expect(result, const Right(newProduct));
    },
  );

  const serverFailure = ServerFailure('failed');

  test(
    'should return failure in when there is a failure',
    () async {
      when(mockProductRepository.updateProduct(newProduct)).thenAnswer(
        (_) async => const Left(serverFailure),
      );

      final result =
          await updateProductUseCase.call(GetParams(product: newProduct));

      expect(result, const Left(serverFailure));
    },
  );
}
