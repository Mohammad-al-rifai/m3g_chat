import 'package:dio/dio.dart';
import 'package:m3g_chat/config/urls.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/bodies/login_model.dart';
import '../../../domain/bodies/register_body.dart';
import '../../../domain/models/auth_model.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: Urls.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  // Login
  @POST(Urls.logIn)
  Future<AuthModel> login({
    @Body() LoginBody? loginBody,
  });

  // Register
  @POST(Urls.register)
  Future<AuthModel> register({
    @Body() RegisterBody? registerBody,
  });
}
