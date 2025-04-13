import 'package:either_dart/either.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final ProfileRepository _profileRepository;

  LogoutUseCase(this._profileRepository);

  Future<Either<Exception, void>> call() async {
    return await _profileRepository.logout();
  }
}
