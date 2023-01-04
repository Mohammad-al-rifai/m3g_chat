import 'package:m3g_chat/app/components/resources/constants_manager.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  changSecret({required int numOfLevel}) {
    AppConstants.level = numOfLevel;
    emit(AppChangeSecret());
  }
}
