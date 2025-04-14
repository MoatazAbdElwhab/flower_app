// features/home/presentation/pages/home_screen.dart
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/features/home/presentation/cubit/home_cubit.dart';
import '../../../../core/base/base_state.dart';
import '../../../nav/presentation/pages/navbar_page.dart';
import '../../domain/entities/home_entity.dart';
import '../widget/best_seller_section.dart';
import '../widget/categories_section.dart';
import '../widget/home_header.dart';
import '../widget/location_bar.dart';
import '../widget/occasion_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
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
      Future.microtask(
          () async => await context.read<HomeCubit>().getHomeData());
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
                getIt<DialogUtils>().showSnackBar(
                    textColor: Colors.red,
                    message: errorState.errorMessage,
                    context: context);
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
                //final navBarState = NavbarPage.of(context);
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
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //---------------------------flowery logo && search
            SizedBox(height: 10.h),
            const HomeHeader(),
            SizedBox(height: 12.h),

            //---------------------------location bar
            const LocationBar(),
            SizedBox(height: 15.h),

            //---------------------------categories section
            CategoriesSection(
              categories: homeData.categories ?? [],
              onViewAllTap: () {
                final navBarState = NavbarPage.of(context);
                navBarState?.changeTab(1);
              },
            ),
            SizedBox(height: 15.h),

            //---------------------------best seller section
            BestSellerSection(
              bestSellers: homeData.bestSeller ?? [],
            ),
            SizedBox(height: 15.h),

            //---------------------------occasion section
            OccasionSection(
              occasions: homeData.occasions ?? [],
            ),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }
}
