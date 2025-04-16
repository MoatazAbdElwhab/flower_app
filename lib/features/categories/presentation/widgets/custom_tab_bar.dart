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

class _TabWidgetStyle extends StatefulWidget {
  final String title;
  final TabController controller;
  final int tabIndex;

  const _TabWidgetStyle({
    required this.title,
    required this.controller,
    required this.tabIndex,
  });

  @override
  State<_TabWidgetStyle> createState() => _TabWidgetStyleState();
}

class _TabWidgetStyleState extends State<_TabWidgetStyle> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.controller.index == widget.tabIndex;
    widget.controller.addListener(_updateSelection);
  }

  void _updateSelection() {
    final newValue = widget.controller.index == widget.tabIndex;
    if (newValue != _isSelected) {
      setState(() => _isSelected = newValue);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSelection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: getRegularStyle(
              color: _isSelected ? AppColors.primary : AppColors.grey,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isSelected
                ? Container() // Show nothing when selected
                : Container(
                    height: 4.h,
                    width: widget.title.length * 8.w,
                    decoration: BoxDecoration(
                      color: AppColors.white[70],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.r),
                        topRight: Radius.circular(100.r),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
