// features/home/presentation/widget/best_seller_section.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/routes/routes.dart';
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
    return SizedBox(
      height: 220.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //////////////////////////////////////////////////Best seller section header
          SectionHeader(
            title: 'home.sections.best_seller'.tr(),
            onViewAllTap: () {
              Navigator.pushNamed(
                context,
                Routes.bestSeller,
                arguments: bestSellers,
              );
            },
          ),
          SizedBox(height: 10.h),

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
                        product: bestSeller,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.productDetailsView,
                            arguments: bestSeller,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
