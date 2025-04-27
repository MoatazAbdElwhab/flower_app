/// Constants for storage keys used across the application
class StorageKeys {
  StorageKeys._();
  
  // Authentication keys
  static const String token = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String rememberMe = 'remember_me';
  static const String user = 'user_data';
  static const String isGuest = 'is_guest';
  
  // User preferences
  static const String language = 'selected_language';
  static const String theme = 'selected_theme';
  static const String notifications = 'notifications_enabled';
  
  // Cache keys
  static const String homeCache = 'home_data_cache';
  static const String categoriesCache = 'categories_cache';
  static const String occasionsCache = 'occasions_cache';
  static const String productsCache = 'products_cache';
}
