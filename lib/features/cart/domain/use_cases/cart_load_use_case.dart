import 'package:flower_app/features/cart/data/models/get_cart_response.dart';
import 'package:flower_app/features/cart/domain/repo/cart_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartLoadUseCase {
  final CartRepoInterface cartRepo;

  CartLoadUseCase(this.cartRepo);

  Future<GetCartResponse> call() async =>
      await cartRepo.getUserCart();
}