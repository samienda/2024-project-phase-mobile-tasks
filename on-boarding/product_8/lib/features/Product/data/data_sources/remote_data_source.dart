import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getOneProduct(String id);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> insertProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<Unit> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<ProductModel> getOneProduct(String id) async {
    final response = await client.get(Uri.parse(Urls.getOneProduct(id)));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get(Uri.parse(Urls.getProducts()));

    if (response.statusCode == 200) {
      return List<ProductModel>.from(json
          .decode(response.body)['data']
          .map((model) => ProductModel.fromJson(model)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> insertProduct(ProductModel product) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.insertProduct()),
    );
    request.fields.addAll(
      {
        'name': product.name,
        'description': product.description,
        'price': '${product.price}',
      },
    );
    request.files.add(await http.MultipartFile.fromPath(
        'image', product.imageUrl,
        contentType: MediaType('image', 'jpeg')));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      final body = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await client.put(
      Uri.parse(Urls.updateProduct(product.id)),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse(Urls.deleteProduct(id)));

    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
