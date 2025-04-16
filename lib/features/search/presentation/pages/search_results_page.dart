// features/search/presentation/pages/search_results_page.dart

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:flower_app/features/search/presentation/bloc/search_event.dart';
import 'package:flower_app/features/search/presentation/bloc/search_state.dart';
import 'package:flower_app/features/search/presentation/widgets/search_bar_widget.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    return _buildLoadingSkeleton();
                  } else if (state.searchState is BaseErrorState) {
                    return _buildErrorState(state);
                  } else if (state.searchState is BaseSuccessState) {
                    if (state.searchResults != null &&
                        state.searchResults!.isNotEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          _searchBloc.add(RefreshSearchEvent(
                            _searchController.text,
                            categoryId: widget.categoryId,
                          ));

                          // Create a completer to wait for state changes
                          final completer = Completer<void>();

                          // Listen for state changes to complete the refresh
                          late final StreamSubscription subscription;
                          subscription = _searchBloc.stream.listen((state) {
                            if (state.searchState is! BaseLoadingState) {
                              completer.complete();
                              subscription.cancel();
                            }
                          });

                          // Wait for the completer
                          return completer.future;
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.all(16.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                          ),
                          itemCount: state.searchResults!.length,
                          itemBuilder: (context, index) {
                            final product = state.searchResults![index];
                            return ProductCard(
                              product: product,
                            );
                          },
                        ),
                      );
                    } else {
                      return RefreshIndicator(
                        onRefresh: () async {
                          if (_searchController.text.isNotEmpty) {
                            _searchBloc.add(RefreshSearchEvent(
                              _searchController.text,
                              categoryId: widget.categoryId,
                            ));

                            // Create a completer to wait for state changes
                            final completer = Completer<void>();

                            // Listen for state changes to complete the refresh
                            late final StreamSubscription subscription;
                            subscription = _searchBloc.stream.listen((state) {
                              if (state.searchState is! BaseLoadingState) {
                                completer.complete();
                                subscription.cancel();
                              }
                            });

                            // Wait for the completer
                            return completer.future;
                          }
                          // If search text is empty, complete immediately
                          return Future.value();
                        },
                        child: _buildEmptyState(),
                      );
                    }
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        // Even with empty query, we can refresh the page
                        // This will work as a "load all products" action
                        _searchBloc.add(RefreshSearchEvent(
                          widget.initialQuery,
                          categoryId: widget.categoryId,
                        ));

                        // Create a completer to wait for state changes
                        final completer = Completer<void>();

                        // Listen for state changes to complete the refresh
                        late final StreamSubscription subscription;
                        subscription = _searchBloc.stream.listen((state) {
                          if (state.searchState is! BaseLoadingState) {
                            completer.complete();
                            subscription.cancel();
                          }
                        });

                        return completer.future;
                      },
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

  Widget _buildLoadingSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7.r,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return ProductCard(
            product: ProductEntity(
              id: '',
              title: LocaleKeys.home_sections_best_seller.tr(),
              price: 600,
              priceAfterDiscount: 0,
              imgCover: '',
              images: const [],
              description: '',
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(SearchState state) {
    final errorMessage = (state.searchState as BaseErrorState).errorMessage;

    return Center(
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
