// features/home/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/best_seller_section.dart';
import '../widget/categories_section.dart';
import '../widget/home_header.dart';
import '../widget/location_bar.dart';
import '../widget/occasion_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //---------------------------flowery logo && search
                const HomeHeader(),
                SizedBox(height: 12.h),

                //---------------------------location bar
                const LocationBar(),
                SizedBox(height: 12.h),

                //---------------------------categories section
                const Expanded(
                  flex: 2,
                  child: CategoriesSection(),
                ),
                SizedBox(height: 12.h),

                //---------------------------best seller section
                const Expanded(
                  flex: 3,
                  child: BestSellerSection(),
                ),
                SizedBox(height: 12.h),

                //---------------------------occasion section
                const Expanded(
                  flex: 3,
                  child: OccasionSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
