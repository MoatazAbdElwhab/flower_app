// features/search/presentation/bloc/search_bloc.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/features/search/domain/usecases/search_products_use_case.dart';
import 'package:flower_app/features/search/presentation/bloc/search_state.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'search_event.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;

  SearchBloc(this._searchProductsUseCase) : super(SearchState()) {
    on<SearchQueryEvent>(_onSearchQuery,
        transformer: (events, mapper) => events
            .debounceTime(const Duration(milliseconds: 300))
            .switchMap(mapper));
    on<ClearSearchEvent>(_onClearSearch);
    on<RefreshSearchEvent>(_onRefreshSearch);
  }

  Future<void> _onSearchQuery(
      SearchQueryEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      searchState: BaseLoadingState(),
    ));

    try {
      final products = await _searchProductsUseCase(event.query,
          categoryId: event.categoryId);

      emit(state.copyWith(
        searchState: BaseSuccessState(data: products),
        searchResultProducts: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        searchState: BaseErrorState(e.toString()),
      ));
    }
  }

  void _onClearSearch(ClearSearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      searchResultProducts: [],
      searchState: BaseInitialState(),
    ));
  }

  Future<void> _onRefreshSearch(
      RefreshSearchEvent event, Emitter<SearchState> emit) async {
    // Convert RefreshSearchEvent to SearchQueryEvent to reuse logic
    final searchEvent = SearchQueryEvent(
      event.query,
      categoryId: event.categoryId,
    );

    await _onSearchQuery(searchEvent, emit);
  }
}
