import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductEntity> items;
  const ProductGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ProductCard(
          product: item,
          onAddToCartTap: () {},
          isInCart: false,
        );
      },
    );
  }
}
