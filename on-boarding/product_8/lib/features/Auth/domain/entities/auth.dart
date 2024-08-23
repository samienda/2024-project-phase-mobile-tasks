import 'package:equatable/equatable.dart';

import '../../data/model/auth_model.dart';

class AuthEntity extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  AuthEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  AuthModel toModel() => AuthModel(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

  @override
  List<Object?> get props => [name, email, password, confirmPassword];
}
