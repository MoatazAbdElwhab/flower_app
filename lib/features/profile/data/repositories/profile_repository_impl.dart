import 'package:either_dart/either.dart';
import 'package:flower_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl(this._profileRemoteDataSource);

  @override
  Future<Either<Exception, UserData>> getUserData() async {
    try {
      final userData = await _profileRemoteDataSource.getUserData();
      return Right(userData.toEntity());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
