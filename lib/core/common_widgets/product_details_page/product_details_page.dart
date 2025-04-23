import 'package:flower_app/features/cart/presentation/bloc/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../../features/cart/presentation/bloc/cart_state.dart';
import '../../../features/home/domain/entities/product_entity.dart';
import '../../base/base_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../app_carousel/app_carousel.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntity productArgument;
  const ProductDetailsPage({super.key, required this.productArgument});

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<CartBloc>();
    // bool isInCart = context.read<CartBloc>().state.cartProducts?.any(
    //       (element) {
    //     return element.id == productArgument.id;
    //   },
    // ) ??
    //     false;

    ///  product dm is dummy class implemented below to show how to use it;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            /// wrapped with column to always show add to cart button
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    productArgument.images.isNotEmpty
                        ? AppCarousel(
                            networkImages: productArgument.images,
                          )
                        : SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.5,
                            child: const Icon(
                              Icons.warning_amber_outlined,
                              color: AppColors.grey,
                            ),
                          ),

                    // product details
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price
                          Text(
                            "EGP ${productArgument.priceAfterDiscount.toStringAsFixed(2)}",
                            style: getBoldStyle(
                                color: Colors.black, fontSize: 20.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            productArgument.title,
                            style: getMediumStyle(
                                color: Colors.black, fontSize: 16.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Text('Description',
                                style: getMediumStyle(
                                    color: Colors.black, fontSize: 16.sp)),
                          ),
                          Text(productArgument.description,
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: 14.sp)),
                        ],
                      ),
                    ),
                    // Add to Cart Button
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  bool isInCart = state.cartProducts?.any(
                        (p) => p.id == productArgument.id,
                      ) ??
                      false;
                  return ElevatedButton(
                    onPressed: () {
                      if (state.addToCartState is! BaseLoadingState &&
                          state.removeFromCartState is! BaseLoadingState) {
                        context.read<CartBloc>().add(isInCart
                            ? CartRemoveProductEvent(
                                productId: productArgument.id)
                            : CartAddProductEvent(product: productArgument));
                      }
                    },
                    child: (state.addToCartState is BaseLoadingState ||
                                state.removeFromCartState
                                    is BaseLoadingState) &&
                            state.activeCartItemId == productArgument.id
                        ? SizedBox(
                            height: 20.h,
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: Center(
                              child: LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.grey,
                              ),
                            ))
                        : Text(
                            isInCart ? 'Remove from cart' : 'Add to cart',
                            style: getMediumStyle(
                                color: AppColors.white, fontSize: 16.sp),
                          ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
