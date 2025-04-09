part of 'occasion_cubit.dart';

class OccasionState extends Equatable {
  const OccasionState({
    this.occasionsProductsState,
    this.products,
  });

  final BaseState? occasionsProductsState;
  final List<ProductEntity>? products;

  OccasionState copyWith({
    BaseState? occasionsProductsState,
    List<ProductEntity>? products,
  }) {
    return OccasionState(
      occasionsProductsState:
          occasionsProductsState ?? this.occasionsProductsState,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [occasionsProductsState, products];
}
