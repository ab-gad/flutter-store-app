import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/exceptions.dart';
import 'package:flutter_store_app/data/network/api_service_client.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';

abstract class AuthenticationRemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginData);
}

// retrofit implementor
class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final ApiServiceClient _retrofitServiceClient;

  AuthenticationRemoteDataSourceImpl(
      {required ApiServiceClient retrofitServiceClient})
      : _retrofitServiceClient = retrofitServiceClient;

  @override
  Future<LoginResponse> login(LoginRequest loginData) async {
    try {
      return await _retrofitServiceClient.login(
        loginData.email,
        loginData.password,
      );
    } on DioException catch (dioError) {
      throw NetworkException().message = dioError.toString();
    } catch (unExpectedError) {
      throw UnknownException();
    }
  }
}
