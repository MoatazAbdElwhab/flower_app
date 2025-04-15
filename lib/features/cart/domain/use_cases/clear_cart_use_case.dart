import 'package:flower_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearCartUseCase {
  final CartRepoInterface cartRepo;

  ClearCartUseCase(this.cartRepo);

  Future<void> call() async =>
      await cartRepo.clearCart();
}
