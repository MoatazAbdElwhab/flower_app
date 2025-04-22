import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/add_adress_model/add_adress_request.dart';
import '../repositories/add_address_repo.dart';
@injectable
class AddAddressUseCase {
  final AddAddressRepo _addAddressRepo;
  AddAddressUseCase(this._addAddressRepo);

  Future<Either<Exception, void>> call(AddAndEditAddressRequest addAdressRequset) async => await _addAddressRepo.addAddress(addAdressRequset);
}
