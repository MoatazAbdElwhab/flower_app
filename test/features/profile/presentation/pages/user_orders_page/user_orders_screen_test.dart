// import 'package:easy_localization/easy_localization.dart';
// import 'package:flower_app/core/base/base_state.dart';
// import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
// import 'package:flower_app/features/profile/presentation/pages/user_orders_page/user_orders_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';

// import 'user_orders_screen_test.mocks.dart';


// FIXME: Not working as expected, and I don't know why!!!!!!!

// @GenerateMocks([ProfileCubit])
// void main() {
//   late MockProfileCubit mockCubit;

//   setUp(() async {
//     mockCubit = MockProfileCubit();

//     // Mock SharedPreferences for easy_localization
//     SharedPreferences.setMockInitialValues({});

//     // Initialize EasyLocalization
//     await EasyLocalization.ensureInitialized();
//   });

//   group("UserOrdersScreen Widget Tests", () {
//     testWidgets('shows loading shimmer when state is loading', (tester) async {
//       // Arrange
//       final loadingState = ProfileState(
//         getUserOrdersState: BaseLoadingState(),
//       );

//       // Mock the cubit's state and stream to ensure it stays in BaseLoadingState
//       when(mockCubit.state).thenReturn(loadingState);
//       when(mockCubit.stream).thenAnswer(
//         (_) => Stream.value(loadingState),
//       );

//       when(mockCubit.getUserOrders()).thenAnswer((_) => Future.value());

//       // Act
//       await tester.pumpWidget(
//         EasyLocalization(
//           supportedLocales: const [Locale('en')],
//           path: 'assets/translations',
//           fallbackLocale: const Locale('en'),
//           child: ScreenUtilInit(
//             designSize: const Size(375, 812),
//             minTextAdapt: true,
//             splitScreenMode: true,
//             builder: (context, child) {
//               return MaterialApp(
//                 localizationsDelegates: context.localizationDelegates,
//                 supportedLocales: context.supportedLocales,
//                 locale: context.locale,
//                 home: BlocProvider.value(
//                   value: mockCubit,
//                   child: UserOrdersScreen(cubit: mockCubit),
//                 ),
//               );
//             },
//           ),
//         ),
//       );

//  
//       await tester.pump();

//       // Assert
//       expect(find.byType(Shimmer), findsOneWidget);
//     });
//   });
// }