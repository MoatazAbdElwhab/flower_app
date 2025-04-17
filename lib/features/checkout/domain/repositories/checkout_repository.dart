import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';

abstract class CheckoutRepository {
  Future<Either<ApiException, List<Address>>> getAddresses();
}
