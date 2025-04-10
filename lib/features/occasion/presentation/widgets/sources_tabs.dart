import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/category_occasion_entity.dart';
import 'package:flower_app/features/occasion/presentation/cubit/occasion_cubit.dart';
import 'package:flower_app/features/occasion/presentation/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SourcesTabs extends StatefulWidget {
  final List<CategoryOccasionEntity> categories;
  final Function(int) onTabChanged;
  const SourcesTabs({
    super.key,
    required this.categories,
    required this.onTabChanged,
  });

  @override
  State<SourcesTabs> createState() => _SourcesTabsState();
}

class _SourcesTabsState extends State<SourcesTabs> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.read<OccasionCubit>().selectedCategoryIndex.value;
    
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          padding: EdgeInsets.zero,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.white[70],
          labelStyle:
              getRegularStyle(color: AppColors.primary, fontSize: 16.sp),
          unselectedLabelStyle:
              getRegularStyle(color: AppColors.white[70]!, fontSize: 16.sp),
          tabAlignment: TabAlignment.start,
          onTap: widget.onTabChanged,
          tabs: widget.categories.map(
            (category) {
              return TabItem(
                title: category.name ?? '',
                isSelected: widget.categories.indexOf(category) == selectedIndex,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
