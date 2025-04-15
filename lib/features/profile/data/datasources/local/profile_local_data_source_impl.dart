import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/features/profile/data/datasources/local/profile_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final LocalStorageClient _localStorageClient;

  ProfileLocalDataSourceImpl(this._localStorageClient);

  @override
  Future<void> deleteToken() async {
    await _localStorageClient.deleteData('token');
  }
}
