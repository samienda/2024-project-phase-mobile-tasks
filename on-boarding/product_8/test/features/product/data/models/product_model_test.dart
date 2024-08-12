import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_8/features/Product/data/models/product_model.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';

import '../../../../helper/json_reader.dart';

void main() {
  const testProduct = ProductModel(
    id: '1',
    name: 'T-Shirt',
    price: 0.99,
    description: 'A comfortable cotton t-shirt',
    imageUrl: 'image',
  );

  test(
    'the product models should be subclass of the product entity',
    () {
      expect(testProduct, isA<ProductEntity>());
    },
  );

  test(
    'should return a valid model from json',
    () async {
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helper/dummy_data/dummy_product_response.json'),
      );

      final result = ProductModel.fromJson(jsonMap);

      expect(result, equals(testProduct));
    },
  );

  test(
    'should return a json map containing proper data',
    () async {
      final result = testProduct.toJson();

      final jsonProduct = {
        'id': '1',
        'name': 'T-Shirt',
        'price': 0.99,
        'description': 'A comfortable cotton t-shirt',
        'imageUrl': 'image'
      };

      expect(result, jsonProduct);
    },
  );
}
