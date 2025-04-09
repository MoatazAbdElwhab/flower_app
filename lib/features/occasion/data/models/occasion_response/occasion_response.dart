import 'package:flower_app/features/occasion/data/models/occasion_response/metadata.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response/product_model.dart';

class OccasionResponse {
  final String? message;
  final Metadata? metadata;
  final List<ProductModel>? products;

  const OccasionResponse({this.message, this.metadata, this.products});

  factory OccasionResponse.fromJson(Map<String, dynamic> json) {
    return OccasionResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'metadata': metadata?.toJson(),
        'products': products?.map((e) => e.toJson()).toList(),
      };
}
