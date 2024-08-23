import 'package:equatable/equatable.dart';

import '../../domain/entities/auth.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final AuthEntity user;

  LoginEvent({required this.user});

  @override
  List<Object?> get props => [user];
}
