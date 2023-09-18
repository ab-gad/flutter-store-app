import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/app_constants.dart';
import 'package:flutter_store_app/data/responses/forgot_password_response.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';
import 'package:retrofit/http.dart';

part 'auth_api_service_client.g.dart';

@RestApi(baseUrl: AppConstants.baseApiUrl)
abstract class AuthApiServiceClient {
  factory AuthApiServiceClient(Dio dio, {String baseUrl}) =
      _AuthApiServiceClient;

  //! Without specifying the return type [LoginResponse] nothing will be generated
  @POST('customer/login')
  Future<LoginResponse> login(
    //! [@Field] decorator is a must to assign fields to the request body
    //! If the name that u need to send with body is different from the param name, specify the request param name in decorator function
    @Field() String email,
    @Field() String password,
  );

  @POST('customer/forgotPassword')
  Future<ForgotPasswordResponse> forgotPassword(
    @Field() String email,
  );

  @POST('customer/register')
  Future<LoginResponse> register(
    @Field('email') String email,
    @Field('user_name') String userName,
    @Field('password') String password,
    @Field('mobile_number') String mobilNumber,
    @Field('profile_picture') String profilePicture,
    @Field('country_mobile_code') String countryMobileCode,
  );
}
