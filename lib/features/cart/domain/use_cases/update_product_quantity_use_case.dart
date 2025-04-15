import 'package:flower_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartUpdateProductQuantityUseCase {
  final CartRepoInterface cartRepo;

  CartUpdateProductQuantityUseCase(this.cartRepo);

  Future<void> call(String productId, int quantity) async =>
      await cartRepo.updateProductQuantity(productId, quantity);
}
