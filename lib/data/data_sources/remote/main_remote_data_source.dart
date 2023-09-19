import 'package:dio/dio.dart';

import '../../../app/exceptions.dart';
import '../../network/main/main_api_service_client.dart';
import '../../responses/home_data_response.dart';

abstract class MainRemoteDataSource {
  Future<HomeDataGetResponse> getHomeData();
}

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  final MainApiServiceClient _mainApiServiceClient;

  MainRemoteDataSourceImpl({required MainApiServiceClient mainApiServiceClient})
      : _mainApiServiceClient = mainApiServiceClient;

  @override
  Future<HomeDataGetResponse> getHomeData() async {
    try {
      final res = await _mainApiServiceClient.getHomeData();
      return res;
    } on DioException catch (dioError) {
      throw NetworkException()..message = dioError.toString();
    } catch (unExpectedError) {
      throw UnknownException();
    }
  }
}
