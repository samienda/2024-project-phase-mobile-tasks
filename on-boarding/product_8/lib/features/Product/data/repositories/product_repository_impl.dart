import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/remote_data_source.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await productRemoteDataSource.deleteProduct(id);
      return const Right(unit);
    } on ServerException {
      return const Left(ServerFailure('An error has occured'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getOneProduct(String id) async {
    try {
      final result = await productRemoteDataSource.getOneProduct(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occured'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final result = await productRemoteDataSource.getProducts();
      return Right(
        (result.map((product) => product.toEntity())).toList(),
      );
    } on ServerException {
      return const Left(ServerFailure('An error has occured'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> insertProduct(
      ProductEntity product) async {
    try {
      final result =
          await productRemoteDataSource.insertProduct(product.toModel());

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occured'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
      ProductEntity product) async {
    try {
      final result =
          await productRemoteDataSource.updateProduct(product.toModel());
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occured'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
