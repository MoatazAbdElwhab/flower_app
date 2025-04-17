import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/di/injectable.dart';
import '../../../../../../core/theme/app_styles.dart';
import '../../../bloc/cart_state.dart';
import '../../../bloc/event.dart';

class CartProductPriceAndQuantitySection extends StatefulWidget {
  final ProductEntity productEntity;
  const CartProductPriceAndQuantitySection(this.productEntity, {super.key});
  @override
  State<CartProductPriceAndQuantitySection> createState() => _State();
}

class _State extends State<CartProductPriceAndQuantitySection> {
  late int currentProductQuantity;

  @override
  void didChangeDependencies() {
    currentProductQuantity = widget.productEntity.cartQuantity ?? 0;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listenWhen: (previous, current) {
        final currentStateQuantity = current.cartProducts
                ?.firstWhere(
                  (element) => element.id == widget.productEntity.id,
                )
                .cartQuantity ??
            0;
        final previousStateQuantity = previous.cartProducts
                ?.firstWhere(
                  (element) => element.id == widget.productEntity.id,
                )
                .cartQuantity ??
            0;
        return currentStateQuantity != previousStateQuantity ||
            previous.updateQuantityState != current.updateQuantityState;
      },
      listener: (context, state) {
        final utils = getIt<DialogUtils>();
        if (state.updateQuantityState is BaseErrorState) {
          utils.showSnackBar(
              textColor: Colors.red,
              message: LocaleKeys.cart_errorUpdateQuantity.tr(),
              context: context);
        } else if (state.updateQuantityState is BaseSuccessState) {
          final quantityInState = state.cartProducts
              ?.firstWhere(
                (element) =>
                    element.id == widget.productEntity.id &&
                    element.id == state.activeCartItemId,
              )
              .cartQuantity;
          utils.showSnackBar(
              textColor: Colors.green,
              duration: const Duration(milliseconds: 500),
              message:
                  '${LocaleKeys.cart_quantityUpdatedTo.tr()} ${quantityInState.toString()}',
              context: context);
        }
      },
      builder: (context, state) {
        if (state.updateQuantityState is BaseErrorState) {
          final stateProduct = state.cartProducts
              ?.firstWhere((element) => element.id == widget.productEntity.id);
          _resetQuantity(stateProduct);
        }
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '${LocaleKeys.cart_pound.tr()} ${widget.productEntity.price * currentProductQuantity}',
                  style: getBoldStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(children: [
                Visibility(
                  visible: currentProductQuantity > 1,
                  // inkwell to give the touch effect
                  replacement: InkWell(
                      child: Icon(
                    Icons.remove,
                    color: Colors.grey.withOpacity(0.5),
                  )),
                  child: InkWell(
                      onTap: () {
                        _updateQuantity(
                            increase: false,
                            updateQuantityState: state.updateQuantityState);
                      },
                      child: const Icon(Icons.remove)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text((currentProductQuantity).toString()),
                ),
                InkWell(
                    onTap: () {
                      _updateQuantity(
                          increase: true,
                          updateQuantityState: state.updateQuantityState);
                    },
                    child: const Icon(Icons.add)),
              ]),
            ]);
      },
    );
  }

  void _resetQuantity(ProductEntity? stateProduct) {
    if (stateProduct == null || stateProduct.cartQuantity == null) {
      log('error : null state product or null quantity');
      return;
    }
    if (stateProduct.cartQuantity != currentProductQuantity) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          getIt<DialogUtils>().showSnackBar(
              textColor: Colors.red,
              message: '${LocaleKeys.cart_resetQuantityErrorMsg.tr()}',
              context: context);
          setState(() {
            currentProductQuantity = stateProduct.cartQuantity!;
          });
        }
      });
    }
  }

  void _updateQuantity(
      {required bool increase, required BaseState? updateQuantityState}) {
    if (mounted && updateQuantityState is! BaseErrorState) {
      setState(() {
        increase ? currentProductQuantity++ : currentProductQuantity--;
      });
    }
    context.read<CartBloc>().add(CartUpdateProductQuantityEvent(
        productId: widget.productEntity.id, quantity: currentProductQuantity));
  }
}
