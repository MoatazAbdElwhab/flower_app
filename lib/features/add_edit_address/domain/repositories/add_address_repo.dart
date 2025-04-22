import 'package:either_dart/either.dart';

import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../data/models/add_adress_model/add_adress_request.dart';

abstract class AddAddressRepo {
  Future<Either<ApiException, void>> addAddress(
      AddAndEditAddressRequest addAddressRequest);
}