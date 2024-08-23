import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(AuthEntity user);
}
