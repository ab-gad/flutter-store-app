import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/exceptions.dart';
import 'package:flutter_store_app/data/network/authentication/auth_api_service_client.dart';
import 'package:flutter_store_app/data/requests/fogot_password_request.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/data/requests/register_request.dart';
import 'package:flutter_store_app/data/responses/forgot_password_response.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';

abstract class AuthenticationRemoteDataSource {
  Future<LoginResponse> register(RegisterRequest registerData);
  Future<LoginResponse> login(LoginRequest loginData);
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordData);
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

  @override
  Future<ForgotPasswordResponse> forgotPassword(
      ForgotPasswordRequest forgotPasswordData) async {
    try {
      var res = await _retrofitServiceClient.forgotPassword(
        forgotPasswordData.email,
      );
      return res;
    } on DioException catch (dioError) {
      throw NetworkException()..message = dioError.toString();
    } catch (unExpectedError) {
      throw UnknownException();
    }
  }

  @override
  Future<LoginResponse> register(RegisterRequest registerData) async {
    try {
      var res = await _retrofitServiceClient.register(
        registerData.email,
        registerData.userName,
        registerData.password,
        registerData.mobileNumber,
        registerData.profilePicture,
        registerData.countryMobileCode,
      );
      return res;
    } on DioException catch (dioError) {
      throw NetworkException()..message = dioError.toString();
    } catch (unExpectedError) {
      throw UnknownException();
    }
  }
}
