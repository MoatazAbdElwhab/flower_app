// core/app_data/api/graphql/schema/cart_schema.dart
class CartSchema {
  static const String cartItemType = '''
    type CartItem {
      id: ID!
      product: Product!
      quantity: Int!
      totalPrice: Float!
    }
  ''';

  static const String cartType = '''
    type Cart {
      id: ID!
      items: [CartItem!]!
      subtotal: Float!
      totalDiscount: Float!
      deliveryFee: Float!
      total: Float!
      currency: String!
      itemCount: Int!
    }
  ''';

  static const String addToCartInputType = '''
    input AddToCartInput {
      productId: ID!
      quantity: Int!
    }
  ''';

  static const String updateCartItemInputType = '''
    input UpdateCartItemInput {
      cartItemId: ID!
      quantity: Int!
    }
  ''';

  static const String cartOperationResponseType = '''
    type CartOperationResponse {
      success: Boolean!
      message: String
      cart: Cart
    }
  ''';
}
