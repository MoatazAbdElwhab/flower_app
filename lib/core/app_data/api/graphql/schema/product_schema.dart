// core/app_data/api/graphql/schema/product_schema.dart
class ProductSchema {
  static const String productType = '''
    type Product {
      id: ID!
      name: String!
      price: Float!
      currency: String!
      discountPercentage: Float
      images: [String!]!
      description: String
      stock: Int
      rating: Float
      category: Category
      occasion: Occasion
      reviews: [Review!]
    }
  ''';

  static const String categoryType = '''
    type Category {
      id: ID!
      name: String!
      image: String
      products: [Product!]
    }
  ''';

  static const String occasionType = '''
    type Occasion {
      id: ID!
      name: String!
      image: String
      products: [Product!]
    }
  ''';

  static const String reviewType = '''
    type Review {
      id: ID!
      rating: Float!
      comment: String
      user: User!
      createdAt: String!
    }
  ''';

  static const String userType = '''
    type User {
      id: ID!
      name: String!
      profileImage: String
    }
  ''';

  static const String pageInfoType = '''
    type PageInfo {
      totalItems: Int!
      totalPages: Int!
      currentPage: Int!
      hasNextPage: Boolean!
    }
  ''';

  static const String productConnectionType = '''
    type ProductConnection {
      items: [Product!]!
      pageInfo: PageInfo!
    }
  ''';
}
