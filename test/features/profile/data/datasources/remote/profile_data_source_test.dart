import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/features/profile/data/datasources/remote/profile_api_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/get_user_oreders_response/user_orders_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'profile_data_source_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ApiClient apiClient;
  late ProfileApiRemoteDataSource profileApiRemoteDataSource;

  setUp(() {
    apiClient = MockApiClient();
    profileApiRemoteDataSource = ProfileApiRemoteDataSource(apiClient);
  });

  group('ProfileApiRemoteDataSource - getUserOrders Tests', () {
    // Test case 1: Success case - API returns valid response
    test('should return UserOrdersResponse when API call is successful', () async {
      // Arrange
      final mockResponse = {
        'message': 'Success',
        'orders': [
          {
            'orderNumber': 'ORD123',
            'totalPrice': 150,
            'state': 'delivered',
            'orderItems': [
              {
                'price': 50,
                'quantity': 2,
                'product': {
                  'title': 'Rose Bouquet',
                  'imgCover': 'rose.jpg',
                },
              },
            ],
          },
        ],
      };
      when(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await profileApiRemoteDataSource.getUserOrders();

      // Assert
      expect(result, isA<UserOrdersResponse>());
      expect(result.message, 'Success');
      expect(result.orders?.length, 1);
      expect(result.orders?[0].orderNumber, 'ORD123');
      expect(result.orders?[0].totalPrice, 150);
      expect(result.orders?[0].state, 'delivered');
      expect(result.orders?[0].orderItems?.length, 1);
      expect(result.orders?[0].orderItems?[0].price, 50);
      expect(result.orders?[0].orderItems?[0].product?.title, 'Rose Bouquet');
      verify(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).called(1);
      verifyNoMoreInteractions(apiClient);
    });

    // Test case 2: Empty orders list - API returns empty orders
    test('should return UserOrdersResponse with empty orders when API returns empty list', () async {
      // Arrange
      final mockResponse = {
        'message': 'Success',
        'orders': [],
      };
      when(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await profileApiRemoteDataSource.getUserOrders();

      // Assert
      expect(result, isA<UserOrdersResponse>());
      expect(result.message, 'Success');
      expect(result.orders, isEmpty);
      verify(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).called(1);
      verifyNoMoreInteractions(apiClient);
    });

    // Test case 3: Null orders - API returns orders as null
    test('should return UserOrdersResponse with null orders when API returns null', () async {
      // Arrange
      final mockResponse = {
        'message': 'Success',
        'orders': null,
      };
      when(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await profileApiRemoteDataSource.getUserOrders();

      // Assert
      expect(result, isA<UserOrdersResponse>());
      expect(result.message, 'Success');
      expect(result.orders, isNull);
      verify(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).called(1);
      verifyNoMoreInteractions(apiClient);
    });

    // Test case 4: API failure - API throws an exception
    test('should throw ApiException when API call fails', () async {
      // Arrange
      when(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
            () async => await profileApiRemoteDataSource.getUserOrders(),
        throwsA(isA<Exception>()),
      );
      verify(apiClient.get(
        ApiConstants.ordersEndPoint,
        queryParameters: null,
        requiresToken: true,
      )).called(1);
      verifyNoMoreInteractions(apiClient);
    });

  });
}