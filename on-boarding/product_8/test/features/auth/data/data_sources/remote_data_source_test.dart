import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:product_8/core/constants/constants.dart';
import 'package:product_8/core/error/exception.dart';
import 'package:product_8/features/Auth/data/data_sources/remote_data_source.dart';
import 'package:product_8/features/Auth/data/model/auth_model.dart';
import 'package:product_8/features/Auth/data/model/token_model.dart';

import '../../../../helper/dummy_data/test_helper.mocks.dart';
import '../../../../helper/json_reader.dart';

void main() async {
  late MockHttpClient mockHttpClient;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  setUp(
    () {
      mockHttpClient = MockHttpClient();
      authRemoteDataSourceImpl =
          AuthRemoteDataSourceImpl(client: mockHttpClient);
    },
  );
  AuthModel testUser = AuthModel(
    name: 'name',
    email: 'email',
    password: 'password',
    confirmPassword: 'confirmPassword',
  );

  String tokenUrl = 'helper/dummy_data/token_data.json';

  group(
    'login',
    () {
      test(
        'should return a token when the response code is 201',
        () async {
          when(mockHttpClient.post(Uri.parse(Urls.login()),
                  body: testUser.toJson()))
              .thenAnswer(
            (_) async => http.Response(readJson(tokenUrl), 201),
          );

          final result = await authRemoteDataSourceImpl.login(testUser);

          expect(result,
              TokenModel.fromJson(json.decode(readJson(tokenUrl))['data']));
        },
      );

      test(
        'should throw an exception when the response code is 401',
        () async {
          when(mockHttpClient.post(Uri.parse(Urls.login()),
                  body: testUser.toJson()))
              .thenAnswer(
            (_) async => http.Response(readJson(tokenUrl), 401),
          );

          expect(() => authRemoteDataSourceImpl.login(testUser),
              throwsA(isA<UnAuthorizedException>()));
        },
      );
    },
  );
}
