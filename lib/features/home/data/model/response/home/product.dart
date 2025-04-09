// features/home/data/model/response/home/product.dart
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? discount;
  final int? sold;
  final double? rateAvg;
  final int? rateCount;

  const Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.discount,
    this.sold,
    this.rateAvg,
    this.rateCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        description: json['description'] as String?,
        imgCover: json['imgCover'] as String?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        price: json['price'] as int?,
        priceAfterDiscount: json['priceAfterDiscount'] as int?,
        quantity: json['quantity'] as int?,
        category: json['category'] as String?,
        occasion: json['occasion'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        discount: json['discount'] as int?,
        sold: json['sold'] as int?,
        rateAvg: (json['rateAvg'] as num?)?.toDouble(),
        rateCount: json['rateCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'description': description,
        'imgCover': imgCover,
        'images': images,
        'price': price,
        'priceAfterDiscount': priceAfterDiscount,
        'quantity': quantity,
        'category': category,
        'occasion': occasion,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'discount': discount,
        'sold': sold,
        'rateAvg': rateAvg,
        'rateCount': rateCount,
      };

  Product copyWith({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? imgCover,
    List<String>? images,
    int? price,
    int? priceAfterDiscount,
    int? quantity,
    String? category,
    String? occasion,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    int? discount,
    int? sold,
    double? rateAvg,
    int? rateCount,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      imgCover: imgCover ?? this.imgCover,
      images: images ?? this.images,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      occasion: occasion ?? this.occasion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      discount: discount ?? this.discount,
      sold: sold ?? this.sold,
      rateAvg: rateAvg ?? this.rateAvg,
      rateCount: rateCount ?? this.rateCount,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      slug,
      description,
      imgCover,
      images,
      price,
      priceAfterDiscount,
      quantity,
      category,
      occasion,
      createdAt,
      updatedAt,
      v,
      discount,
      sold,
      rateAvg,
      rateCount,
    ];
  }
}
