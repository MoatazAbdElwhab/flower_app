import 'package:either_dart/either.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserDataUseCase {
  final ProfileRepository _profileRepository;

  GetUserDataUseCase(this._profileRepository);

  Future<Either<Exception, UserData>> call() async {
    return await _profileRepository.getUserData();
  }
}
