import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/app_constants.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';
import 'package:retrofit/http.dart';

part 'api_service_client.g.dart';

@RestApi(baseUrl: AppConstants.baseApiUrl)
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;

  @POST('customer/login')
  Future<LoginResponse> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}
