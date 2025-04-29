import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUsecase {
  final ProfileRepository _profileRepository;

  DeleteAddressUsecase(this._profileRepository);

  Future<void> call(String id) async {
    return await _profileRepository.deleteAddress(id);
  }
}
