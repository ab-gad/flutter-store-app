import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/app_constants.dart';
import 'package:flutter_store_app/data/responses/login_response.dart';
import 'package:retrofit/http.dart';

part 'api_service_client.g.dart';

@RestApi(baseUrl: AppConstants.baseApiUrl)
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;

  //! Without specifying the return type [LoginResponse] nothing will be generated
  @POST('customer/login')
  Future<LoginResponse> login(
    //! [@Field] decorator is a must to assign fields to the request body
    //! If the name that u need to send with body is different from the param name, specify the request param name in decorator function
    @Field() String email,
    @Field() String password,
  );
}
