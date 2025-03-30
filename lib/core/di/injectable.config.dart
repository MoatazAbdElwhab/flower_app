// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flower_app/core/app_data/api/api_client.dart' as _i570;
import 'package:flower_app/core/app_data/api/dio_client.dart' as _i199;
import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart'
    as _i666;
import 'package:flower_app/core/base/base_state.dart' as _i584;
import 'package:flower_app/core/di/modules.dart' as _i39;
import 'package:flower_app/core/error_handling/dio_error_handler.dart' as _i343;
import 'package:flower_app/core/routes/navigator_observer.dart' as _i210;
import 'package:flower_app/features/auth/data/datasource/auth_remote_data_source.dart'
    as _i1019;
import 'package:flower_app/features/auth/data/datasource/auth_remote_data_source_impl.dart'
    as _i843;
import 'package:flower_app/features/auth/data/repo/auth_repo_impl.dart'
    as _i1012;
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart' as _i514;
import 'package:flower_app/features/auth/domain/ues_case/signup_use_case.dart'
    as _i366;
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i315;
import 'package:flower_app/features/auth/presentation/cubit/auth_state.dart'
    as _i561;
import 'package:flutter/cupertino.dart' as _i719;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final getItRegisterModule = _$GetItRegisterModule();
    gh.singleton<_i409.GlobalKey<_i409.NavigatorState>>(
        () => getItRegisterModule.navigatorKey);
    gh.singleton<_i973.InternetConnectionChecker>(
        () => getItRegisterModule.checker);
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => getItRegisterModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i558.FlutterSecureStorage>(
        () => getItRegisterModule.secureStorage);
    gh.singleton<_i210.AppNavigatorObserver>(
        () => _i210.AppNavigatorObserver());
    gh.singleton<_i666.LocalStorageClient>(() => _i666.LocalStorageClient(
          gh<_i460.SharedPreferences>(),
          gh<_i558.FlutterSecureStorage>(),
        ));
    gh.singleton<_i343.DioErrorHandler>(() => _i343.DioErrorHandler(
          gh<_i666.LocalStorageClient>(),
          gh<_i719.GlobalKey<_i719.NavigatorState>>(),
        ));
    gh.factory<_i561.AuthState>(
        () => _i561.AuthState(signUpState: gh<_i584.BaseState>()));
    gh.singleton<_i570.ApiClient>(() => _i199.DioApiClient(
          gh<_i666.LocalStorageClient>(),
          gh<_i343.DioErrorHandler>(),
          gh<_i719.GlobalKey<_i719.NavigatorState>>(),
        ));
    gh.factory<_i1019.AuthRemoteDataSource>(
        () => _i843.AuthRemoteDataSourceImpl(gh<_i570.ApiClient>()));
    gh.factory<_i514.AuthRepo>(
        () => _i1012.AuthRepoImpl(gh<_i1019.AuthRemoteDataSource>()));
    gh.factory<_i366.SignupUseCase>(
        () => _i366.SignupUseCase(gh<_i514.AuthRepo>()));
    gh.factory<_i315.AuthCubit>(
        () => _i315.AuthCubit(gh<_i366.SignupUseCase>()));
    return this;
  }
}

class _$GetItRegisterModule extends _i39.GetItRegisterModule {}
