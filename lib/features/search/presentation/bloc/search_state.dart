// features/search/presentation/bloc/search_state.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class SearchState extends Equatable {
  final BaseState searchState;
  final List<ProductEntity>? searchResultProducts;

  SearchState({
    BaseState? searchState,
    this.searchResultProducts,
  }) : searchState = searchState ?? BaseInitialState();

  @override
  List<Object?> get props => [searchState, searchResultProducts];

  SearchState copyWith({
    BaseState? searchState,
    List<ProductEntity>? searchResultProducts,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchResultProducts: searchResultProducts ?? this.searchResultProducts,
    );
  }
}
