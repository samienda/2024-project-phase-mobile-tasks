import 'package:equatable/equatable.dart';

class TokenModel extends Equatable {
  final String access_token;

  TokenModel({required this.access_token});

  @override
  List<Object?> get props => [access_token];

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        access_token: json['access_token'],
      );
}
