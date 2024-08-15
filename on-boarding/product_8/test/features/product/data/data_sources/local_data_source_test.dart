import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/error/exception.dart';
import 'package:product_8/features/Product/data/data_sources/local_data_source.dart';
import 'package:product_8/features/Product/data/models/product_model.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';
import '../../../../helper/json_reader.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late ProductLocalDataSourceImpl productLocalDataSourceImpl;

  setUp(
    () {
      mockSharedPreferences = MockSharedPreferences();
      productLocalDataSourceImpl = ProductLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences,
      );
    },
  );
  const jsonurlAll = 'helper/dummy_data/cached_products.json';
  final products = List<ProductModel>.from(json
      .decode(readJson(jsonurlAll))
      .map((model) => ProductModel.fromJson(model)));
  group(
    'get products',
    () {
      test(
        'should return cached products if available',
        () async {
          when(mockSharedPreferences.getString(any))
              .thenReturn(readJson(jsonurlAll));

          final result = await productLocalDataSourceImpl.getProducts();

          verify(mockSharedPreferences.getString('CACHED_PRODUCTS'));
          expect(result, products);
        },
      );

      test(
        'should throw CacheException where there is not a cached value',
        () async {
          when(mockSharedPreferences.getString(any)).thenReturn(null);

          expect(
            () => productLocalDataSourceImpl.getProducts(),
            throwsA(isA<CacheException>()),
          );
        },
      );
    },
  );

  group(
    'cache products',
    () {
      test(
        'should call shared preferences to cache a products',
        () async {
          when(mockSharedPreferences.setString(
                  'CACHED_PRODUCTS', json.encode(products)))
              .thenAnswer((_) async => true);

          productLocalDataSourceImpl.cacheProduct(products);

          verify(mockSharedPreferences.setString(
              'CACHED_PRODUCTS', json.encode(products)));
        },
      );
    },
  );
}
