import 'package:either_dart/either.dart';
import 'package:flower_app/features/profile/data/models/add_adress_model/add_adress_request.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class AddAddressUseCase {
 final ProfileRepository _profileRepository;
  AddAddressUseCase(this._profileRepository);

  Future<Either<Exception, void>> call(AddAdressRequest addAdressRequset) async => await _profileRepository.addAddress(addAdressRequset);
}
