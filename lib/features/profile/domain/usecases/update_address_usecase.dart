import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUsecase {
  final ProfileRepository _profileRepository;

  UpdateAddressUsecase(this._profileRepository);

  Future<List<Address>> call(Address address) async {
    return await _profileRepository.updateAddress(address);
  }
}
