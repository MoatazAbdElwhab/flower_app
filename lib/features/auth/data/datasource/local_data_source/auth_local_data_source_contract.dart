// features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart

abstract class AuthLocalDataSourceContract {
  //-----------------------------cacheToken-----------------------------------
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  //-----------------------------cacheRememberMe-----------------------------------
  Future<void> cacheRememberMe(bool rememberMe);
  bool? getRememberMe();
  Future<void> deleteRememberMe();
}
