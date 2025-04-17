import 'package:either_dart/src/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';

import 'package:injectable/injectable.dart';

import '../../domain/repositories/add_address_repo.dart';
import '../data_sources/add_address_remote_data_source.dart';
import '../models/add_adress_model/add_adress_request.dart';
@Injectable(as: AddAddressRepo)
class AddAddressRepoImpl implements AddAddressRepo{
  final AddAddressRemoteDataSource _addAddressRemoteDataSource;

  AddAddressRepoImpl(this._addAddressRemoteDataSource);
  @override
  Future<Either<ApiException, void>> addAddress(AddAdressRequest addAdressRequest) async{
    try {
      await _addAddressRemoteDataSource.addAddress(addAdressRequest);
      return const Right(null);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}