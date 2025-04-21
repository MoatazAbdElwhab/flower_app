import 'package:flower_app/core/common_widgets/product_card/product_card_view.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductEntity> items;
  final ScrollController? scrollController;
  const ProductGrid({super.key, required this.items , this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ProductCard(
          product: item,
        );
      },
    );
  }
}
