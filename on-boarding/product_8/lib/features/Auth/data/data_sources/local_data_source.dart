import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../model/auth_model.dart';
import '../model/token_model.dart';

abstract class AuthLocalDataSource {
  Future<TokenModel> getToken(AuthModel user);
  Future<void> cacheToken(AuthModel user, TokenModel token);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheToken(AuthModel user, TokenModel token) {
    return sharedPreferences.setString(
      user.email,
      json.encode(token),
    );
  }

  @override
  Future<TokenModel> getToken(AuthModel user) async {
    final jsonString = await sharedPreferences.getString(user.email);

    if (jsonString != null) {
      return Future.value(TokenModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
