import 'package:flower_app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/home/data/model/response/home/product.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../product_details_page/product_details_page.dart';
import 'card_widgets/card_image.dart';
import 'card_widgets/card_price_row.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAddToCartTap;
  final bool isInCart;

  const ProductCard(
      {super.key,
      required this.product,
      required this.onAddToCartTap,
      required this.isInCart});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey _buttonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.28,
        width: MediaQuery.sizeOf(context).width * 0.42,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.grey.withOpacity(0.5),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: InkWell(
          key: _buttonKey,
          onTap: () => _navigateToProductDetails(context, widget.product),
          child: LayoutBuilder(builder: (context, constrains) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: constrains.maxHeight * 0.58,
                  child: CardImage(
                    image: widget.product.imgCover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Text(
                    widget.product.title != null ? widget.product.title! : '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(color: AppColors.black),
                  ),
                ),
                CardPriceRow(
                  priceAfterDiscount: widget.product.priceAfterDiscount,
                  originalPrice: widget.product.price,
                ),
                ElevatedButton(
                    onPressed: widget.onAddToCartTap,
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
                    child: FittedBox(
                      child: Row(
                        children: [
                          Icon(
                            widget.isInCart
                                ? Icons.remove_circle_outline
                                : Icons.shopping_cart_outlined,
                            color: AppColors.white,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          Text(
                            widget.isInCart
                                ? 'Remove from cart'
                                : 'Add to cart',
                            style: getMediumStyle(
                                color: AppColors.white, fontSize: 13.sp),
                          )
                        ],
                      ),
                    ))
              ],
            );
          }),
        ),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context, Product arguments) {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = renderBox.localToGlobal(Offset.zero);
    final Size buttonSize = renderBox.size;
    final alignment = Alignment(
      (buttonPosition.dx + buttonSize.width / 2) /
              MediaQuery.sizeOf(context).width *
              2 -
          1,
      (buttonPosition.dy + buttonSize.height / 2) /
              MediaQuery.of(context).size.height *
              2 -
          1,
    );
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: RouteSettings(
          name: Routes.productDetailsView,
          arguments: arguments,
        ),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ProductDetailsPage(),
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          Animation<Offset> verticalTween =
              Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                  .animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeIn));
          Animation<Offset> horizontalTween2 =
              Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                  .animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeIn));
          return ScaleTransition(
            scale: animation,
            alignment: alignment,
            child: SlideTransition(
              position: horizontalTween2,
              child: SlideTransition(
                position: verticalTween,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
