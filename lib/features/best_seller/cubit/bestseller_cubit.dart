// features/best_seller/cubit/bestseller_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bestseller_state.dart';

class BestsellerCubit extends Cubit<BestsellerState> {
  BestsellerCubit() : super(BestsellerInitial());
}