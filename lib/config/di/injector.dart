import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:m3g_chat/config/di/injector.config.dart';
import 'package:m3g_chat/config/urls.dart';

import '../../features/main_feature/data/data_sources/auth_api/auth_api_service.dart';

final injector = GetIt.instance;

@InjectableInit()
GetIt init() => injector.init();

@module
abstract class RegisterModule {
  AuthApiService getService(Dio client) => AuthApiService(
        client,
        baseUrl: Urls.baseUrl,
      );

  @lazySingleton
  Dio dio() => Dio(
        BaseOptions(
          connectTimeout: 600000,
          receiveDataWhenStatusError: true,
          receiveTimeout: 600000,
        ),
      );
}
