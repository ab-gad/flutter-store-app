import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_store_app/app/app_constants.dart';
import 'package:flutter_store_app/data/network/network_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Dio get getDio {
    const headers = {
      HttpHeaders.acceptHeader: Headers.jsonContentType,
      HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      HttpHeaders.authorizationHeader: 'Token',
      // Based on user prefs, u can ask the server to provide u with specific lang document
      // u can send multiple langs
      HttpHeaders.acceptLanguageHeader: AppConstants.englishCode,
    };
    final options = BaseOptions(
      baseUrl: AppConstants.baseApiUrl, // Optional bc we use retrofit
      headers: headers,
      receiveTimeout: NetworkConstants.sendTimeOut,
      sendTimeout: NetworkConstants.receiveTimeOut,
    );
    final dio = Dio(options);
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
