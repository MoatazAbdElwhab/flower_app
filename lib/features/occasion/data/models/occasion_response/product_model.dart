import 'package:flower_app/features/home/domain/entities/product_entity.dart';

class ProductModel {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<dynamic>? images;
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

  const ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        slug: json['slug'] as String?,
        description: json['description'] as String?,
        imgCover: json['imgCover'] as String?,
        images: json['images'] as List<dynamic>?,
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

  ProductEntity toEntity() => ProductEntity(
        id: id ?? '',
        title: title ?? '',
        imgCover: imgCover ?? '',
        price: price ?? 0,
        priceAfterDiscount: priceAfterDiscount ?? 0,
        images: images?.map((e) => e.toString()).toList() ?? [],
        description: description ?? '',
      );
}
