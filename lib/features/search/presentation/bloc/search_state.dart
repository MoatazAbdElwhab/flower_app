// features/search/presentation/bloc/search_state.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class SearchState extends Equatable {
  final BaseState searchState;
  final List<ProductEntity>? searchResults;
  final String? query;
  final String? selectedCategoryId;
  
  static final BaseState _initialState = BaseInitialState();
  
  SearchState({
    BaseState? searchState,
    this.searchResults,
    this.query,
    this.selectedCategoryId,
  }) : searchState = searchState ?? _initialState;
  
  SearchState copyWith({
    BaseState? searchState,
    List<ProductEntity>? searchResults,
    String? query,
    String? selectedCategoryId,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchResults: searchResults ?? this.searchResults,
      query: query ?? this.query,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
  
  @override
  List<Object?> get props => [
    searchState, 
    searchResults, 
    query, 
    selectedCategoryId
  ];
}
