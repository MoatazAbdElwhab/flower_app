// features/home/domain/entities/occasion_entity.dart

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/data/model/response/home/occasion.dart';

class OccasionEntity extends Equatable {
  final String? id;
  final String? name;
  final String? image;

  const OccasionEntity({
    this.id,
    this.name,
    this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];

  static OccasionEntity mapOccasionToEntity(Occasion model) {
    return OccasionEntity(
      id: model.id,
      name: model.name,
      image: model.image,
    );
  }
}
