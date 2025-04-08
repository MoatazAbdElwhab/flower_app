// test/features/home/presentation/cubit/home_cubit_test.dart

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/core/error_handling/exceptions/app_exception.dart';
import 'package:flower_app/core/error_handling/exceptions/network_exception.dart';
import 'package:flower_app/core/services/location_service.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/home/domain/use_case/home_use_case.dart';
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:geolocator/geolocator.dart';

import 'home_cubit_test.mocks.dart';

@GenerateMocks([GetHomeDataUseCase, LocationService])
void main() {
  late HomeCubit homeCubit;
  late MockGetHomeDataUseCase mockGetHomeDataUseCase;
  late MockLocationService mockLocationService;

  // Static test data
  final mockHomeEntity = HomeEntity(
    products: [
      ProductEntity(
          id: '1', title: 'Test Product', price: 100, imgCover: 'image1.jpg'),
    ],
    categories: [
      CategoryOccasionEntity(
          id: '1', name: 'Test Category', image: 'category1.jpg'),
    ],
    bestSeller: [
      ProductEntity(
          id: '2',
          title: 'Best Seller',
          price: 200,
          imgCover: 'bestseller1.jpg'),
    ],
    occasions: [
      CategoryOccasionEntity(
          id: '3', name: 'Test Occasion', image: 'occasion1.jpg'),
    ],
  );

  // Empty home data for testing
  final emptyHomeEntity = HomeEntity(
    products: [],
    categories: [],
    bestSeller: [],
    occasions: [],
  );

  final mockAddress = '123 Test Street, Test City';
  // Create a mock position with all required parameters for the latest geolocator version
  final mockPosition = Position(
    latitude: 31.2001,
    longitude: 29.9187,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  setUp(() {
    mockGetHomeDataUseCase = MockGetHomeDataUseCase();
    mockLocationService = MockLocationService();
    homeCubit = HomeCubit(
      getHomeDataUseCase: mockGetHomeDataUseCase,
      locationService: mockLocationService,
    );
  });

  group('HomeCubit Tests', () {
    group('getHomeData', () {
      test(
          'should emit loading and success states when data is fetched successfully',
          () async {
        // Arrange
        when(mockGetHomeDataUseCase.call())
            .thenAnswer((_) async => Right(mockHomeEntity));

        // Act
        await homeCubit.getHomeData();

        // Assert
        verify(mockGetHomeDataUseCase.call()).called(1);
        expect(homeCubit.homeData, mockHomeEntity);
        expect(homeCubit.state.homeDataState, isA<BaseSuccessState>());
      });

      test('should emit loading and error states when fetching data fails',
          () async {
        // Arrange
        final exception = ApiException(message: 'API error');
        when(mockGetHomeDataUseCase.call())
            .thenAnswer((_) async => Left(exception));

        // Act
        await homeCubit.getHomeData();

        // Assert
        verify(mockGetHomeDataUseCase.call()).called(1);
        expect(homeCubit.homeData, null);
        expect(homeCubit.state.homeDataState, isA<BaseErrorState>());
      });

      test('should handle empty data correctly', () async {
        // Arrange
        when(mockGetHomeDataUseCase.call())
            .thenAnswer((_) async => Right(emptyHomeEntity));

        // Act
        await homeCubit.getHomeData();

        // Assert
        verify(mockGetHomeDataUseCase.call()).called(1);
        expect(homeCubit.homeData, emptyHomeEntity);
        expect(homeCubit.homeData?.products, isEmpty);
        expect(homeCubit.homeData?.categories, isEmpty);
        expect(homeCubit.homeData?.bestSeller, isEmpty);
        expect(homeCubit.homeData?.occasions, isEmpty);
        expect(homeCubit.state.homeDataState, isA<BaseSuccessState>());
      });
    });

    group('getUserLocation', () {
      test(
          'should emit loading and success states when location is fetched successfully',
          () async {
        // Arrange
        when(mockLocationService.getCurrentPosition())
            .thenAnswer((_) async => mockPosition);
        when(mockLocationService.getAddressFromCoordinates(
                mockPosition.latitude, mockPosition.longitude))
            .thenAnswer((_) async => mockAddress);

        // Act
        await homeCubit.getUserLocation();

        // Assert
        verify(mockLocationService.getCurrentPosition()).called(1);
        verify(mockLocationService.getAddressFromCoordinates(
                mockPosition.latitude, mockPosition.longitude))
            .called(1);
        expect(homeCubit.locationAddress, mockAddress);
        expect(homeCubit.state.locationState, isA<BaseSuccessState>());
      });

      test('should emit loading and error states when fetching location fails',
          () async {
        // Arrange
        final exception = NetworkException('Location error');
        when(mockLocationService.getCurrentPosition()).thenThrow(exception);

        // Act
        await homeCubit.getUserLocation();

        // Assert
        verify(mockLocationService.getCurrentPosition()).called(1);
        verifyNever(mockLocationService.getAddressFromCoordinates(any, any));
        expect(homeCubit.locationAddress, "...................");
        expect(homeCubit.state.locationState, isA<BaseErrorState>());
      });

      test('should handle getAddressFromCoordinates failure', () async {
        // Arrange
        when(mockLocationService.getCurrentPosition())
            .thenAnswer((_) async => mockPosition);
        when(mockLocationService.getAddressFromCoordinates(
                mockPosition.latitude, mockPosition.longitude))
            .thenThrow(Exception('Address lookup failed'));

        // Act
        await homeCubit.getUserLocation();

        // Assert
        verify(mockLocationService.getCurrentPosition()).called(1);
        verify(mockLocationService.getAddressFromCoordinates(
                mockPosition.latitude, mockPosition.longitude))
            .called(1);
        expect(homeCubit.locationAddress, "...................");
        expect(homeCubit.state.locationState, isA<BaseErrorState>());
      });

      test('should reset location address when error occurs', () async {
        // First set a valid address
        homeCubit = HomeCubit(
          getHomeDataUseCase: mockGetHomeDataUseCase,
          locationService: mockLocationService,
        );

        // Set initial success
        when(mockLocationService.getCurrentPosition())
            .thenAnswer((_) async => mockPosition);
        when(mockLocationService.getAddressFromCoordinates(
                mockPosition.latitude, mockPosition.longitude))
            .thenAnswer((_) async => mockAddress);
        await homeCubit.getUserLocation();
        expect(homeCubit.locationAddress, mockAddress);

        // Now simulate an error on the second call
        when(mockLocationService.getCurrentPosition())
            .thenThrow(NetworkException('Location error'));

        // Act again
        await homeCubit.getUserLocation();

        // Verify address was reset
        expect(homeCubit.locationAddress, "...................");
      });
    });

    group('Initial state', () {
      test('should have correct initial state', () {
        // Just checking the initial state without any action
        expect(homeCubit.state.homeDataState, isA<BaseInitialState>());
        expect(homeCubit.state.locationState, isA<BaseSuccessState>());
        expect(homeCubit.homeData, null);
        expect(homeCubit.locationAddress, "...................");
      });
    });
  });
}
