import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getOneProduct(String id);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> insertProduct(ProductModel product);
  Future<ProductModel> updateProduct(String id, ProductModel product);
  Future<Unit> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getOneProduct(String id) async {
    final response = await client.get(Uri.parse(Urls.getOneProduct('1')));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse(Urls.getProducts()));

    if (response.statusCode == 200) {
      return List<ProductModel>.from(json
          .decode(response.body)
          .map((model) => ProductModel.fromJson(model)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(ProductModel product) async {
    final response =
        await client.post(Uri.parse(Urls.insertProduct()), body: product);

    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(String id, ProductModel product) async {
    final response =
        await client.put(Uri.parse(Urls.updateProduct('1')), body: product);

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse(Urls.deleteProduct(id)));

    if (response.statusCode == 204) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
