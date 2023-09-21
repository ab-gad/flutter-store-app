import 'package:dio/dio.dart';
import 'package:flutter_store_app/app/app_prefs_repository.dart';
import 'package:flutter_store_app/data/data_sources/remote/authentication_remote_data_source.dart';
import 'package:flutter_store_app/data/data_sources/local/local_data_source.dart';
import 'package:flutter_store_app/data/data_sources/remote/main_remote_data_source.dart';
import 'package:flutter_store_app/data/network/authentication/auth_api_service_client.dart';
import 'package:flutter_store_app/data/network/dio_factory.dart';
import 'package:flutter_store_app/data/network/network_info.dart';
import 'package:flutter_store_app/data/repositories_impl/authentication_repository_impl.dart';
import 'package:flutter_store_app/data/repositories_impl/main_repository_impl.dart';
import 'package:flutter_store_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_store_app/domain/repositories/main_repository.dart';
import 'package:flutter_store_app/domain/usecases/forgot_password_usecase.dart';
import 'package:flutter_store_app/domain/usecases/login_usecase.dart';
import 'package:flutter_store_app/domain/usecases/main/get_home_data_usecase.dart';
import 'package:flutter_store_app/domain/usecases/register_usecase.dart';
import 'package:flutter_store_app/presentation/forget_password/view_model/forgot_password_view_model.dart';
import 'package:flutter_store_app/presentation/login/view_model/login_view_model.dart';
import 'package:flutter_store_app/presentation/main/pages/home/veiw_model/home_view_model.dart';
import 'package:flutter_store_app/presentation/registration/view_model/registeration_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/main/main_api_service_client.dart';

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
  //* ----------------------[Main]-------------------------
  //*======================================================
  sl.registerLazySingleton<MainRepository>(
      () => MainRepositoryImpl(mainRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<MainRemoteDataSource>(
      () => MainRemoteDataSourceImpl(mainApiServiceClient: sl()));

  sl.registerLazySingleton(() => MainApiServiceClient(dio));

  //! Home page
  sl.registerFactory(() => GetHomeDataUseCase(mainRepository: sl()));

  sl.registerFactory(() => HomeViewModel(getHomeDataUseCase: sl()));
  //*======================================================
  //* ----------------------[Auth]-------------------------
  //*======================================================
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(retrofitServiceClient: sl()));

  sl.registerLazySingleton(() => AuthApiServiceClient(dio));

  //! Registration
  sl.registerFactory(() => RegistrationViewModel(registerUserCase: sl()));

  sl.registerFactory(() => RegisterUseCase(sl()));

  //! Login
  sl.registerFactory(() => LoginViewModel(sl()));

  sl.registerFactory(() => LoginUseCase(sl()));

  //! Forget password
  sl.registerFactory(() => ForgotPasswordViewModel(sl()));

  sl.registerFactory(() => ForgotPasswordUseCase(sl()));
}
