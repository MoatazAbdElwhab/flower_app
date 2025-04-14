// features/categories/presentation/widgets/custom_tab_bar.dart
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<dynamic> tabsTitles;
  final void Function(int)? changeTabIndex;
  final int selectedIndex;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabsTitles,
    required this.selectedIndex,
    this.changeTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tabController.animation!,
      builder: (context, value, _) {
        return TabBar(
          controller: tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.pink,
          overlayColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
          isScrollable: true,
          indicatorColor: Colors.pink,
          tabAlignment: TabAlignment.start,
          indicatorWeight: 1.0,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
          automaticIndicatorColorAdjustment: true,
          onTap: (index) => changeTabIndex?.call(index),
          tabs: List.generate(
            tabsTitles.length,
            (index) {
              return CustomTab(
                title: tabsTitles[index],
                isSelected: index == tabController.index,
              );
            },
          ),
        );
      },
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CustomTab({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      height: 28,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: getRegularStyle(
                color: isSelected ? AppColors.primary : AppColors.grey,
                fontSize: 14.sp),
          ),
          SizedBox(height: 3.h),
          if (!isSelected)
            Container(
              height: 1,
              width: title.length * 6.w,
              decoration: BoxDecoration(
                color: AppColors.white[70],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100.r),
                  topRight: Radius.circular(100.r),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
