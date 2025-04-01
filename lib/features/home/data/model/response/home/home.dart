import 'package:equatable/equatable.dart';

import 'best_seller.dart';
import 'category.dart';
import 'occasion.dart';
import 'product.dart';

class Home extends Equatable {
  final String? message;
  final List<Product>? products;
  final List<Category>? categories;
  final List<BestSeller>? bestSeller;
  final List<Occasion>? occasions;

  const Home({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        message: json['message'] as String?,
        products: (json['products'] as List<dynamic>?)
            ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList(),
        bestSeller: (json['bestSeller'] as List<dynamic>?)
            ?.map((e) => BestSeller.fromJson(e as Map<String, dynamic>))
            .toList(),
        occasions: (json['occasions'] as List<dynamic>?)
            ?.map((e) => Occasion.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'products': products?.map((e) => e.toJson()).toList(),
        'categories': categories?.map((e) => e.toJson()).toList(),
        'bestSeller': bestSeller?.map((e) => e.toJson()).toList(),
        'occasions': occasions?.map((e) => e.toJson()).toList(),
      };

  Home copyWith({
    String? message,
    List<Product>? products,
    List<Category>? categories,
    List<BestSeller>? bestSeller,
    List<Occasion>? occasions,
  }) {
    return Home(
      message: message ?? this.message,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      bestSeller: bestSeller ?? this.bestSeller,
      occasions: occasions ?? this.occasions,
    );
  }

  @override
  List<Object?> get props {
    return [
      message,
      products,
      categories,
      bestSeller,
      occasions,
    ];
  }
}
