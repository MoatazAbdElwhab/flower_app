// core/common_widgets/dummy_widgets/dummy_widgets.dart
import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../features/cart/presentation/widgets/cart_product/cart_product.dart';
import '../../../features/checkout/presentation/widgets/delivery_option_item.dart';
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
  get dummyGetProfileAddresses => [
        DeliveryOptionItem(
          type: 'type',
          address: 'address',
          isSelected: true,
          onTap: () {},
          onEdit: () {},
        )
      ];

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

  get homeScreenContent => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  Skeletonizer(
                    child: Row(
                      children: [
                        Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.pink[100],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 70.w,
                          height: 20.h,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Skeletonizer(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              // Location
              Skeletonizer(
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    SizedBox(width: 5.w),
                    Container(
                      width: 130.w,
                      height: 16.h,
                      color: Colors.grey,
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              // Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skeletonizer(
                    child: Container(
                      width: 60.w,
                      height: 20.h,
                      color: Colors.grey,
                    ),
                  ),
                  Skeletonizer(
                    child: Container(
                      width: 50.w,
                      height: 15.h,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              // Categories items
              SizedBox(
                height: 80.h,
                child: Skeletonizer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) => Column(
                        children: [
                          Container(
                            width: (280 / 5).w,
                            height: (280 / 5).w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE6EF),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            width: 16.w,
                            height: 12.h,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25.h),

              // Best seller
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skeletonizer(
                    child: Container(
                      width: 70.w,
                      height: 20.h,
                      color: Colors.grey,
                    ),
                  ),
                  Skeletonizer(
                    child: Container(
                      width: 40.w,
                      height: 15.h,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),

              // Best seller items
              SizedBox(
                height: 170.h,
                child: Skeletonizer(
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: index < 2 ? 10.w : 0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25.h),

              // Occasion
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skeletonizer(
                    child: Container(
                      width: 60.w,
                      height: 20.h,
                      color: Colors.grey,
                    ),
                  ),
                  Skeletonizer(
                    child: Container(
                      width: 40.w,
                      height: 15.h,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Occasion items
              SizedBox(
                height: 160.h,
                child: Skeletonizer(
                  child: Row(
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: index < 2 ? 10.w : 0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      );
}
