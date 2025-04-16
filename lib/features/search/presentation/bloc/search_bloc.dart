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
  }
  
  Future<void> _onSearchQuery(
    SearchQueryEvent event, 
    Emitter<SearchState> emit
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        searchResults: [],
        query: '',
        searchState: BaseInitialState(),
      ));
      return;
    }
    
    emit(state.copyWith(
      searchState: BaseLoadingState(),
      query: event.query,
      selectedCategoryId: event.categoryId,
    ));
    
    final result = await _searchProductsUseCase(event.query, categoryId: event.categoryId);
    
    result.fold(
      (error) => emit(state.copyWith(
        searchState: BaseErrorState(error.message),
      )),
      (products) => emit(state.copyWith(
        searchState: BaseSuccessState(data: products),
        searchResults: products,
      )),
    );
  }
  
  void _onClearSearch(
    ClearSearchEvent event, 
    Emitter<SearchState> emit
  ) {
    emit(state.copyWith(
      searchResults: [],
      query: '',
      searchState: BaseInitialState(),
    ));
  }
}
