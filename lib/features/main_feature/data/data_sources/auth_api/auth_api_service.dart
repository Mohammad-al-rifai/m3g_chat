import 'package:m3g_chat/features/main_feature/domain/models/all_users_model.dart';

import '../../../domain/bodies/login_body.dart';
import '../../../domain/bodies/register_body.dart';
import '../../../domain/models/auth_model.dart';

abstract class AuthApiService {
  // Login
  Future<AuthModel> login({
    LoginBody loginBody,
  });

  // Register
  Future<AuthModel> register({
    RegisterBody registerBody,
  });

  // Get All Users
  Future<AllUsersModel> getAllUsers(
    String authorization,
  );
}
