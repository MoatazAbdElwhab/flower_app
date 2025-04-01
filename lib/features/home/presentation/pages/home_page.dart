// features/home/presentation/pages/home_page.dart

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart';

import '../widget/best_seller_section.dart';
import '../widget/categories_section.dart';
import '../widget/home_header.dart';
import '../widget/location_bar.dart';
import '../widget/occasion_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.homeDataState is BaseErrorState) {
                final errorState = state.homeDataState as BaseErrorState;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorState.errorMessage),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state.homeDataState is BaseLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final homeData = state.homeData;

              if (state.homeDataState is BaseSuccessState && homeData != null) {
                return _buildHomeContent(context, homeData);
              }

              return const Center(
                child: Text('No data available. Pull to refresh.'),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, HomeEntity homeData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //---------------------------flowery logo && search
          SizedBox(height: 16.h),
          const HomeHeader(),
          SizedBox(height: 20.h),

          //---------------------------location bar
          const LocationBar(),
          SizedBox(height: 20.h),

          //---------------------------categories section
          Expanded(
            flex: 2,
            child: CategoriesSection(
              categories: homeData.categories ?? [],
            ),
          ),
          SizedBox(height: 16.h),

          //---------------------------best seller section
          Expanded(
            flex: 3,
            child: BestSellerSection(
              bestSellers: homeData.bestSeller ?? [],
            ),
          ),
          SizedBox(height: 16.h),

          //---------------------------occasion section
          Expanded(
            flex: 3,
            child: OccasionSection(
              occasions: homeData.occasions ?? [],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
