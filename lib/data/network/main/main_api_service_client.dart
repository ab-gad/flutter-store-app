import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/app_constants.dart';
import 'package:flutter_store_app/data/responses/home_data_response.dart';
import 'package:retrofit/http.dart';

part 'main_api_service_client.g.dart';

@RestApi(baseUrl: AppConstants.baseApiUrl)
abstract class MainApiServiceClient {
  factory MainApiServiceClient(Dio dio, {String baseUrl}) =
      _MainApiServiceClient;

  @GET('home')
  Future<HomeDataGetResponse> getHomeData();
}
