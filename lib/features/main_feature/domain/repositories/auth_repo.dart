import '../bodies/login_model.dart';
import '../bodies/register_body.dart';
import '../models/auth_model.dart';

abstract class AuthRepo {
  Future<AuthModel> login({
    required LoginBody loginBody,
  });

  Future<AuthModel> register({
    required RegisterBody registerBody,
  });
}
