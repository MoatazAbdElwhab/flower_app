import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flower_app/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/locale_keys.g.dart';

class CartPriceAndCheckoutWidget extends StatelessWidget {
  const CartPriceAndCheckoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: BlocBuilder<CartBloc, CartState>(
        // buildWhen: (previous, current) =>
        //     previous.cartTotalPrice != current.cartTotalPrice,
        builder: (context, state) {
          bool shouldShowLoading =
              state.updateQuantityState is BaseLoadingState ||
                  state.removeFromCartState is BaseLoadingState ||
                  state.addToCartState is BaseLoadingState;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.cart_subTotal.tr(),
                    style:
                        getRegularStyle(color: Colors.black, fontSize: 16.sp),
                  ),
                  shouldShowLoading
                      ? const SizedBox(
                          width: 36,
                          height: 2,
                          child: LinearProgressIndicator(),
                        )
                      : Text(
                          '${state.cartTotalPrice - state.deliveryFee} ${LocaleKeys.cart_pound.tr()}',
                          style: getRegularStyle(
                              color: Colors.black, fontSize: 16.sp))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.cart_deliveryFee.tr(),
                        style: getRegularStyle(
                            color: Colors.black, fontSize: 16.sp)),
                    Text('${state.deliveryFee} ${LocaleKeys.cart_pound.tr()}',
                        style: getRegularStyle(
                            color: Colors.black, fontSize: 16.sp))
                  ],
                ),
              ),
              const SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: ColoredBox(
                    color: Colors.grey,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.cart_total.tr(),
                        style: getMediumStyle(
                            color: Colors.black, fontSize: 18.sp)),
                    shouldShowLoading
                        ? const SizedBox(
                            width: 36,
                            height: 2,
                            child: LinearProgressIndicator(),
                          )
                        : Text(
                            '${state.cartTotalPrice} ${LocaleKeys.cart_pound.tr()}',
                            style: getMediumStyle(
                                color: Colors.black, fontSize: 18.sp),
                          )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.checkout);
                },
                child: FittedBox(child: Text(LocaleKeys.cart_checkout.tr())),
              ),
            ],
          );
        },
      ),
    );
  }
}
