// features/home/presentation/widget/best_seller_section.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/home/presentation/widget/item_card.dart';
import 'package:flower_app/features/home/presentation/widget/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerSection extends StatelessWidget {
  final List<ProductEntity> bestSellers;

  const BestSellerSection({
    super.key,
    required this.bestSellers,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerSpacing = size.height * 0.01;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //////////////////////////////////////////////////Best seller section header
        SectionHeader(title: 'home.sections.best_seller'.tr()),
        SizedBox(height: headerSpacing),

        //////////////////////////////////////////////////best seller list view
        Expanded(
          child: bestSellers.isEmpty
              ? Center(child: Text('home.empty_states.best_sellers'.tr()))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: bestSellers.length,
                  itemBuilder: (context, index) {
                    final bestSeller = bestSellers[index];
                    return ItemCard(
                      id: bestSeller.id,
                      title: bestSeller.title,
                      imageUrl: bestSeller.imgCover,
                      showPrice: true,
                      price: bestSeller.price?.toString(),
                      discountPrice: bestSeller.priceAfterDiscount?.toString(),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
