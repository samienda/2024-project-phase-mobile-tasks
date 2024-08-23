import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/auth.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase extends Usecase<Unit, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, Unit>> call(LoginParams params) {
    return authRepository.login(params.user);
  }
}

class LoginParams extends Equatable {
  final AuthEntity user;

  LoginParams({required this.user});

  @override
  List<Object?> get props => [user];
}
