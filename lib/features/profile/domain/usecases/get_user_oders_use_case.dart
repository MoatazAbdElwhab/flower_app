import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserOdersUseCase {
  final ProfileRepository _profileRepository;

  GetUserOdersUseCase(this._profileRepository);

  Future<Either<ApiException,List<UserOrdersEntitiy>>> call() async {
    return await _profileRepository.getUserOrders();
  }
}