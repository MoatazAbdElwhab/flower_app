import 'dart:developer';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../features/cart/presentation/bloc/cart_state.dart';
import '../../../../features/cart/presentation/bloc/event.dart';
import '../../../base/base_state.dart';
import '../../../di/injectable.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_styles.dart';

class CardAddAndRemoveButton extends StatefulWidget {
  final ProductEntity product;
  const CardAddAndRemoveButton({super.key, required this.product});

  @override
  State<CardAddAndRemoveButton> createState() => _CardAddAndRemoveButtonState();
}

class _CardAddAndRemoveButtonState extends State<CardAddAndRemoveButton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        final utils = getIt<DialogUtils>();
        if (state.addToCartState is BaseErrorState ||
            state.removeFromCartState is BaseErrorState) {
          utils.showSnackBar(
              textColor: Colors.red,
              message: (state.addToCartState as BaseErrorState).errorMessage,
              context: context);
        } else if (state.updateQuantityState is BaseErrorState) {
          utils.showSnackBar(
              textColor: Colors.red,
              message: 'something went in updating product quantity,\n'
                  '${(state.addToCartState as BaseErrorState).errorMessage}',
              context: context);
        }
      },
      builder: (context, state) => BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          bool isCart = state.addToCartState is BaseLoadingState;
          bool isInCart = (state.cartProducts ?? []).any(
            (element) => element.id == widget.product.id,
          );
          return ElevatedButton(
              onPressed: () {
                if (state.addToCartState is! BaseLoadingState &&
                    state.removeFromCartState is! BaseLoadingState) {
                  context.read<CartBloc>().add(isInCart
                      ? CartRemoveProductEvent(productId: widget.product.id)
                      : CartAddProductEvent(product: widget.product));
                }
              },
              style: ElevatedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                maximumSize: Size(double.infinity, 30.h),
                minimumSize: Size(double.infinity, 30.h),
                fixedSize: Size(double.infinity, 30.h),
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              child: (state.addToCartState is BaseLoadingState ||
                          state.removeFromCartState is BaseLoadingState) &&
                      state.activeCartItemId == widget.product.id
                  ? SizedBox(
                      height: 4.h,
                      width: 60.w,
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.grey,
                      ))
                  : FittedBox(
                      child: Row(
                        children: [
                          Icon(
                            isInCart
                                ? Icons.remove_circle_outline
                                : Icons.shopping_cart_outlined,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            isInCart ? 'Remove from cart' : 'Add to cart',
                            style: getMediumStyle(
                                color: AppColors.white, fontSize: 13.sp),
                          )
                        ],
                      ),
                    ));
        },
      ),
    );
  }
}
