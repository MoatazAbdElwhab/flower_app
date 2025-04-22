import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/checkout/data/models/check_out_requset.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/checkout/domain/entities/check_out_session_detailes.dart';

abstract class CheckoutRepository {
  Future<Either<ApiException, List<Address>>> getAddresses();
  Future<Either<ApiException, CheckOutSessionDetails>> createCheckoutSession(
      CheckOutRequest checkOutRequest);
}
