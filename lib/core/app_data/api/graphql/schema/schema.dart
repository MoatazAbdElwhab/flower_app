// core/app_data/api/graphql/schema/schema.dart
import 'auth_schema.dart';
import 'cart_schema.dart';
import 'product_schema.dart';

class GraphQLSchema {
  static String getSchema() {
    return '''
      ${AuthSchema.userType}
      ${AuthSchema.authResponseType}
      ${AuthSchema.signInInputType}
      ${AuthSchema.signUpInputType}
      ${AuthSchema.passwordResetResponseType}
      ${AuthSchema.apiResponseType}
      
      ${ProductSchema.productType}
      ${ProductSchema.categoryType}
      ${ProductSchema.occasionType}
      ${ProductSchema.reviewType}
      ${ProductSchema.userType}
      ${ProductSchema.pageInfoType}
      ${ProductSchema.productConnectionType}
      
      ${CartSchema.cartItemType}
      ${CartSchema.cartType}
      ${CartSchema.addToCartInputType}
      ${CartSchema.updateCartItemInputType}
      ${CartSchema.cartOperationResponseType}
    ''';
  }
}
