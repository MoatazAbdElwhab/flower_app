import 'package:flower_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartAddProductUseCase {
  final CartRepoInterface cartRepo;

  CartAddProductUseCase(this.cartRepo);

  Future<void> call(String productId) async =>
      await cartRepo.addProductToCart(productId);
}
