import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/order_items_entity.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_products_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flower_app/features/profile/domain/usecases/delete_address_usecase.dart';
import 'package:flower_app/features/profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_data_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_oders_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/logout_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/reset_password_use_case.dart';
import 'package:flower_app/features/profile/domain/usecases/update_address_usecase.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([
  GetUserDataUseCase,
  EditProfileUseCase,
  UpdateAddressUsecase,
  DeleteAddressUsecase,
  GetUserOdersUseCase,
  LogoutUseCase,
  ResetPasswordUseCase,
  AuthLocalDataSourceContract,
])
void main() {
  late ProfileCubit profileCubit;
  late MockGetUserOdersUseCase mockGetUserOrdersUseCase;
  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUpdateAddressUsecase mockUpdateAddressUseCase;
  late MockDeleteAddressUsecase mockDeleteAddressUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockAuthLocalDataSourceContract mockAuthLocalDataSource;

  setUp(() {
    
    provideDummy<Either<Exception, UserData>>(
       Right(UserData(email: '', firstName: '', lastName: '', phone: '', gender: '', photo: '', addresses: [])),
    );
    provideDummy<Either<ApiException, List<UserOrdersEntitiy>>>(
      const Right([]),
    );

    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUpdateAddressUseCase = MockUpdateAddressUsecase();
    mockDeleteAddressUseCase = MockDeleteAddressUsecase();
    mockGetUserOrdersUseCase = MockGetUserOdersUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockAuthLocalDataSource = MockAuthLocalDataSourceContract();

    when(mockGetUserDataUseCase()).thenAnswer(
          (_) async =>  Right(UserData(email: '', firstName: '', lastName: '', phone: '', gender: '', photo: '', addresses: [])),
    );

    profileCubit = ProfileCubit(
      mockGetUserDataUseCase,
      mockEditProfileUseCase,
      mockLogoutUseCase,
      mockResetPasswordUseCase,
      mockAuthLocalDataSource,
      mockUpdateAddressUseCase,
      mockDeleteAddressUseCase,
      mockGetUserOrdersUseCase,
    );
  });

  tearDown(() {
    profileCubit.close();
    reset(mockGetUserDataUseCase);
    reset(mockEditProfileUseCase);
    reset(mockUpdateAddressUseCase);
    reset(mockDeleteAddressUseCase);
    reset(mockGetUserOrdersUseCase);
    reset(mockLogoutUseCase);
    reset(mockResetPasswordUseCase);
    reset(mockAuthLocalDataSource);
  });

  group('testing get user orders in cubit', () {
    // Test case 1: Initial state
    test('initial state should have getUserOrdersState as null in first state', () {
      expect(
        profileCubit.state.getUserOrdersState,
          isNull,
      );
    });

    // Test case 2: Success case - UseCase returns Right with orders
blocTest<ProfileCubit, ProfileState>(
  'emits [Loading, Success] when getUserOrders succeeds',
  build: () {
    when(mockGetUserOrdersUseCase()).thenAnswer(
      (_) async => Right([
        UserOrdersEntitiy(
          id: 'ORD123',
          totalPrice: 150,
          state: 'delivered',
          orderItem: OrderItemsEntity(
            product: UserProductsEntity(title: "title", imgCover: "imgCover"),
            price: 100,
          ),
        ),
      ]),
    );
    return profileCubit;
  },
  act: (cubit) => cubit.getUserOrders(),
  expect: () => [
    isA<ProfileState>()
        .having((state) => state.getUserOrdersState, 'getUserOrdersState', isA<BaseLoadingState>()),
    isA<ProfileState>()
        .having(
          (state) => state.getUserOrdersState,
          'getUserOrdersState',
          isA<BaseSuccessState<List<UserOrdersEntitiy>>>()
              .having(
                // ignore: unnecessary_cast
                (s) => (s as BaseSuccessState<List<UserOrdersEntitiy>>).data?.length?? 0,
                'data length',
                1,
              )
              .having(
                 // ignore: unnecessary_cast
                (s) => (s as BaseSuccessState<List<UserOrdersEntitiy>>).data?.first.id,
                'first order id',
                'ORD123',
              ),
        ),
  ],
  verify: (_) {
    verify(mockGetUserOrdersUseCase()).called(1);
  },
);


    // Test case 3: Failure case - UseCase returns Left with error
    blocTest<ProfileCubit, ProfileState>(
      'emits [Loading, Error] when getUserOrders fails',
      build: () {
        when(mockGetUserOrdersUseCase()).thenAnswer(
              (_) async => Left(ApiException(
            message: 'error message',
          )),
        );
        return profileCubit;
      },
      act: (cubit) => cubit.getUserOrders(),
      expect: () => [
        isA<ProfileState>()
            .having((state) => state.getUserOrdersState, 'getUserOrdersState', isA<BaseLoadingState>()),
        isA<ProfileState>()
            .having(
              (state) => state.getUserOrdersState,
          'getUserOrdersState',
          isA<BaseErrorState>()
              .having((s) => (s).errorMessage, 'errorMessage',
              'error message'),
        ),
      ],
      verify: (_) {
        verify(mockGetUserOrdersUseCase()).called(1);
      },
    );

    // Test case 4: Empty orders case - UseCase returns Right with empty list
    blocTest<ProfileCubit, ProfileState>(
      'emits [Loading, Success] with empty list when getUserOrders returns empty',
      build: () {
        when(mockGetUserOrdersUseCase()).thenAnswer(
              (_) async => const Right([]),
        );
        return profileCubit;
      },
      act: (cubit) => cubit.getUserOrders(),
      expect: () => [
        isA<ProfileState>()
            .having((state) => state.getUserOrdersState, 'getUserOrdersState', isA<BaseLoadingState>()),
        isA<ProfileState>()
            .having(
              (state) => state.getUserOrdersState,
          'getUserOrdersState',
          isA<BaseSuccessState>().having(
                  (s) => (s as BaseSuccessState<List<UserOrdersEntitiy>>).data, 'data', []),
        ),
      ],
      verify: (_) {
        verify(mockGetUserOrdersUseCase()).called(1);
      },
    );
  });
}