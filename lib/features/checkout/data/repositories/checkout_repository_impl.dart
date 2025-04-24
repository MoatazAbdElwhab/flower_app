import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/checkout/data/datasources/remote/checkout_remote_data_source.dart';
import 'package:flower_app/features/checkout/data/models/check_out_requset.dart';
import 'package:flower_app/features/checkout/data/models/payment_success_response.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/checkout/domain/entities/check_out_session_detailes.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;
  CheckoutRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ApiException, List<Address>>> getAddresses() async {
    try {
      final addresses = await remoteDataSource.getAddresses();
      return Right(addresses.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, CheckOutSessionDetails>> createCheckoutSession(
      CheckOutRequest checkOutRequest) async {
    try {
      final response =
          await remoteDataSource.createCheckoutSession(checkOutRequest);
      switch (response) {
        case OnlinePaymentSuccess():
          if (response.sessionUrl.isEmpty) {
            return Left(ApiException(message: 'Session not found'));
          }
          return Right(
            OnlinePaymentDetails(
              sessionUrl: response.sessionUrl,
              successUrl: response.successUrl,
              cancelUrl: response.cancelUrl,
            ),
          );

        case CashPaymentSuccess():
          return Right(CashPaymentDetails());

        default:
          return Left(ApiException(message: 'Unknown response'));
      }
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
