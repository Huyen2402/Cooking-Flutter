import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/product.dart';
import 'product_gird_title.dart';
import 'products_manager.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavorite;
  const ProductGrid(this.showFavorite, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductManager, List<Product>>(
        (productManager) =>
            showFavorite ? productManager.favoriteItems : productManager.items);

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGirdTitle(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
