import 'package:either_dart/either.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';

abstract class ProfileRepository {
  Future<Either<Exception, UserData>> getUserData();
}
