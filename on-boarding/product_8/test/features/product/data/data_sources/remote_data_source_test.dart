import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:product_8/core/constants/constants.dart';
import 'package:product_8/core/error/exception.dart';
import 'package:product_8/features/Product/data/data_sources/remote_data_source.dart';
import 'package:product_8/features/Product/data/models/product_model.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';
import '../../../../helper/json_reader.dart';

void main() async {

  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;

  setUp(
    () {
      mockHttpClient = MockHttpClient();
      productRemoteDataSourceImpl =
          ProductRemoteDataSourceImpl(client: mockHttpClient);
    },
  );


  const jsonurlSingle = 'helper/dummy_data/dummy_product_response.json';
  const jsonurlAll = 'helper/dummy_data/dummy_list_of_product_response.json';

  const testProduct = ProductModel(
    id: '1',
    name: 'T-Shirt',
    price: 99,
    description: 'A comfortable cotton t-shirt',
    imageUrl:
        'C:\\Users\\SAMI\\Documents\\2024-project-phase-mobile-tasks\\on-boarding\\product_8\\assets\\EDVAC.jpeg',
  );
  

  group('get one products', () {
    test(
      'should return a product when the reponse code is 200',
      () async {
        when(mockHttpClient.get(Uri.parse(Urls.getOneProduct('1')))).thenAnswer(
          (_) async => http.Response(
            readJson(jsonurlSingle),
            200,
          ),
        );
        final result = await productRemoteDataSourceImpl.getOneProduct('1');

        expect(result, isA<ProductModel>());
      },
    );

    test(
      'should throw server exception when the reponse code is 404',
      () async {
        when(mockHttpClient.get(Uri.parse(Urls.getOneProduct('1')))).thenAnswer(
          (_) async => http.Response(
            'Not found',
            404,
          ),
        );

        expect(() => productRemoteDataSourceImpl.getOneProduct('1'),
            throwsA(isA<ServerException>()));
      },
    );
  });

  group(
    'get all products',
    () {
      test(
        'should return a product when the reponse code is 200',
        () async {
          when(mockHttpClient.get(Uri.parse(Urls.getProducts()))).thenAnswer(
            (_) async => http.Response(
              readJson(jsonurlAll),
              200,
            ),
          );

          final result = await productRemoteDataSourceImpl.getProducts();

          expect(result, isA<List<ProductModel>>());
        },
      );

      test(
        'should throw a server exception when the reponse code is 404',
        () async {
          when(mockHttpClient.get(Uri.parse(Urls.getProducts()))).thenAnswer(
            (_) async => http.Response(
              'bad request ',
              400,
            ),
          );

          expect(() => productRemoteDataSourceImpl.getProducts(),
              throwsA(isA<ServerException>()));
        },
      );
    },
  );

  // group(
  //   'create a new product',
  //   () {
  //     test(
  //       'should return the created product when status code is 200',
  //       () async {
  //         when(mockHttpClient.post(Uri.parse(Urls.insertProduct()),
  //                 body: testProduct))
  //             .thenAnswer(
  //           (_) async => http.Response(
  //             readJson(jsonurlSingle),
  //             201,
  //           ),
  //         );

  //         final result =
  //             await productRemoteDataSourceImpl.insertProduct(testProduct);

  //         expect(result, isA<ProductModel>());
  //         expect(result.name, testProduct.name);
  //         expect(result.description, testProduct.description);
  //       },
  //     );

  //     test(
  //       'should return server exception  when status code is 400',
  //       () async {
  //         when(mockHttpClient.post(Uri.parse(Urls.insertProduct()),
  //                 body: testProduct))
  //             .thenAnswer(
  //           (_) async => http.Response(
  //             'bad Request',
  //             400,
  //           ),
  //         );

  //         expect(() => productRemoteDataSourceImpl.insertProduct(testProduct),
  //             throwsA(isA<ServerException>()));
  //       },
  //     );
  //   },
  // );

  group(
    'update product',
    () {
      test(
        'should return the updated product if the statuscode is 200',
        () async {
          when(mockHttpClient.put(
            Uri.parse(
              Urls.updateProduct(testProduct.id),
            ),
            body: jsonEncode({
              'name': testProduct.name,
              'description': testProduct.description,
              'price': testProduct.price,
            }),
            headers: {'Content-Type': 'application/json'},
          ))
              .thenAnswer(
            (_) async => http.Response(
              readJson(jsonurlSingle),
              200,
            ),
          );

          final result = await productRemoteDataSourceImpl.updateProduct(
              testProduct);

          expect(result, testProduct);
        },
      );

      test(
        'should return the server exception if the statuscode is 400',
        () async {
          when(mockHttpClient.put(Uri.parse(Urls.updateProduct(testProduct.id)),
            body: jsonEncode({
              'name': testProduct.name,
              'description': testProduct.description,
              'price': testProduct.price,
            }),
            headers: {'Content-Type': 'application/json'},
          ))
              .thenAnswer(
            (_) async => http.Response(
              'bad request',
              400,
            ),
          );

          expect(
              () =>
                  productRemoteDataSourceImpl.updateProduct(testProduct),
              throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'delete product',
    () {
      test(
        'should return an empty list if the status code is 204',
        () async {
          when(mockHttpClient.delete(Uri.parse(Urls.deleteProduct('1'))))
              .thenAnswer(
            (_) async => http.Response('[]', 200),
          );

          final result = await productRemoteDataSourceImpl.deleteProduct('1');

          expect(result, unit);
        },
      );

      test(
        'should return an server exception if the status code is 400',
        () async {
          when(mockHttpClient.delete(Uri.parse(Urls.deleteProduct('1'))))
              .thenAnswer(
            (_) async => http.Response('bad request', 400),
          );

          expect(productRemoteDataSourceImpl.deleteProduct('1'),
              throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
