// core/app_data/api/graphql/operations/fragments/product_fragment.dart
/// Fragment definition for Product data
class ProductFragments {
  static const String basicInfo = '''
    fragment ProductBasicInfo on Product {
      id
      name
      price
      currency
      discountPercentage
      images
    }
  ''';

  static const String detailedInfo = '''
    fragment ProductDetailedInfo on Product {
      ...ProductBasicInfo
      description
      stock
      rating
      category {
        id
        name
        image
      }
      occasion {
        id
        name
        image
      }
      reviews {
        id
        rating
        comment
        user {
          id
          name
        }
        createdAt
      }
    }
  ''';
}
