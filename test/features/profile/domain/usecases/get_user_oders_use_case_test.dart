import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_oders_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_user_oders_use_case_test.mocks.dart';

//dummy value for Either<ApiException, List<UserOrdersEntity>>
Either<ApiException, List<UserOrdersEntitiy>> _dummyEither() =>
    const Right(<UserOrdersEntitiy>[]);

@GenerateMocks([ProfileRepository])
void main() {
  late GetUserOdersUseCase useCase;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = GetUserOdersUseCase(mockProfileRepository);

    provideDummy<Either<ApiException, List<UserOrdersEntitiy>>>(_dummyEither());
  });

  group('GetUserOrdersUseCase Tests', () {
    test(
      'should call getUserOrders from ProfileRepository and return Right with user orders',
          () async {
        final userOrders = <UserOrdersEntitiy>[];
        when(mockProfileRepository.getUserOrders())
            .thenAnswer((_) async => Right(userOrders));

        final result = await useCase.call();

        expect(result, Right<ApiException, List<UserOrdersEntitiy>>(userOrders));
        verify(mockProfileRepository.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockProfileRepository);
      },
    );

    test(
      'should return Left with ApiException when repository fails',
          () async {
        final failure = ApiException(message: 'Failed to get user orders');
        when(mockProfileRepository.getUserOrders())
            .thenAnswer((_) async => Left(failure));

        final result = await useCase.call();

        expect(result, Left<ApiException, List<UserOrdersEntitiy>>(failure));
        verify(mockProfileRepository.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockProfileRepository);
      },
    );
  });
}