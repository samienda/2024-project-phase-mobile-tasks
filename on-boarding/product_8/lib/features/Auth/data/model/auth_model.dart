import '../../domain/entities/auth.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required super.name,
    required super.email,
    required super.password,
    required super.confirmPassword,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        confirmPassword: json['confirmPassword'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };

  AuthEntity toEntity() => AuthEntity(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
}
