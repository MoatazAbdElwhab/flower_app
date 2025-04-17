// features/search/presentation/pages/search_results_page.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/common_widgets/dummy_widgets/dummy_widgets.dart';
import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:flower_app/features/search/presentation/bloc/search_event.dart';
import 'package:flower_app/features/search/presentation/bloc/search_state.dart';
import 'package:flower_app/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsPage extends StatefulWidget {
  final String initialQuery;
  final String? categoryId;
  final VoidCallback onBackPressed;

  const SearchResultsPage({
    super.key,
    required this.initialQuery,
    this.categoryId,
    required this.onBackPressed,
  });

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late final SearchBloc _searchBloc;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchBloc = getIt<SearchBloc>();
    _searchController = TextEditingController(text: widget.initialQuery);

    if (widget.initialQuery.isNotEmpty) {
      _searchBloc.add(
          SearchQueryEvent(widget.initialQuery, categoryId: widget.categoryId));
    } else {
      // Clear previous search results when returning to page with empty query
      _searchBloc.add(ClearSearchEvent());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    final currentQuery = _searchController.text;
    if (currentQuery.isNotEmpty) {
      _searchBloc.add(RefreshSearchEvent(
        currentQuery,
        categoryId: widget.categoryId,
      ));
    }
    return Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 38,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: widget.onBackPressed,
          ),
          title: Text(
            LocaleKeys.home_sections_search.tr(),
            style: getMediumStyle(color: AppColors.black, fontSize: 18.sp),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              //------------------------------------------search bar
              child: SearchBarWidget(
                controller: _searchController,
                onTextChanged: (query) {
                  _searchBloc.add(
                      SearchQueryEvent(query, categoryId: widget.categoryId));
                },
                onClear: () {
                  _searchController.clear();
                  _searchBloc.add(ClearSearchEvent());
                },
                autoFocus: widget.initialQuery.isEmpty,
              ),
            ),
            //------------------------------------------search results
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.searchState is BaseLoadingState) {
                    return AppDummyWidgets.buildProductsGridSkeleton();
                  } else if (state.searchState is BaseErrorState) {
                    return RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: _buildErrorState(state),
                    );
                  } else if (state.searchState is BaseSuccessState) {
                    if (state.searchResultProducts != null &&
                        state.searchResultProducts!.isNotEmpty) {
                      return RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: GridView.builder(
                          padding: EdgeInsets.all(16.w),
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7.r,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemCount: state.searchResultProducts!.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: state.searchResultProducts![index],
                            );
                          },
                        ),
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: _buildEmptyState(),
                      );
                    }
                  } else {
                    // Initial state
                    return RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: _buildEmptyState(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(SearchState state) {
    final errorMessage = (state.searchState as BaseErrorState).errorMessage;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 64.r,
                color: AppColors.grey,
              ),
              SizedBox(height: 16.h),
              Text(
                errorMessage,
                style: getMediumStyle(
                  color: AppColors.grey,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 64.r,
                color: AppColors.grey.withOpacity(0.7),
              ),
              SizedBox(height: 16.h),
              Text(
                LocaleKeys.home_empty_states_no_data.tr(),
                style: getMediumStyle(
                  color: AppColors.grey,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
