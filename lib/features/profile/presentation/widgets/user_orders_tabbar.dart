import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserOrdersTabbar extends StatefulWidget {
  const UserOrdersTabbar({super.key});

  @override
  State<UserOrdersTabbar> createState() => _UserOrdersTabbarState();
}

class _UserOrdersTabbarState extends State<UserOrdersTabbar> {
  late TabController _tabController;
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  final List<String> _titles =  [LocaleKeys.myOrders_activeTab.tr(), LocaleKeys.myOrders_completedTab.tr()];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController = DefaultTabController.of(context);
    _tabController.addListener(_updateIndex);
    _currentIndex.value = _tabController.index;
  }

  void _updateIndex() {
    _currentIndex.value = _tabController.index;
  }

  @override
  void dispose() {
    _tabController.removeListener(_updateIndex);
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, currentIndex, _) {
        return TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: EdgeInsets.zero, 
          indicator: UnderlineTabIndicator(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100.r),
              topRight: Radius.circular(100.r),
            ),
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 3.w,
            ),
          ),
          labelColor: AppColors.primary,
          dividerColor: Colors.transparent,
          unselectedLabelColor: AppColors.grey,
          tabs: List.generate(_titles.length, (index) {
            return Tab(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: Text(
                      _titles[index],
                      key: ValueKey('${_titles[index]}-$currentIndex'),
                      style: getRegularStyle(
                        color: currentIndex == index
                            ? AppColors.primary
                            : AppColors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h), 
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: currentIndex == index
                        ? const SizedBox.shrink()
                        : Container(
                            key: ValueKey('underline-$index'),
                            height: 3.h,
                            
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
          }),
          onTap: (index) => _currentIndex.value = index,
        );
      },
    );
  }
}