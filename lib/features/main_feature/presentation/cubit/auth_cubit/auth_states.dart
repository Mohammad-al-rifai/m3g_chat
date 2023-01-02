import '../../../domain/models/all_users_model.dart';
import '../../../domain/models/auth_model.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

// Login States

class LoginLoadingState extends AuthStates {}

class LoginDoneState extends AuthStates {
  final AuthModel loginModel;

  LoginDoneState({required this.loginModel});
}

class LoginErrorState extends AuthStates {}

// Register States
class RegisterLoadingState extends AuthStates {}

class RegisterDoneState extends AuthStates {
  final AuthModel registerModel;

  RegisterDoneState({required this.registerModel});
}

class RegisterErrorState extends AuthStates {}

// All Users States
class GetAllUsersLoadingState extends AuthStates {}

class GetAllUsersDoneState extends AuthStates {

  GetAllUsersDoneState();
}

class GetAllUsersErrorState extends AuthStates {}
