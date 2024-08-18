import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final NetworkInfo networkInfo;
  final ProductLocalDataSource productLocalDataSourcel;

  ProductRepositoryImpl(
{
    required this.productRemoteDataSource,
    required this.networkInfo,
    required this.productLocalDataSourcel,
  }
  );

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.deleteProduct(id);
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure('An error has occured'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    }
    return const Left(ConnectionFailure('Failed to connect to the network'));
  }

  @override
  Future<Either<Failure, ProductEntity>> getOneProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productRemoteDataSource.getOneProduct(id);
        return Right(result.toEntity());
      } on ServerException {
        return const Left(ServerFailure('An error has occured'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    }
    return const Left(ConnectionFailure('Failed to connect to the network'));
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await productRemoteDataSource.getProducts();
        productLocalDataSourcel.cacheProduct(result);
        return Right(
          (result.map((product) => product.toEntity())).toList(),
        );
      } on ServerException {
        try {
          final result = await productLocalDataSourcel.getProducts();

          return Right(
            (result.map((product) => product.toEntity())).toList(),
          );
        } on CacheException {
          return const Left(ServerFailure('An error has occured'));
        }
      } on SocketException {
        try {
          final result = await productLocalDataSourcel.getProducts();

          return Right(
            (result.map((product) => product.toEntity())).toList(),
          );
        } on CacheException {
          return const Left(
              ConnectionFailure('Failed to connect to the network'));
        }
      }
    } else {
      try {
        final result = await productLocalDataSourcel.getProducts();

        return Right(
          (result.map((product) => product.toEntity())).toList(),
        );
      } on CacheException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> insertProduct(
      ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await productRemoteDataSource.insertProduct(product.toModel());

        return Right(result.toEntity());
      } on ServerException {
        return const Left(ServerFailure('An error has occured'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    }
    return const Left(ConnectionFailure('Failed to connect to the network'));
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
      ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await productRemoteDataSource.updateProduct(product.toModel());
        return Right(result.toEntity());
      } on ServerException {
        return const Left(ServerFailure('An error has occured'));
      } on SocketException {
        return const Left(
            ConnectionFailure('Failed to connect to the network'));
      }
    }
    return const Left(ConnectionFailure('Failed to connect to the network'));
  }
}
