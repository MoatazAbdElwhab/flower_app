// features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart

import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/core/app_data/local_storage/storage_keys.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final LocalStorageClient _localStorageClient;

  AuthLocalDataSourceImpl(this._localStorageClient);

  //-----------------------------Token-----------------------------------
  @override
  Future<void> cacheToken(String token) async {
    await _localStorageClient.saveSecuredData(StorageKeys.token, token);
  }

  @override
  Future<String?> getToken() async {
    return await _localStorageClient.getSecuredData(StorageKeys.token);
  }

  @override
  Future<void> deleteToken() async {
    await _localStorageClient.deleteSecuredData(StorageKeys.token);
  }

  @override
  Future<String?> checkSavedToken() async {
    try {
      return await _localStorageClient.getSecuredData(StorageKeys.token);
    } catch (e) {
      Log.e('Error checking saved token: $e');
      return null;
    }
  }

  //-----------------------------RememberMe-----------------------------------
  @override
  Future<void> cacheRememberMe(bool rememberMe) async {
    await _localStorageClient.saveData(StorageKeys.rememberMe, rememberMe.toString());
  }

  @override
  bool getRememberMe() {
    final value = _localStorageClient.getData(StorageKeys.rememberMe);
    return value != null ? value.toLowerCase() == 'true' : false;
  }

  @override
  Future<void> deleteRememberMe() async {
    await _localStorageClient.deleteData(StorageKeys.rememberMe);
  }
  
  //-----------------------------Guest Account-----------------------------------
  @override
  Future<void> cacheIsGuest(bool isGuest) async {
    await _localStorageClient.saveData(StorageKeys.isGuest, isGuest.toString());
    Log.i('User guest status cached: $isGuest');
  }

  @override
  Future<bool> getIsGuest() async {
    final value = _localStorageClient.getData(StorageKeys.isGuest);
    final isGuest = value != null ? value.toLowerCase() == 'true' : false;
    Log.d('User is guest: $isGuest');
    return isGuest;
  }

  @override
  Future<void> deleteIsGuest() async {
    await _localStorageClient.deleteData(StorageKeys.isGuest);
    Log.i('User guest status cleared');
  }
}
