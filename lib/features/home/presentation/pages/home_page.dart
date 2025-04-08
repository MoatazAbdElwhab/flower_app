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
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      _isFirstLoad = false;
      Future.microtask(() => context.read<HomeCubit>().getHomeData());
    }
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

              final HomeCubit cubit = context.read<HomeCubit>();
              final homeData = cubit.homeData;

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
    final size = MediaQuery.of(context).size;

    final topSpacing = size.height * 0.01;
    final headerSpacing = size.height * 0.02;
    final locationSpacing = size.height * 0.015;
    final sectionSpacing = size.height * 0.012;
    final bottomSpacing = size.height * 0.008;
    final horizontalPadding = size.width * 0.04;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //---------------------------flowery logo && search
          SizedBox(height: topSpacing),
          const HomeHeader(),
          SizedBox(height: headerSpacing),

          //---------------------------location bar
          const LocationBar(),
          SizedBox(height: locationSpacing),

          //---------------------------categories section
          Flexible(
            flex: 2,
            child: CategoriesSection(
              categories: homeData.categories ?? [],
            ),
          ),
          SizedBox(height: sectionSpacing),

          //---------------------------best seller section
          Flexible(
            flex: 3,
            child: BestSellerSection(
              bestSellers: homeData.bestSeller ?? [],
            ),
          ),
          SizedBox(height: sectionSpacing),

          //---------------------------occasion section
          Flexible(
            flex: 3,
            child: OccasionSection(
              occasions: homeData.occasions ?? [],
            ),
          ),
          SizedBox(height: bottomSpacing),
        ],
      ),
    );
  }
}
