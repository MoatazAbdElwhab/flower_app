// features/search/presentation/bloc/search_state.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class SearchState extends Equatable {
  final BaseState searchState;
  final List<ProductEntity>? searchResults;
  
  static final BaseState _initialState = BaseInitialState();
  
  SearchState({
    BaseState? searchState,
    this.searchResults,
  }) : searchState = searchState ?? _initialState;
  
  SearchState copyWith({
    BaseState? searchState,
    List<ProductEntity>? searchResults,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchResults: searchResults ?? this.searchResults,
    );
  }
  
  @override
  List<Object?> get props => [
    searchState, 
    searchResults
  ];
}
