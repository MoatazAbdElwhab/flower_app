import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/features/auth/presentation/pages/pin_code_page.dart';
import 'package:flower_app/features/auth/presentation/pages/forget_password_page.dart';
import 'package:flower_app/features/auth/presentation/pages/login_page.dart';
import 'package:flower_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flower_app/features/best_seller/presentation/pages/best_seller_page.dart';
import 'package:flower_app/features/checkout/domain/entities/check_out_session_detailes.dart';
import 'package:flower_app/features/checkout/domain/entities/checkout_edit_address_arguments.dart';
import 'package:flower_app/features/checkout/presentation/pages/checkout_page.dart';
import 'package:flower_app/features/checkout/presentation/pages/web_view_page.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/home/presentation/pages/home_screen.dart';
import 'package:flower_app/features/notification/presentation/pages/notification_page.dart';
import 'package:flower_app/features/occasion/presentation/pages/occasion_page.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/features/profile/presentation/pages/profile_reset_password.dart';
import 'package:flower_app/features/profile/presentation/pages/saved_address_page/saved_address_page.dart';
import 'package:flower_app/features/profile/presentation/pages/terms_and_conditions.dart';
import 'package:flower_app/features/profile/presentation/pages/about_us_page.dart';
import 'package:flower_app/features/profile/presentation/pages/user_orders_page/user_orders_screen.dart';
import 'package:flower_app/features/search/presentation/pages/search_results_page.dart';
import 'package:flower_app/features/splash/splash_screen.dart';
import 'package:flower_app/core/common_widgets/product_details_page/product_details_page.dart';

import 'package:flower_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/add_edit_address/domain/arguments/edit_address_arguments.dart';
import '../../features/add_edit_address/presentation/manager/add_address_cubit.dart';
import '../../features/add_edit_address/presentation/pages/add_edit_adress_screen.dart';
import '../../features/nav/presentation/pages/navbar_page.dart';
import '../../features/profile/domain/entities/user_data.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SplashScreen(),
      );
    case Routes.login:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginPage(),
      );
    case Routes.signup:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SignupPage(),
      );

    case Routes.home:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomeScreen(),
      );

    case Routes.navbar:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NavbarPage(),
      );
    case Routes.forgetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ForgetPasswordPage(),
      );

    case Routes.pinCode:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PinCodePage(),
      );

    case Routes.resetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ResetPasswordPage(),
      );

    case Routes.occasion:
      final arguments = settings.arguments as OccasionPageArguments?;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => OccasionPage(
          arguments: OccasionPageArguments(
            categories: arguments?.categories,
            selectedCategoryIndex: arguments?.selectedCategoryIndex,
          ),
        ),
      );

    case Routes.bestSeller:
      final arguments = settings.arguments;
      final productList = (arguments is List<ProductEntity>)
          ? arguments
          : <ProductEntity>[]; // Default to empty list if null or wrong type
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => BestSellerPage(
          productEntityList: productList,
        ),
      );

    case Routes.editProfilePage:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => EditProfilePage(
          userData: settings.arguments as UserData,
        ),
      );

    case Routes.productDetailsView:
      final arguments = settings.arguments as ProductEntity;
      return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return ProductDetailsPage(productArgument: arguments);
          });

    case Routes.profileResetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ProfileResetPassword(),
      );

    case Routes.addAndEditAddress:
      final args = settings.arguments;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => args is ProfileEditAddressArgs
            ? MultiBlocProvider(providers: [
                BlocProvider(create: (_) => getIt<AddAddressCubit>()),
                BlocProvider.value(value: args.profileCubit)
              ], child: AddOrEditAddressScreen(profileEditPageArguments: args))
            : args is CheckoutEditAddressArgs
                ? MultiBlocProvider(
                    providers: [
                        BlocProvider(create: (_) => getIt<AddAddressCubit>()),
                        BlocProvider.value(value: args.checkoutCubit)
                      ],
                    child:
                        AddOrEditAddressScreen(checkoutEditAddressArgs: args))
                : BlocProvider(
                    create: (_) => getIt<AddAddressCubit>(),
                    child: const AddOrEditAddressScreen()),
      );

    case Routes.searchResults:
      final Map<String, dynamic> args =
          settings.arguments as Map<String, dynamic>? ?? {};
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => SearchResultsPage(
          initialQuery: args['initialQuery'] as String? ?? '',
          categoryId: args['categoryId'] as String?,
          onBackPressed: () => Navigator.pop(_),
        ),
      );
    case Routes.checkout:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) =>
            CheckoutPage(arguments: settings.arguments as List<num>),
      );

    case Routes.termsAndConditions:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const TermsAndConditionsPage(),
      );

    case Routes.aboutUs:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const AboutUsPage(),
      );

    case Routes.savedAddresses:
      final cubit = settings.arguments as ProfileCubit;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const SavedAddressPage()),
      );
    case Routes.userOrdersScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => UserOrdersScreen(
          cubit: settings.arguments as ProfileCubit,
        ),
      );

    case Routes.webViewPage:
      final arguments = settings.arguments as OnlinePaymentDetails;
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => WebViewPage(
          onlinePaymentDetails: arguments,
        ),
      );

    case Routes.notificationPage:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NotificationPage(),
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
