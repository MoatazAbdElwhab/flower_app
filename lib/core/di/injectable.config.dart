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
import 'package:flower_app/features/add_address/data/data_sources/add_address_remote_data_source.dart'
    as _i306;
import 'package:flower_app/features/add_address/data/data_sources/add_address_remote_data_source_impl.dart'
    as _i647;
import 'package:flower_app/features/add_address/data/repositories/add_address_repo_impl.dart'
    as _i398;
import 'package:flower_app/features/add_address/domain/repositories/add_address_repo.dart'
    as _i718;
import 'package:flower_app/features/add_address/domain/use_cases/add_adress_use_case.dart'
    as _i742;
import 'package:flower_app/features/add_address/presentation/manager/add_address_cubit.dart'
    as _i723;
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
import 'package:flower_app/features/cart/data/data_source/remote/cart_remote_ds_impl.dart'
    as _i845;
import 'package:flower_app/features/cart/data/data_source/remote/cart_remote_ds_interface.dart'
    as _i861;
import 'package:flower_app/features/cart/data/repo/cart_repo_impl.dart'
    as _i355;
import 'package:flower_app/features/cart/domain/repo/cart_repo_interface.dart'
    as _i241;
import 'package:flower_app/features/cart/domain/use_cases/cart_add_product_use_case.dart'
    as _i589;
import 'package:flower_app/features/cart/domain/use_cases/cart_load_use_case.dart'
    as _i379;
import 'package:flower_app/features/cart/domain/use_cases/cart_remove_product_use_case.dart'
    as _i325;
import 'package:flower_app/features/cart/domain/use_cases/clear_cart_use_case.dart'
    as _i264;
import 'package:flower_app/features/cart/domain/use_cases/update_product_quantity_use_case.dart'
    as _i703;
import 'package:flower_app/features/cart/presentation/bloc/cart_bloc.dart'
    as _i534;
import 'package:flower_app/features/categories/data/remote/data_sources/categories_remote_data_source.dart'
    as _i634;
import 'package:flower_app/features/categories/data/remote/data_sources/categories_remote_data_source_impl.dart'
    as _i161;
import 'package:flower_app/features/categories/data/repositories/categories_repo_impl.dart'
    as _i486;
import 'package:flower_app/features/categories/domain/repositories/categories_repo.dart'
    as _i1;
import 'package:flower_app/features/categories/domain/use_cases/get_categories_use_case.dart'
    as _i298;
import 'package:flower_app/features/categories/domain/use_cases/get_sorted_products_use_case.dart'
    as _i44;
import 'package:flower_app/features/categories/presentation/manager/categories_cubit.dart'
    as _i659;
import 'package:flower_app/features/checkout/data/datasources/remote/checkout_api_remote_data_source.dart'
    as _i526;
import 'package:flower_app/features/checkout/data/datasources/remote/checkout_remote_data_source.dart'
    as _i766;
import 'package:flower_app/features/checkout/data/repositories/checkout_repository_impl.dart'
    as _i486;
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart'
    as _i46;
import 'package:flower_app/features/checkout/domain/usecases/get_adresses_use_case.dart'
    as _i147;
import 'package:flower_app/features/checkout/presentation/cubit/checkout_cubit.dart'
    as _i122;
import 'package:flower_app/features/home/data/datasource/home_data_source_contract.dart'
    as _i286;
import 'package:flower_app/features/home/data/datasource/home_data_source_impl.dart'
    as _i399;
import 'package:flower_app/features/home/data/repo/home_repository_impl.dart'
    as _i779;
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart'
    as _i1025;
import 'package:flower_app/features/home/domain/repo/home_repository_contract.dart'
    as _i453;
import 'package:flower_app/features/home/domain/use_case/home_use_case.dart'
    as _i169;
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart'
    as _i260;
import 'package:flower_app/features/occasion/data/datasources/remote/occasion_api_remote_data_source.dart'
    as _i540;
import 'package:flower_app/features/occasion/data/datasources/remote/occasion_remote_data_source.dart'
    as _i224;
import 'package:flower_app/features/occasion/data/repositories/occasion_repository_impl.dart'
    as _i547;
import 'package:flower_app/features/occasion/domain/repositories/occasion_repository.dart'
    as _i429;
import 'package:flower_app/features/occasion/domain/usecases/get_occasions_by_id_use_case.dart'
    as _i859;
import 'package:flower_app/features/occasion/presentation/cubit/occasion_cubit.dart'
    as _i814;
import 'package:flower_app/features/profile/data/datasources/local/profile_local_data_source.dart'
    as _i941;
import 'package:flower_app/features/profile/data/datasources/local/profile_local_data_source_impl.dart'
    as _i469;
import 'package:flower_app/features/profile/data/datasources/remote/profile_api_remote_data_source.dart'
    as _i1015;
import 'package:flower_app/features/profile/data/datasources/remote/profile_remote_data_source.dart'
    as _i445;
import 'package:flower_app/features/profile/data/repositories/profile_repository_impl.dart'
    as _i866;
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart'
    as _i806;
import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart'
    as _i732;
import 'package:flower_app/features/profile/domain/usecases/get_user_data_use_case.dart'
    as _i389;
import 'package:flower_app/features/profile/domain/usecases/logout_use_case.dart'
    as _i307;
import 'package:flower_app/features/profile/domain/usecases/reset_password_use_case.dart'
    as _i850;
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart'
    as _i928;
import 'package:flower_app/features/search/data/datasources/search_remote_ds_impl.dart'
    as _i261;
import 'package:flower_app/features/search/data/datasources/search_remote_ds_interface.dart'
    as _i717;
import 'package:flower_app/features/search/data/repositories/search_repository_impl.dart'
    as _i823;
import 'package:flower_app/features/search/domain/repositories/search_repository.dart'
    as _i347;
import 'package:flower_app/features/search/domain/usecases/search_products_use_case.dart'
    as _i902;
import 'package:flower_app/features/search/presentation/bloc/search_bloc.dart'
    as _i690;
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
    gh.factory<_i941.ProfileLocalDataSource>(
        () => _i469.ProfileLocalDataSourceImpl(gh<_i666.LocalStorageClient>()));
    gh.factory<_i1053.AuthLocalDataSourceContract>(
        () => _i851.AuthLocalDataSourceImpl(gh<_i666.LocalStorageClient>()));
    gh.factory<_i224.OccasionRemoteDataSource>(
        () => _i540.OccasionApiRemoteDataSource(gh<_i570.ApiClient>()));
    gh.factory<_i286.HomeDataSourceContract>(
        () => _i399.HomeDataSourceImpl(gh<_i570.ApiClient>()));
    gh.factory<_i851.AuthRemoteDataSourceContract>(
        () => _i374.AuthRemoteDataSourceImpl(gh<_i570.ApiClient>()));
    gh.factory<_i766.CheckoutRemoteDataSource>(
        () => _i526.CheckoutApiRemoteDataSource(gh<_i570.ApiClient>()));
    gh.factory<_i306.AddAddressRemoteDataSource>(
        () => _i647.AddAddressRemoteDataSourceImpl(gh<_i570.ApiClient>()));
    gh.factory<_i861.CartRemoteDsInterface>(
        () => _i845.CartRemoteDsImpl(gh<_i570.ApiClient>()));
    gh.factory<_i634.CategoriesRemoteDataSourceContract>(
        () => _i161.CategoriesRemoteDataSourceImpl(gh<_i570.ApiClient>()));
    gh.factory<_i445.ProfileRemoteDataSource>(
        () => _i1015.ProfileApiRemoteDataSource(gh<_i570.ApiClient>()));
    gh.factory<_i717.SearchRemoteDsInterface>(
        () => _i261.SearchRemoteDsImpl(gh<_i570.ApiClient>()));
    gh.factory<_i1.CategoriesRepo>(() => _i486.CategoriesRepoImpl(
        gh<_i634.CategoriesRemoteDataSourceContract>()));
    gh.factory<_i453.HomeRepositoryContract>(
        () => _i779.HomeRepositoryImpl(gh<_i286.HomeDataSourceContract>()));
    gh.factory<_i298.GetCategoriesUseCase>(
        () => _i298.GetCategoriesUseCase(gh<_i1.CategoriesRepo>()));
    gh.factory<_i44.GetSortedProductsUseCase>(
        () => _i44.GetSortedProductsUseCase(gh<_i1.CategoriesRepo>()));
    gh.factory<_i659.CategoriesCubit>(() => _i659.CategoriesCubit(
          gh<_i298.GetCategoriesUseCase>(),
          gh<_i44.GetSortedProductsUseCase>(),
          gh<List<_i1025.CategoryOccasionEntity>>(),
        ));
    gh.factory<_i806.ProfileRepository>(() => _i866.ProfileRepositoryImpl(
          gh<_i445.ProfileRemoteDataSource>(),
          gh<_i941.ProfileLocalDataSource>(),
        ));
    gh.factory<_i429.OccasionRepository>(() =>
        _i547.OccasionRepositoryImpl(gh<_i224.OccasionRemoteDataSource>()));
    gh.factory<_i347.SearchRepository>(
        () => _i823.SearchRepositoryImpl(gh<_i717.SearchRemoteDsInterface>()));
    gh.factory<_i718.AddAddressRepo>(
        () => _i398.AddAddressRepoImpl(gh<_i306.AddAddressRemoteDataSource>()));
    gh.factory<_i46.CheckoutRepository>(() =>
        _i486.CheckoutRepositoryImpl(gh<_i766.CheckoutRemoteDataSource>()));
    gh.factory<_i241.CartRepoInterface>(
        () => _i355.CartRepoImpl(gh<_i861.CartRemoteDsInterface>()));
    gh.factory<_i147.GetAddressesUseCase>(
        () => _i147.GetAddressesUseCase(gh<_i46.CheckoutRepository>()));
    gh.factory<_i514.AuthRepo>(() => _i1012.AuthRepoImpl(
          gh<_i1053.AuthLocalDataSourceContract>(),
          gh<_i851.AuthRemoteDataSourceContract>(),
        ));
    gh.factory<_i703.CartUpdateProductQuantityUseCase>(() =>
        _i703.CartUpdateProductQuantityUseCase(gh<_i241.CartRepoInterface>()));
    gh.factory<_i325.CartRemoveProductUseCase>(
        () => _i325.CartRemoveProductUseCase(gh<_i241.CartRepoInterface>()));
    gh.factory<_i264.ClearCartUseCase>(
        () => _i264.ClearCartUseCase(gh<_i241.CartRepoInterface>()));
    gh.factory<_i379.CartLoadUseCase>(
        () => _i379.CartLoadUseCase(gh<_i241.CartRepoInterface>()));
    gh.factory<_i589.CartAddProductUseCase>(
        () => _i589.CartAddProductUseCase(gh<_i241.CartRepoInterface>()));
    gh.factory<_i742.AddAddressUseCase>(
        () => _i742.AddAddressUseCase(gh<_i718.AddAddressRepo>()));
    gh.factory<_i723.AddAddressCubit>(() => _i723.AddAddressCubit(
          gh<_i754.LocationService>(),
          gh<_i742.AddAddressUseCase>(),
        ));
    gh.factory<_i122.CheckoutCubit>(
        () => _i122.CheckoutCubit(gh<_i147.GetAddressesUseCase>()));
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
    gh.factory<_i902.SearchProductsUseCase>(
        () => _i902.SearchProductsUseCase(gh<_i347.SearchRepository>()));
    gh.factory<_i169.GetHomeDataUseCase>(
        () => _i169.GetHomeDataUseCase(gh<_i453.HomeRepositoryContract>()));
    gh.factory<_i389.GetUserDataUseCase>(
        () => _i389.GetUserDataUseCase(gh<_i806.ProfileRepository>()));
    gh.factory<_i307.LogoutUseCase>(
        () => _i307.LogoutUseCase(gh<_i806.ProfileRepository>()));
    gh.factory<_i732.EditProfileUseCase>(
        () => _i732.EditProfileUseCase(gh<_i806.ProfileRepository>()));
    gh.factory<_i850.ResetPasswordUseCase>(
        () => _i850.ResetPasswordUseCase(gh<_i806.ProfileRepository>()));
    gh.factory<_i859.GetOccasionsByIdUseCase>(
        () => _i859.GetOccasionsByIdUseCase(gh<_i429.OccasionRepository>()));
    gh.factory<_i315.AuthCubit>(() => _i315.AuthCubit(
          gh<_i366.SignupUseCase>(),
          gh<_i235.ForgetPasswordUseCase>(),
          gh<_i242.VerifyResetCodeUseCase>(),
          gh<_i696.ResetPasswordUseCase>(),
          gh<_i621.SignInUseCase>(),
          gh<_i666.LocalStorageClient>(),
          gh<_i419.ResendOtpUseCase>(),
        ));
    gh.singleton<_i534.CartBloc>(() => _i534.CartBloc(
          gh<_i264.ClearCartUseCase>(),
          gh<_i589.CartAddProductUseCase>(),
          gh<_i379.CartLoadUseCase>(),
          gh<_i325.CartRemoveProductUseCase>(),
          gh<_i703.CartUpdateProductQuantityUseCase>(),
        ));
    gh.factory<_i928.ProfileCubit>(() => _i928.ProfileCubit(
          gh<_i389.GetUserDataUseCase>(),
          gh<_i732.EditProfileUseCase>(),
          gh<_i307.LogoutUseCase>(),
          gh<_i850.ResetPasswordUseCase>(),
          gh<_i1053.AuthLocalDataSourceContract>(),
        ));
    gh.singleton<_i690.SearchBloc>(
        () => _i690.SearchBloc(gh<_i902.SearchProductsUseCase>()));
    gh.factory<_i814.OccasionCubit>(
        () => _i814.OccasionCubit(gh<_i859.GetOccasionsByIdUseCase>()));
    gh.factory<_i260.HomeCubit>(() => _i260.HomeCubit(
          getHomeDataUseCase: gh<_i169.GetHomeDataUseCase>(),
          locationService: gh<_i754.LocationService>(),
        ));
    return this;
  }
}

class _$GetItRegisterModule extends _i39.GetItRegisterModule {}
