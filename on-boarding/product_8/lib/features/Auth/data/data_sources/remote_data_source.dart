import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../model/auth_model.dart';
import '../model/token_model.dart';

abstract class AuthRemoteDataSource {
  Future<TokenModel> login(AuthModel user);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<TokenModel> login(AuthModel user) async {
    final response = await client.post(
      Uri.parse(Urls.login()),
      body: user.toJson(),
    );

    if (response.statusCode == 201) {
      return TokenModel.fromJson(json.decode(response.body)['data']);
    } else if (response.statusCode == 401) {
      throw UnAuthorizedException();
    } else {
      throw ServerException();
    }
  }
}
