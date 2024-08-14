import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/error/exception.dart';
import 'package:product_8/core/error/failure.dart';
import 'package:product_8/features/Product/data/models/product_model.dart';
import 'package:product_8/features/Product/data/repositories/product_repository_impl.dart';
import 'package:product_8/features/Product/domain/entities/product.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late ProductRepositoryImpl productRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockProductLocalDataSource mockProductLocalDataSource;
  

  setUp(
    () {
      mockProductRemoteDataSource = MockProductRemoteDataSource();
      mockNetworkInfo = MockNetworkInfo();
      mockProductLocalDataSource = MockProductLocalDataSource();
      productRepositoryImpl =
          ProductRepositoryImpl(mockProductRemoteDataSource,
          mockNetworkInfo, mockProductLocalDataSource);
    },
  );

  const testProductModel = ProductModel(
    id: '1',
    name: 'T-Shirt',
    price: 0.99,
    description: 'A comfortable cotton t-shirt',
    imageUrl: 'image',
  );

  const testProductEntity = ProductEntity(
    id: '1',
    name: 'T-Shirt',
    price: .99,
    description: 'A comfortable cotton t-shirt',
    imageUrl: 'image',
  );

  group(
    'get a product',
    () {
      test(
        'should return product with the given id when a call to a data source is succesful',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));

          when(mockProductRemoteDataSource.getOneProduct('1')).thenAnswer(
            (_) async => testProductModel,
          );

          final result = await productRepositoryImpl.getOneProduct('1');

          expect(result, const Right(testProductEntity));
        },
      );


      test(
        'should return conection failure when a device is offline',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(false));

          when(mockProductRemoteDataSource.getOneProduct('1')).thenAnswer(
            (_) async => testProductModel,
          );

          final result = await productRepositoryImpl.getOneProduct('1');

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );


      test(
        'should return a server failure a call to a data source is unsuccesful',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.getOneProduct('1')).thenThrow(
            (ServerException()),
          );

          final result = await productRepositoryImpl.getOneProduct('1');

          expect(result, const Left(ServerFailure('An error has occured')));
        },
      );

      test(
        'should return a connection failure when a device has no internet',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.getOneProduct('1')).thenThrow(
            (const SocketException('Failed to connect to the network')),
          );

          final result = await productRepositoryImpl.getOneProduct('1');

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );
    },
  );

  List<ProductModel> testProductsModel = [
    const ProductModel(
        id: '1',
        name: 'T-Shirt',
        price: .99,
        description: 'A comfortable cotton t-shirt',
        imageUrl: 'image'),
    const ProductModel(
        id: '2',
        name: 'Jeans',
        price: 49.99,
        description: 'Stylish blue jeans',
        imageUrl: 'image'),
    const ProductModel(
        id: '3',
        name: 'Jacket',
        price: 89.99,
        description: 'Warm winter jacket',
        imageUrl: 'image'),
    const ProductModel(
        id: '4',
        name: 'Sneakers',
        price: 59.99,
        description: 'Casual sneakers for everyday wear',
        imageUrl: 'image'),
    const ProductModel(
        id: '5',
        name: 'Hat',
        price: 14.99,
        description: 'A trendy baseball cap',
        imageUrl: 'image'),
  ];

  List<ProductEntity> testProductsEntity = [
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

  group(
    'get all products ',
    () {
      test(
        'should return all products when call to data source is successfull',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));

          when(mockProductRemoteDataSource.getProducts())
              .thenAnswer((_) async => testProductsModel);

          final result = await productRepositoryImpl.getProducts();
          

          final unpackedResult =
              result.fold((failure) => null, (products) => products);
          expect(unpackedResult, testProductsEntity);
        },
      );


      test(
        'should return conection failure when a device is offline and there is no cached products',
        () async {
          when(mockProductLocalDataSource.getProducts())
              .thenThrow(CacheException());

          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(false));

          when(mockProductRemoteDataSource.getProducts())
              .thenAnswer((_) async => testProductsModel);

          final result = await productRepositoryImpl.getProducts();

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );

      
      test(
        'should return cached products when a device is offline if available',
        () async {
          when(mockProductLocalDataSource.getProducts())
              .thenAnswer((_) async => testProductsModel);

          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(false));

          when(mockProductRemoteDataSource.getProducts())
              .thenAnswer((_) async => testProductsModel);

          final result = await productRepositoryImpl.getProducts();

          final unpackedResult =
              result.fold((failure) => null, (products) => products);
          expect(unpackedResult, testProductsEntity);
        },
      );


      test(
        'should throw a server failure when call to data source is unsuccessfull',
        () async {
          when(mockProductLocalDataSource.getProducts())
              .thenThrow(CacheException());

          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));

          when(mockProductRemoteDataSource.getProducts()).thenThrow(
            (ServerException()),
          );

          final result = await productRepositoryImpl.getProducts();

          expect(result, const Left(ServerFailure('An error has occured')));
        },
      );

      test(
        'should return cached products when call to data source is unsuccessfull if available',
        () async {
          when(mockProductLocalDataSource.getProducts())
              .thenAnswer((_) async => testProductsModel);

          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));

          when(mockProductRemoteDataSource.getProducts()).thenThrow(
            (ServerException()),
          );

          final result = await productRepositoryImpl.getProducts();

          final unpackedResult =
              result.fold((failure) => null, (products) => products);
          expect(unpackedResult, testProductsEntity);
        },
      );

      test(
        'should throw a connection failure when the device is not connect to internet',
        () async {
          when(mockProductLocalDataSource.getProducts())
              .thenThrow(CacheException());

          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.getProducts()).thenThrow(
            (const SocketException('Failed to connect to the network')),
          );

          final result = await productRepositoryImpl.getProducts();

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));

        },
      );

      test(
        'should return a cached products when there is a socket exception',
        () async {
          when(mockProductLocalDataSource.getProducts())
              .thenAnswer((_) async => testProductsModel);

          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));

          when(mockProductRemoteDataSource.getProducts()).thenThrow(
            (const SocketException('Failed to connect to the network')),
          );

          final result = await productRepositoryImpl.getProducts();

          final unpackedResult =
              result.fold((failure) => null, (products) => products);
          expect(unpackedResult, testProductsEntity);
        },
      );
    },
  );

  group(
    'insert product',
    () {
      test(
        'should return the inserted product when a call to data source is successfull',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.insertProduct(testProductModel))
              .thenAnswer((_) async => testProductModel);

          final result =
              await productRepositoryImpl.insertProduct(testProductModel);

          expect(result, const Right(testProductEntity));
        },
      );

      test(
        'should return conection failure when a device is offline',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(false));

          when(mockProductRemoteDataSource.insertProduct(testProductModel))
              .thenAnswer((_) async => testProductModel);

          final result =
              await productRepositoryImpl.insertProduct(testProductModel);

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );

      test(
        'should throw a connection failure when the device is not connect to internet',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.insertProduct(testProductModel))
              .thenThrow(
                  const SocketException('Failed to connect to the network'));

          final result =
              await productRepositoryImpl.insertProduct(testProductModel);

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );
      test(
        'should throw a server failure when  a call to data source is unsuccessfull',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.insertProduct(testProductModel))
              .thenThrow(ServerException());

          final result =
              await productRepositoryImpl.insertProduct(testProductModel);

          expect(result, const Left(ServerFailure('An error has occured')));
        },
      );
    },
  );

  group(
    'update product',
    () {
      test(
        'should return the updated product when a call to data source is successfull',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));

          when(mockProductRemoteDataSource.updateProduct(testProductModel))
              .thenAnswer((_) async => testProductModel);

          final result =
              await productRepositoryImpl.updateProduct(testProductModel);

          expect(result, const Right(testProductEntity));
        },
      );

      test(
        'should return conection failure when a device is offline',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(false));

          when(mockProductRemoteDataSource.updateProduct(testProductModel))
              .thenAnswer((_) async => testProductModel);

          final result =
              await productRepositoryImpl.updateProduct(testProductModel);

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );

      test(
        'should throw a connection failure when the device is not connect to internet',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.updateProduct(testProductModel))
              .thenThrow(
                  const SocketException('Failed to connect to the network'));

          final result =
              await productRepositoryImpl.updateProduct(testProductModel);

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );
      test(
        'should throw a server failure when  a call to data source is unsuccessfull',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.updateProduct(testProductModel))
              .thenThrow(ServerException());

          final result =
              await productRepositoryImpl.updateProduct(testProductModel);

          expect(result, const Left(ServerFailure('An error has occured')));
        },
      );
    },
  );

  group(
    'delete product',
    () {
      test(
        'should return nothing when the call to data source is successfult',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));

          when(mockProductRemoteDataSource.deleteProduct('1'))
              .thenAnswer((_) async => unit);

          final result = await productRepositoryImpl.deleteProduct('1');

          expect(result, const Right(unit));
        },
      );

      test(
        'should return conection failure when a device is offline',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(false));

          when(mockProductRemoteDataSource.deleteProduct('1'))
              .thenAnswer((_) async => unit);

          final result = await productRepositoryImpl.deleteProduct('1');

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );

      test(
        'should throw a connection failure when the device is not connect to internet',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.deleteProduct('1')).thenThrow(
              const SocketException('Failed to connect to the network'));

          final result = await productRepositoryImpl.deleteProduct('1');

          expect(
              result,
              const Left(
                  ConnectionFailure('Failed to connect to the network')));
        },
      );
      test(
        'should throw a server failure when  a call to data source is unsuccessfull',
        () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((_) => Future.value(true));


          when(mockProductRemoteDataSource.deleteProduct('1'))
              .thenThrow(ServerException());

          final result = await productRepositoryImpl.deleteProduct('1');

          expect(result, const Left(ServerFailure('An error has occured')));
        },
      );
    },
  );
}
