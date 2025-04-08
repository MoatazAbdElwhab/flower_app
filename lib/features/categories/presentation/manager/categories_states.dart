// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flower_app/core/base/base_state.dart';

class CategoriesStates extends Equatable {
  final BaseState? categoryState;
  const CategoriesStates({
    this.categoryState,
  });
  
  @override
  List<Object> get props => [categoryState?? []];

  CategoriesStates copyWith({
    BaseState? categoryState,
  }) {
    return CategoriesStates(
      categoryState: categoryState ?? this.categoryState,
    );
  }
}
