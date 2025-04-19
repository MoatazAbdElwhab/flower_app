import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_styles.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabsTitles;
  final void Function(int)? changeTabIndex;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabsTitles,
    this.changeTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.label,
      splashFactory: NoSplash.splashFactory,
      indicatorPadding: EdgeInsets.zero,
      indicatorWeight: 4.h,
      labelColor: Colors.transparent,
      unselectedLabelColor: Colors.transparent,
      dividerColor: Colors.transparent,
      onTap: changeTabIndex,
      tabs: tabsTitles
          .asMap()
          .map((index, title) => MapEntry(
        index,
        _TabWidgetStyle(
          title: title,
          controller: tabController,
          tabIndex: index,
        ),
      ))
          .values
          .toList(),
    );
  }
}

class _TabWidgetStyle extends StatelessWidget { // خليناه StatelessWidget
  final String title;
  final TabController controller;
  final int tabIndex;
  final ValueNotifier<bool> _isSelectedNotifier = ValueNotifier<bool>(false); // استخدم ValueNotifier

  _TabWidgetStyle({
    required this.title,
    required this.controller,
    required this.tabIndex,
    super.key,
  }) {
    _isSelectedNotifier.value = controller.index == tabIndex;
    controller.addListener(_updateSelection);
  }

  void _updateSelection() {
    _isSelectedNotifier.value = controller.index == tabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<bool>( // استمع لتغييرات القيمة
            valueListenable: _isSelectedNotifier,
            builder: (context, isSelected, child) {
              return Text(
                title,
                style: getRegularStyle(
                  color: isSelected ? AppColors.primary : AppColors.grey,
                  fontSize: 16.sp,
                ),
              );
            },
          ),
          SizedBox(height: 8.h),
          ValueListenableBuilder<bool>( // استمع لتغييرات القيمة
            valueListenable: _isSelectedNotifier,
            builder: (context, isSelected, child) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? const SizedBox.shrink()
                    : Visibility(
                  visible: !isSelected,
                  child: Container(
                    height: 4.h,
                    width: title.length * 8.w,
                    decoration: BoxDecoration(
                      color: AppColors.white[70],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.r),
                        topRight: Radius.circular(100.r),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}