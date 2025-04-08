// test/features/home/data/repository/home_repository_impl_test.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/app_exception.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/data/datasource/home_data_source_contract.dart';
import 'package:flower_app/features/home/data/model/response/home/home.dart';
import 'package:flower_app/features/home/data/repo/home_repository_impl.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_impl_test.mocks.dart';

// Generate mocks for testing
@GenerateMocks([HomeDataSourceContract])
void main() {
  late HomeRepositoryImpl homeRepository;
  late MockHomeDataSourceContract mockRemoteDataSource;
  
  // Simple static test data
  final mockHomeResponse =  Home(
    products: [],
    categories: [],
    bestSeller: [],
    occasions: [],
  );

  setUp(() {
    mockRemoteDataSource = MockHomeDataSourceContract();
    homeRepository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  group('HomeRepositoryImpl Tests', () {
    test('should return HomeEntity when remote data source call succeeds', () async {
      // Arrange
      when(mockRemoteDataSource.getHomeData())
          .thenAnswer((_) async => Right(mockHomeResponse));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result.isRight, true);
      expect(result.right, isA<HomeEntity>());
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test('should return AppException when remote data source call fails', () async {
      // Arrange
      final exception = ApiException(message: 'API error');
      when(mockRemoteDataSource.getHomeData()).thenAnswer((_) async => Left(exception));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result.isLeft, true);
      expect(result.left, exception);
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });

    test('should handle generic exceptions and convert to AppException', () async {
      // Arrange
      when(mockRemoteDataSource.getHomeData())
          .thenThrow(Exception('Unknown error'));

      // Act
      final result = await homeRepository.getHomeData();

      // Assert
      expect(result.isLeft, true);
      expect(result.left, isA<AppException>());
      verify(mockRemoteDataSource.getHomeData()).called(1);
    });
  });
}
