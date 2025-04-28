import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/profile/data/datasources/local/profile_local_data_source.dart';
import 'package:flower_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/get_user_oreders_response/user_orders_response.dart';
import 'package:flower_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/order_items_entity.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_products_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'profile_repo_test.mocks.dart';


Either<ApiException, List<UserOrdersEntitiy>> _dummyData() =>
    const Right(<UserOrdersEntitiy>[]);

@GenerateMocks([ProfileRemoteDataSource, ProfileLocalDataSource])
void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileRemoteDataSource mockRemoteDataSource;
  late ProfileLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    mockLocalDataSource = MockProfileLocalDataSource();
    repository = ProfileRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);

    provideDummy<Either<ApiException, List<UserOrdersEntitiy>>>(_dummyData());
  });

  group('ProfileRepositoryImpl - getUserOrders Tests', () {
    test(
      'should return Right with List<UserOrdersEntity> when data source succeeds',
          () async {
        // Arrange
        final mockResponse = UserOrdersResponse(
          message: 'Success',
          metadata: Metadata(
            currentPage: 1,
            totalPages: 2,
            limit: 10,
            totalItems: 15,
          ),
          orders: [
            Orders(
              orderNumber: 'ORD123',
              totalPrice: 150,
              state: 'delivered',
              orderItems: [
                OrderItems(
                  price: 50,
                  quantity: 2,
                  id: 'ITEM1',
                  product: Product(
                    title: 'Rose Bouquet',
                    imgCover: 'rose.jpg',
                    id: 'PROD1',
                  ),
                ),
              ],
            ),
          ],
        );
        final expectedOrders = [
          UserOrdersEntitiy(
            id: 'ORD123',
            totalPrice: 150,
            state: 'delivered',
            orderItem: OrderItemsEntity(
              price: 50,
              product: UserProductsEntity(
                title: 'Rose Bouquet',
                imgCover: 'rose.jpg',
              ),
            ),
          ),
        ];
        when(mockRemoteDataSource.getUserOrders())
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getUserOrders();

        // Assert
        expect(result, isA<Right<ApiException, List<UserOrdersEntitiy>>>());
        expect(result.right.length, expectedOrders.length);
        expect(result.right[0].id, expectedOrders[0].id);
        expect(result.right[0].totalPrice, expectedOrders[0].totalPrice);
        expect(result.right[0].state, expectedOrders[0].state);
        expect(result.right[0].orderItem.price, expectedOrders[0].orderItem.price);
        expect(result.right[0].orderItem.product.title, expectedOrders[0].orderItem.product.title);
        expect(result.right[0].orderItem.product.imgCover, expectedOrders[0].orderItem.product.imgCover);
        verify(mockRemoteDataSource.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Right with empty list when data source returns empty orders',
          () async {
        // Arrange
        final mockResponse = UserOrdersResponse(orders: []);
        when(mockRemoteDataSource.getUserOrders())
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getUserOrders();

        // Assert
        expect(result, isA<Right<ApiException, List<UserOrdersEntitiy>>>());
        expect(result.right, isEmpty);
        verify(mockRemoteDataSource.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Right with empty list when data source returns null orders', () async {
        // Arrange
        final mockResponse = UserOrdersResponse(orders: null);
        when(mockRemoteDataSource.getUserOrders())
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getUserOrders();

        // Assert
        expect(result, isA<Right<ApiException, List<UserOrdersEntitiy>>>());
        expect(result.right, isEmpty);
        verify(mockRemoteDataSource.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return Left with ApiException when data source throws an error',
          () async {
        // Arrange
        final exception = Exception('Network error');
        when(mockRemoteDataSource.getUserOrders()).thenThrow(exception);

        // Act
        final result = await repository.getUserOrders();

        // Assert
        expect(result, isA<Left<ApiException, List<UserOrdersEntitiy>>>());
        expect(result.left.message, contains('Network error'));
        verify(mockRemoteDataSource.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should handle empty orderItems in response gracefully',
          () async {
        // Arrange
        final mockJson = {
          'orders': [
            {
              'orderNumber': 'ORD123',
              'totalPrice': 150,
              'state': 'delivered',
              'orderItems': [],
            },
          ],
        };
        final mockResponse = UserOrdersResponse.fromJson(mockJson);
        final expectedOrders = [
          UserOrdersEntitiy(
            id: 'ORD123',
            totalPrice: 150,
            state: 'delivered',
            orderItem: OrderItemsEntity(
              price: 0,
              product: UserProductsEntity(
                title: '',
                imgCover: '',
              ),
            ),
          ),
        ];
        when(mockRemoteDataSource.getUserOrders())
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getUserOrders();

        // Assert
        if (result.isLeft) {
          fail('Expected Right but got Left: ${result.left.message}');
        }
        expect(result, isA<Right<ApiException, List<UserOrdersEntitiy>>>());
        expect(result.right.length, expectedOrders.length);
        expect(result.right[0].id, expectedOrders[0].id);
        expect(result.right[0].totalPrice, expectedOrders[0].totalPrice);
        expect(result.right[0].state, expectedOrders[0].state);
        expect(result.right[0].orderItem.price, expectedOrders[0].orderItem.price);
        expect(result.right[0].orderItem.product.title, expectedOrders[0].orderItem.product.title);
        expect(result.right[0].orderItem.product.imgCover, expectedOrders[0].orderItem.product.imgCover);
        verify(mockRemoteDataSource.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should handle null product in orderItems gracefully', () async {
        // Arrange
        final mockResponse = UserOrdersResponse(
          orders: [
            Orders(
              orderNumber: 'ORD123',
              totalPrice: 150,
              state: 'delivered',
              orderItems: [
                OrderItems(
                  price: 50,
                  quantity: 2,
                  id: 'ITEM1',
                  product: null,
                ),
              ],
            ),
          ],
        );
        final expectedOrders = [
          UserOrdersEntitiy(
            id: 'ORD123',
            totalPrice: 150,
            state: 'delivered',
            orderItem: OrderItemsEntity(
              price: 50,
              product: UserProductsEntity(
                title: '',
                imgCover: '',
              ),
            ),
          ),
        ];
        when(mockRemoteDataSource.getUserOrders())
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getUserOrders();

        // Assert
        expect(result, isA<Right<ApiException, List<UserOrdersEntitiy>>>());
        expect(result.right.length, expectedOrders.length);
        expect(result.right[0].orderItem.price, 50);
        expect(result.right[0].orderItem.product.title, '');
        expect(result.right[0].orderItem.product.imgCover, '');
        verify(mockRemoteDataSource.getUserOrders()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}