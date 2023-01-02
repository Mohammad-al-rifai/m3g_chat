// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m3g_chat/features/main_feature/domain/models/all_users_model.dart';

import '../../../domain/bodies/login_body.dart';
import '../../../domain/bodies/register_body.dart';
import '../../../domain/repositories/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this._authRepo) : super(AuthInitialState());
  final AuthRepo _authRepo;

  login({
    required LoginBody loginBody,
  }) async {
    emit(LoginLoadingState());
    await _authRepo.login(loginBody: loginBody).then((value) {
      print('Token ${value.token}');
      emit(LoginDoneState(loginModel: value));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }

  register({
    required RegisterBody registerBody,
  }) async {
    emit(RegisterLoadingState());
    await _authRepo.register(registerBody: registerBody).then((value) {
      print('Token ${value.token}');
      emit(RegisterDoneState(registerModel: value));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  List<Users> users = [];

  // Get All Users
  getAllUsers() async {
    users = [];
    emit(GetAllUsersLoadingState());
    await _authRepo.getAllUsers().then((value) {
      users.addAll(value.users!);
      print(users.length);
      emit(GetAllUsersDoneState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllUsersErrorState());
    });
  }
}
