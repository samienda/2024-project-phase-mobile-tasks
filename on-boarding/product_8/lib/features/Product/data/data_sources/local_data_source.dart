import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> cacheProduct(List<ProductModel> products);
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  ProductLocalDataSourceImpl({required this.sharedPreferences});

  final CACHED_PRODUCTS = 'CACHED_PRODUCTS';

  @override
  Future<List<ProductModel>> getProducts() async {
    final jsonString = await sharedPreferences.getString(CACHED_PRODUCTS);

    if (jsonString != null) {
      return Future.value(List<ProductModel>.from(json
          .decode(jsonString)
          .map((model) => ProductModel.fromJson(model))));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProduct(List<ProductModel> products) {
    return sharedPreferences.setString(
      CACHED_PRODUCTS,
      json.encode(products),
    );
  }
}
