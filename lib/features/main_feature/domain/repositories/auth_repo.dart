import 'package:m3g_chat/features/main_feature/domain/models/all_users_model.dart';

import '../bodies/login_body.dart';
import '../bodies/register_body.dart';
import '../models/auth_model.dart';

abstract class AuthRepo {
  Future<AuthModel> login({
    required LoginBody loginBody,
  });

  Future<AuthModel> register({
    required RegisterBody registerBody,
  });

  Future<AllUsersModel> getAllUsers();
}
