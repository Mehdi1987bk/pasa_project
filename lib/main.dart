 import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
 import 'package:get_it/get_it.dart';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'data/network/api/auth_api.dart';
 import 'data/repositories/data_auth_repository.dart';
import 'domain/repositories/auth_repository.dart';
import 'pasa_app.dart';


final GetIt sl = GetIt.instance;
final logger = Logger(printer: SimplePrinter());
const baseUrl = 'https://p.buking.az/api';
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  _registerDependency();

  runApp(PasaApp());
}

void _registerDependency() {
  final dio = _initDio();
  sl.registerLazySingleton<AuthApi>(() => AuthApi(dio));
  sl.registerLazySingleton<AuthRepository>(() => DataAuthRepository());
 }

Dio _initDio() {
  final dio = Dio();

  dio.options.headers["content-type"] = "application/json";
  dio.options.headers["accept"] = "application/json";
  dio.options.connectTimeout = Duration(seconds: 120);
  dio.options.receiveTimeout = Duration(seconds: 120);
  dio.options.sendTimeout = Duration(seconds: 120);
   dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, logPrint: logger.d));
  // dio.interceptors
  //     .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
  // dio.interceptors.add(InterceptorsWrapper(
  //     onError: (DioError dioError) => _errorInterceptor(dioError)));
  sl.registerLazySingleton<Dio>(() => dio);

  return dio;
}
