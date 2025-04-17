import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../features/cart/presentation/widgets/cart_product/cart_product.dart';
import '../../../features/home/domain/entities/product_entity.dart';

class AppDummyWidgets {
  get dummyCartProductsList => [
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover: 'https://picsum.photos/id/237/200/300',
                price: 2354622,
                priceAfterDiscount: 2222222222222222,
                images: const [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description:
                    'sdsds fsdsa asd ad asd ssd a asddasasd  asd asd asd asd sad asd asd asd asd  asd asd asd asdasd')),
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover:
                    'https://images.pexels.com/photos/213399/pexels-photo-213399.jpeg',
                price: 222,
                priceAfterDiscount: 2222,
                images: const [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description: 'asd asdasd')),
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover: 'https://i.imgur.com/RRUe0Mo.png',
                price: 222,
                priceAfterDiscount: 2222,
                images: [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description: 'asd asdasd')),
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover: 'https://i.imgur.com/RRUe0Mo.png',
                price: 222,
                priceAfterDiscount: 2222,
                images: const [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description: 'asd asdasd'))
      ];
      
  // Product grid skeleton loader for search results and similar pages
  static Widget buildProductsGridSkeleton({int itemCount = 4}) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7.r,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ProductCard(
            product: ProductEntity(
              id: '',
              title: LocaleKeys.home_sections_best_seller.tr(),
              price: 600,
              priceAfterDiscount: 0,
              imgCover: '',
              images: const [],
              description: '',
            ),
          );
        },
      ),
    );
  }
}
