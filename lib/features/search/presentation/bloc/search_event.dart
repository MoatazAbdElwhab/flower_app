import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends SearchEvent {
  final String query;
  final String? categoryId;

  const SearchQueryEvent(this.query, {this.categoryId});

  @override
  List<Object?> get props => [query, categoryId];
}

class ClearSearchEvent extends SearchEvent {}

class RefreshSearchEvent extends SearchEvent {
  final String query;
  final String? categoryId;

  const RefreshSearchEvent(this.query, {this.categoryId});

  @override
  List<Object?> get props => [query, categoryId];
}
