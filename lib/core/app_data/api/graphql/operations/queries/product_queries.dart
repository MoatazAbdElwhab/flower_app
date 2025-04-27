// core/app_data/api/graphql/operations/queries/product_queries.dart
import '../fragments/product_fragment.dart';

class ProductQueries {
  static String getAllProducts() {
    return '''
      query GetAllProducts(\$page: Int, \$limit: Int, \$categoryId: ID, \$searchQuery: String) {
        products(page: \$page, limit: \$limit, categoryId: \$categoryId, searchQuery: \$searchQuery) {
          items {
            ...ProductBasicInfo
          }
          pageInfo {
            totalItems
            totalPages
            currentPage
            hasNextPage
          }
        }
      }
      ${ProductFragments.basicInfo}
    ''';
  }

  static String getBestSellerProducts() {
    return '''
      query GetBestSellerProducts(\$limit: Int) {
        bestSellerProducts(limit: \$limit) {
          ...ProductBasicInfo
        }
      }
      ${ProductFragments.basicInfo}
    ''';
  }
  
  static String getProductById() {
    return '''
      query GetProductById(\$id: ID!) {
        product(id: \$id) {
          ...ProductDetailedInfo
        }
      }
      ${ProductFragments.basicInfo}
      ${ProductFragments.detailedInfo}
    ''';
  }
  
  static String getProductsByOccasion() {
    return '''
      query GetProductsByOccasion(\$occasionId: ID!, \$page: Int, \$limit: Int) {
        productsByOccasion(occasionId: \$occasionId, page: \$page, limit: \$limit) {
          items {
            ...ProductBasicInfo
          }
          pageInfo {
            totalItems
            totalPages
            currentPage
            hasNextPage
          }
        }
      }
      ${ProductFragments.basicInfo}
    ''';
  }

  static String searchProducts() {
    return '''
      query SearchProducts(\$query: String!, \$categoryId: ID, \$page: Int, \$limit: Int) {
        searchProducts(query: \$query, categoryId: \$categoryId, page: \$page, limit: \$limit) {
          items {
            ...ProductBasicInfo
          }
          pageInfo {
            totalItems
            totalPages
            currentPage
            hasNextPage
          }
        }
      }
      ${ProductFragments.basicInfo}
    ''';
  }
}
