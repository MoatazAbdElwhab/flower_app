import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressesUseCase {
  final CheckoutRepository repository;
  GetAddressesUseCase(this.repository);

  Future<Either<ApiException, List<Address>>> call() async {
    return await repository.getAddresses();
  }
}
