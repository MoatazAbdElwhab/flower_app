// test/features/home/domain/usecase/home_use_case_test.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flower_app/features/home/domain/use_case/home_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'home_use_case_test.mocks.dart';

// Generate mocks for testing
@GenerateMocks([HomeRepositoryContract])
void main() {
  late GetHomeDataUseCase getHomeDataUseCase;
  late MockHomeRepositoryContract mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepositoryContract();
    getHomeDataUseCase = GetHomeDataUseCase(mockHomeRepository);
  });

  group('GetHomeDataUseCase Tests', () {
    test('should return HomeEntity when repository call succeeds', () async {
      // Arrange
      final homeEntity = HomeEntity(
        products: [],
        categories: [],
        bestSeller: [],
        occasions: [],
      );
      
      when(mockHomeRepository.getHomeData()).thenAnswer(
        (_) async => Right(homeEntity),
      );

      // Act
      final result = await getHomeDataUseCase.call();

      // Assert
      expect(result.isRight, true);
      expect(result.right, homeEntity);
      verify(mockHomeRepository.getHomeData()).called(1);
    });

    test('should return AppException when repository call fails', () async {
      // Arrange
      final exception = ApiException(message: 'API error');
      when(mockHomeRepository.getHomeData()).thenAnswer(
        (_) async => Left(exception),
      );

      // Act
      final result = await getHomeDataUseCase.call();

      // Assert
      expect(result.isLeft, true);
      expect(result.left, exception);
      verify(mockHomeRepository.getHomeData()).called(1);
    });
  });
}
