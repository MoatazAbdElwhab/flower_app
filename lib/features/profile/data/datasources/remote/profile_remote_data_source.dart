import 'package:flower_app/features/profile/data/models/profile_data_response/user_data_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserDataModel> getUserData();
}
