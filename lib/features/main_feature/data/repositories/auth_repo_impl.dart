import 'package:injectable/injectable.dart';
import 'package:m3g_chat/features/main_feature/domain/bodies/register_body.dart';

import '../../domain/bodies/login_model.dart';
import '../../domain/models/auth_model.dart';
import '../../domain/repositories/auth_repo.dart';
import '../data_sources/auth_api/auth_api_service.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  final AuthApiService _authApiService;

  AuthRepoImpl(this._authApiService);

  @override
  Future<AuthModel> login({
    required LoginBody loginBody,
  }) async {
    return await _authApiService.login(
      loginBody: loginBody,
    );
  }

  @override
  Future<AuthModel> register({
    required RegisterBody registerBody,
  }) async {
    return await _authApiService.register(
      registerBody: registerBody,
    );
  }
}
