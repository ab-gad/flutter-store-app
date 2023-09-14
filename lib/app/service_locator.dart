import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/app_prefs_repository.dart';
import 'package:flutter_store_app/data/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_store_app/data/data_sources/local_data_source.dart';
import 'package:flutter_store_app/data/network/authentication/auth_api_service_client.dart';
import 'package:flutter_store_app/data/network/dio_factory.dart';
import 'package:flutter_store_app/data/network/network_info.dart';
import 'package:flutter_store_app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:flutter_store_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_store_app/domain/usecases/login_usecase.dart';
import 'package:flutter_store_app/presentation/login/view_model/login_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  //*======================================================
  //* ---------------------[Core]------------------------
  //*======================================================
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<AppPrefsRepository>(
      () => AppPrefsRepositoryImpl(sl()));

  sl.registerLazySingleton<LocalDataSources>(() => LocalDataSourcesImpl(sl()));

  //*======================================================
  //* ------------------[External]------------------------
  //*======================================================
  // Share preferences (local data source implementor)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Dio (remote data source implementor)
  sl.registerLazySingleton(() => DioFactory(sl()));
  Dio dio = await sl<DioFactory>().dio;

  // Used in [NetworkInfo] implementor
  sl.registerLazySingleton(() => InternetConnectionChecker());
  //*======================================================
  //* ----------------------[Auth]-------------------------
  //*======================================================
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(retrofitServiceClient: sl()));

  sl.registerLazySingleton(() => AuthApiServiceClient(dio));

  //! Login
  sl.registerFactory(() => LoginViewModel(sl()));

  sl.registerFactory(() => LoginUseCase(sl()));
}
