import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/checkout/data/models/check_out_requset.dart';
import 'package:flower_app/features/checkout/domain/entities/check_out_session_detailes.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateCheckoutSessionUseCase {
  final CheckoutRepository checkoutRepository;

  CreateCheckoutSessionUseCase(this.checkoutRepository);

  Future<Either<ApiException, CheckOutSessionDetails>> call(
      CheckOutRequest checkOutRequest) async {
    return await checkoutRepository.createCheckoutSession(checkOutRequest);
  }
}
