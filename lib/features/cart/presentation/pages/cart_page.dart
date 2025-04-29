import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/common_widgets/dummy_widgets/dummy_widgets.dart';
import 'package:flower_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flower_app/features/cart/presentation/widgets/cart_product/cart_product.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/app_styles.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_app_bar.dart';
import '../widgets/cart_price_and_checkout.dart';

class CartPage extends StatefulWidget {
  final VoidCallback onBackButton;
  const CartPage({super.key, required this.onBackButton});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state.getCartState is BaseSuccessState &&
          state.cartProducts != null) {
        return Scaffold(
          appBar: CartAppBar(
              onBackButton: widget.onBackButton,
              cartProductsLength: state.cartProducts?.length ?? 0),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        LocaleKeys.cart_deliverTo.tr(),
                        style:
                            getBoldStyle(fontSize: 16.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                state.cartProducts!.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.cartProducts!.length,
                          itemBuilder: (context, index) {
                            final product = state.cartProducts![index];
                            return CartProductWidget(
                              productEntity: product,
                              key: ValueKey(state.cartProducts![index].id),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          LocaleKeys.cart_cartEmpty.tr(),
                          style: getBoldStyle(color: Colors.black),
                        ),
                      ),
                if (state.cartProducts!.isNotEmpty)
                  const CartPriceAndCheckoutWidget()
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.cart_cart.tr())),
          body: Skeletonizer(
            enabled: true,
            child: Column(
              children: AppDummyWidgets().dummyCartProductsList,
            ),
          ),
        );
      }
    });
  }
}
