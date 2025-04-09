import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class BestSellerPage extends StatelessWidget {
  const BestSellerPage({super.key, required this.productEntityList});
  final List<ProductEntity> productEntityList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 38,
        leading: IconButton(
          padding: const EdgeInsets.only(
            left: 16,
            right: 0,
          ),
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(LocaleKeys.bestSeller_title.tr(),
                style: getMediumStyle(color: AppColors.black, fontSize: 20)),
            Text(LocaleKeys.bestSeller_description.tr(),
                style: getLightStyle(color: AppColors.grey, fontSize: 13)),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: productEntityList.length,
            padding: const EdgeInsets.only(
              top: 16,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => ProductCard(
                product: productEntityList[index],
                onAddToCartTap: () {},
                isInCart: false),
          ),
        ),
      ),
    );
  }
}
