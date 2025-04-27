// core/app_data/api/api_constants.dart
class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1/';
  static const String sinUpEndPoint = 'auth/signup';
  static const String logInEndPoint = 'auth/signin';
  static const String homeEndPoint = 'home';
  static const String getProudctByCategoryEndPoint = 'products';
  static const String forgetPasswordEndPoint = 'auth/forgotPassword';
  static const String verifyResetCodeEndPoint = 'auth/verifyResetCode';
  static const String resetPasswordEndPoint = 'auth/resetPassword';
  static const String occasionsEndPoint = 'products';
  static const String profileDataEndPoint = 'auth/profile-data';
  static const String editProfileEndPoint = 'auth/editProfile';
  static const String logOutEndPoint = 'auth/logout';
  static const String cart = 'cart';
  static const String changePasswordEndPoint = 'auth/change-password';
  static const String addressesEndPoint = 'addresses';
  static const String ordersEndPoint = 'orders';
  static const String checkoutSessionEndPoint = 'orders/checkout';
  static const String checkoutSessionCashEndPoint = 'orders';
  static const String notificationsEndPoint = 'notifications?sort=-createdAt';
}
