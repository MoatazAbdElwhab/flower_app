// features/cart/data/data_source/remote/cart_remote_ds_impl.dart
import 'package:flower_app/core/app_data/api/graphql/graphql_service.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/cart/data/models/get_cart_response.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'cart_remote_ds_interface.dart';

@Injectable(as: CartRemoteDsInterface)
class CartRemoteDsImpl implements CartRemoteDsInterface {
  final GraphQLService _graphQLService;
  final Logger _logger;

  CartRemoteDsImpl(this._graphQLService, this._logger);

  @override
  Future<GetCartResponse> getUserCart() async {
    try {
      final result = await _graphQLService.query(
        document: '''
          query GetCart {
            cart {
              message
              numOfCartItems
              cart {
                _id
                user
                cartItems {
                  _id
                  product {
                    _id
                    title
                    imageCover
                    category {
                      name
                    }
                    price
                  }
                  quantity
                  price
                }
                discount
                totalPrice
                totalPriceAfterDiscount
                createdAt
                updatedAt
                __v
              }
            }
          }
        ''',
      );

      final data = result.data?['cart'];
      if (data == null) {
        return GetCartResponse(message: "Cart is empty", numOfCartItems: 0);
      }

      return GetCartResponse.fromJson(data);
    } catch (e) {
      _logger.e('Error getting cart: $e');
      throw Exception('Failed to get cart: $e');
    }
  }

  @override
  Future<void> addProductToCart(String productId) async {
    try {
      await _graphQLService.mutate(
        document: '''
          mutation AddToCart(\$productId: ID!) {
            addToCart(productId: \$productId) {
              message
              numOfCartItems
            }
          }
        ''',
        variables: <String, dynamic>{
          'productId': productId,
        },
      );
    } catch (e) {
      _logger.e('Error adding product to cart: $e');
      throw Exception('Failed to add product to cart: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _graphQLService.mutate(
        document: '''
          mutation ClearCart {
            clearCart {
              message
            }
          }
        ''',
      );
    } catch (e) {
      _logger.e('Error clearing cart: $e');
      throw Exception('Failed to clear cart: $e');
    }
  }

  @override
  Future<void> removeProductFromCart(String productId) async {
    try {
      await _graphQLService.mutate(
        document: '''
          mutation RemoveFromCart(\$productId: ID!) {
            removeFromCart(productId: \$productId) {
              message
              numOfCartItems
            }
          }
        ''',
        variables: <String, dynamic>{
          'productId': productId,
        },
      );
    } catch (e) {
      _logger.e('Error removing product from cart: $e');
      throw Exception('Failed to remove product from cart: $e');
    }
  }

  @override
  Future<void> updateProductQuantity(String productId, int quantity) async {
    try {
      await _graphQLService.mutate(
        document: '''
          mutation UpdateCartItemQuantity(\$productId: ID!, \$quantity: Int!) {
            updateCartItemQuantity(productId: \$productId, quantity: \$quantity) {
              message
              numOfCartItems
            }
          }
        ''',
        variables: <String, dynamic>{
          'productId': productId,
          'quantity': quantity,
        },
      );
    } catch (e) {
      _logger.e('Error updating product quantity: $e');
      throw Exception('Failed to update product quantity: $e');
    }
  }
}
