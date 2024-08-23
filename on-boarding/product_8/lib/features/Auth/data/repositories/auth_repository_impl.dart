import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> login(AuthEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authRemoteDataSource.login(user.toModel());
        authLocalDataSource.cacheToken(user.toModel(), result);
        return const Right(unit);
      } on UnAuthorizedException {
        return const Left(UnAuthorizedFailure('invalid password or email'));
      } on ServerException {
        try {
          await authLocalDataSource.getToken(user.toModel());
          return const Right(unit);
        } on CacheException {
          return const Left(UnAuthorizedFailure('login attempt failed'));
        }
      } on SocketException {
        await authLocalDataSource.getToken(user.toModel());
        return const Right(unit);
      } on CacheException {
        return const Left(UnAuthorizedFailure('login attempt failed'));
      }
    } else {
      try {
        await authLocalDataSource.getToken(user.toModel());
        return const Right(unit);
      } on CacheException {
        return const Left(UnAuthorizedFailure('login attempt failed'));
      }
    }
  }
}
