import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/exceptions.dart';
import 'package:flutter_store_app/data/network/authentication/auth_api_service_client.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';

abstract class AuthenticationRemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginData);
}

// retrofit implementor
class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final AuthApiServiceClient _retrofitServiceClient;

  AuthenticationRemoteDataSourceImpl(
      {required AuthApiServiceClient retrofitServiceClient})
      : _retrofitServiceClient = retrofitServiceClient;

  @override
  Future<LoginResponse> login(LoginRequest loginData) async {
    try {
      var res = await _retrofitServiceClient.login(
        loginData.email,
        loginData.password,
      );
      return res;
    } on DioException catch (dioError) {
      throw NetworkException()..message = dioError.toString();
    } catch (unExpectedError) {
      throw UnknownException();
    }
  }
}
