// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:m3g_chat/config/di/injector.dart' as _i8;
import 'package:m3g_chat/features/main_feature/data/data_sources/auth_api/auth_api_service.dart'
    as _i4;
import 'package:m3g_chat/features/main_feature/data/repositories/auth_repo_impl.dart'
    as _i6;
import 'package:m3g_chat/features/main_feature/domain/repositories/auth_repo.dart'
    as _i5;
import 'package:m3g_chat/features/main_feature/presentation/cubit/auth_cubit/auth_cubit.dart'
    as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Dio>(() => registerModule.dio());
    gh.factory<_i4.AuthApiService>(
        () => registerModule.getService(gh<_i3.Dio>()));
    gh.lazySingleton<_i5.AuthRepo>(
        () => _i6.AuthRepoImpl(gh<_i4.AuthApiService>()));
    gh.factory<_i7.AuthCubit>(() => _i7.AuthCubit(gh<_i5.AuthRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i8.RegisterModule {}
