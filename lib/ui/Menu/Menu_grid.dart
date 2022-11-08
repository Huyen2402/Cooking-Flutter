import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/Menu.dart';
import 'Menu_gird_title.dart';
import 'Menu_manager.dart';

class MenuGrid extends StatelessWidget {
  final bool showFavorite;
  const MenuGrid(this.showFavorite, {super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.select<MenuManager, List<Menu>>(
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
