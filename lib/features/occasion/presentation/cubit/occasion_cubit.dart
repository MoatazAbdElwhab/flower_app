import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/occasion/domain/usecases/get_occasions_by_id_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'occasion_state.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetOccasionsByIdUseCase _getOccasionsByIdUseCase;
  OccasionCubit(this._getOccasionsByIdUseCase) : super(const OccasionState());

  final ValueNotifier<int> selectedCategoryIndex = ValueNotifier(0);

  Future<void> getOccasionsProducts(String id) async {
    emit(state.copyWith(occasionsProductsState: BaseLoadingState()));
    final result = await _getOccasionsByIdUseCase(id);
    result.fold(
      (exception) => emit(
        state.copyWith(
          occasionsProductsState: BaseErrorState(exception.toString()),
        ),
      ),
      (products) => emit(
        state.copyWith(
          occasionsProductsState: BaseSuccessState(data: products),
        ),
      ),
    );
  }

  void switchTab({required int index, required String categoryOccasionId}) {
    selectedCategoryIndex.value = index;
    getOccasionsProducts(categoryOccasionId);
  }
}
