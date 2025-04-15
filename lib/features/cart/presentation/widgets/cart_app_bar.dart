import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../generated/locale_keys.g.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackButton;
  final int cartProductsLength;
  const CartAppBar({super.key, required this.onBackButton, required this.cartProductsLength});

  @override
  Widget build(BuildContext context) {
    const double backBtnWidth =  38;
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leadingWidth: 230,
      leading: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Center(child: Icon(Icons.arrow_back_ios_sharp)),
            style: ButtonStyle(
                shape: WidgetStateProperty.all(const CircleBorder()),
                fixedSize: const WidgetStatePropertyAll(
                    Size(backBtnWidth, backBtnWidth))),
            onPressed: onBackButton,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(LocaleKeys.cart_cart.tr(),
                style:
                getMediumStyle(color: AppColors.black, fontSize: 20)),
          ),
          if(cartProductsLength != 0)
          Text(
              '( $cartProductsLength ${LocaleKeys.cart_items.tr()} )',)
        ],
      ),
    );
  }
@override
  Size get preferredSize => const Size(double.infinity, 40);
}
