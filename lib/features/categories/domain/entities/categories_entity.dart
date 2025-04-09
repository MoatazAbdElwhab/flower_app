import '../../../home/data/model/response/home/category.dart';

class CategoriesEntity {
  final String id;
  final String name;
  final String image;
  final String slug;

  CategoriesEntity(
      {required this.id,
      required this.name,
      required this.image,
      required this.slug});

  CategoriesEntity.fromCategory(Category category)
      : id = category.id ?? '',
        name = category.name ?? '',
        image = category.image ?? '',
        slug = category.slug ?? '';

  factory CategoriesEntity.fromMap(Map<String, dynamic> map) {
    return CategoriesEntity(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        slug: map['slug']);
  }
}
