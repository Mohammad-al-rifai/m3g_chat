// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/bodies/login_model.dart';
import '../../../domain/bodies/register_body.dart';
import '../../../domain/repositories/auth_repo.dart';
import 'auth_states.dart';

@injectable
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
}
