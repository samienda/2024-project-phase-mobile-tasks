import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/error/failure.dart';
import 'package:product_8/features/Product/domain/usecases/delete_product.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late MockProductRepository mockProductRepository;
  late DeleteProductUseCase deleteProductUseCase;

  setUp(
    () {
      mockProductRepository = MockProductRepository();
      deleteProductUseCase = DeleteProductUseCase(productRepository:  mockProductRepository);
    },
  );

  test(
    'should delete the given product',
    () async {
      when(mockProductRepository.deleteProduct('1'))
          .thenAnswer((_) async => const Right(unit));

      final result = await deleteProductUseCase.call(DeleteParams(id: '1'));

      verify(deleteProductUseCase.call(DeleteParams(id: '1'))).called(1);
      expect(result, const Right(unit));
    },
  );

  const serverFailure = ServerFailure('failed');

  test(
    'should return failure in when there is a failure',
    () async {
      when(mockProductRepository.deleteProduct('1')).thenAnswer(
        (_) async => const Left(serverFailure),
      );

      final result = await deleteProductUseCase.call(DeleteParams(id: '1'));

      expect(result, const Left(serverFailure));
    },
  );
}
