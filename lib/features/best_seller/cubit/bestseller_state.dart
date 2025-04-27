// features/best_seller/cubit/bestseller_state.dart
part of 'bestseller_cubit.dart';

abstract class BestsellerState extends Equatable {
  const BestsellerState();

  @override
  List<Object> get props => [];
}

class BestsellerInitial extends BestsellerState {}