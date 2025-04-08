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
import 'package:flower_app/core/di/modules.dart' as _i39;
import 'package:flower_app/core/error_handling/dio_error_handler.dart' as _i343;
import 'package:flower_app/core/routes/navigator_observer.dart' as _i210;
import 'package:flower_app/core/services/location_service.dart' as _i754;
import 'package:flower_app/core/widget/dialog_utils.dart' as _i271;
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart'
    as _i1053;
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart'
    as _i851;
import 'package:flower_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart'
    as _i851;
import 'package:flower_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_impl.dart'
    as _i374;
import 'package:flower_app/features/auth/data/repo/auth_repo_impl.dart'
    as _i1012;
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart' as _i514;
import 'package:flower_app/features/auth/domain/ues_case/forget_password_use_case.dart'
    as _i235;
import 'package:flower_app/features/auth/domain/ues_case/resend_otp_use_case.dart'
    as _i419;
import 'package:flower_app/features/auth/domain/ues_case/reset_password_use_case.dart'
    as _i696;
import 'package:flower_app/features/auth/domain/ues_case/sign_in_use_case.dart'
    as _i621;
import 'package:flower_app/features/auth/domain/ues_case/signup_use_case.dart'
    as _i366;
import 'package:flower_app/features/auth/domain/ues_case/verify_reset_code_use_case.dart'
    as _i242;
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart'
    as _i315;
import 'package:flower_app/features/home/data/datasource/home_data_source_contract.dart'
    as _i286;
import 'package:flower_app/features/home/data/datasource/home_data_source_impl.dart'
    as _i399;
import 'package:flower_app/features/home/data/repo/home_repository_impl.dart'
    as _i779;
import 'package:flower_app/features/home/domain/repo/home_repository_contract.dart'
    as _i453;
import 'package:flower_app/features/home/domain/use_case/home_use_case.dart'
    as _i169;
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart'
    as _i260;
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
    gh.factory<_i754.LocationService>(() => _i754.LocationService());
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
    gh.singleton<_i271.DialogUtils>(() => _i271.DialogUtils());
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
    gh.singleton<_i570.ApiClient>(() => _i199.DioApiClient(
          gh<_i666.LocalStorageClient>(),
          gh<_i343.DioErrorHandler>(),
          gh<_i719.GlobalKey<_i719.NavigatorState>>(),
        ));
    gh.factory<_i1053.AuthLocalDataSourceContract>(
        () => _i851.AuthLocalDataSourceImpl(gh<_i666.LocalStorageClient>()));
    gh.factory<_i286.HomeDataSourceContract>(
        () => _i399.HomeDataSourceImpl(gh<_i570.ApiClient>()));
    gh.factory<_i851.AuthRemoteDataSourceContract>(
        () => _i374.AuthRemoteDataSourceImpl(gh<_i570.ApiClient>()));
    gh.factory<_i453.HomeRepositoryContract>(
        () => _i779.HomeRepositoryImpl(gh<_i286.HomeDataSourceContract>()));
    gh.factory<_i514.AuthRepo>(() => _i1012.AuthRepoImpl(
          gh<_i1053.AuthLocalDataSourceContract>(),
          gh<_i851.AuthRemoteDataSourceContract>(),
        ));
    gh.factory<_i242.VerifyResetCodeUseCase>(
        () => _i242.VerifyResetCodeUseCase(gh<_i514.AuthRepo>()));
    gh.factory<_i621.SignInUseCase>(
        () => _i621.SignInUseCase(gh<_i514.AuthRepo>()));
    gh.factory<_i235.ForgetPasswordUseCase>(
        () => _i235.ForgetPasswordUseCase(gh<_i514.AuthRepo>()));
    gh.factory<_i366.SignupUseCase>(
        () => _i366.SignupUseCase(gh<_i514.AuthRepo>()));
    gh.factory<_i696.ResetPasswordUseCase>(
        () => _i696.ResetPasswordUseCase(gh<_i514.AuthRepo>()));
    gh.factory<_i419.ResendOtpUseCase>(
        () => _i419.ResendOtpUseCase(gh<_i514.AuthRepo>()));
    gh.factory<_i169.GetHomeDataUseCase>(
        () => _i169.GetHomeDataUseCase(gh<_i453.HomeRepositoryContract>()));
    gh.factory<_i315.AuthCubit>(() => _i315.AuthCubit(
          gh<_i366.SignupUseCase>(),
          gh<_i235.ForgetPasswordUseCase>(),
          gh<_i242.VerifyResetCodeUseCase>(),
          gh<_i696.ResetPasswordUseCase>(),
          gh<_i621.SignInUseCase>(),
          gh<_i666.LocalStorageClient>(),
          gh<_i419.ResendOtpUseCase>(),
        ));
    gh.factory<_i260.HomeCubit>(() => _i260.HomeCubit(
          getHomeDataUseCase: gh<_i169.GetHomeDataUseCase>(),
          locationService: gh<_i754.LocationService>(),
        ));
    return this;
  }
}

class _$GetItRegisterModule extends _i39.GetItRegisterModule {}
