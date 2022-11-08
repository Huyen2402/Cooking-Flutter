import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';
import 'package:provider/provider.dart';
import '../../model/Menu.dart';
import 'Menu_Detail_Screen.dart';

class ProductGirdTitle extends StatelessWidget {
  const ProductGirdTitle(this.product, {super.key});
  final Menu product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: buildGirdFooterBar(context),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildGirdFooterBar(BuildContext context) {
    return GridTileBar(
      backgroundColor: Color.fromARGB(221, 149, 199, 202),
      // leading: ValueListenableBuilder<bool>(
      //   valueListenable: product.isFavoriteListenable,
      //   builder: (ctx, isFavorite, child) {
      //     return IconButton(
      //       icon: Icon(
      //         isFavorite ? Icons.favorite : Icons.favorite_border,
      //       ),
      //       color: Theme.of(context).colorScheme.secondary,
      //       onPressed: () {
      //       ctx.read<ProductManager>().toggleFavoriteStatus(product);
      //       },
      //     );
      //   },
      // ),
      title: Text(
        product.title,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.add,
        ),
        onPressed: () {
          final cart = context.read<ListMenuManager>();
          cart.addItem(product);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: const Text(
                  'Thêm món ăn vào thực đơn hôm nay',
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id!);
                  },
                ),
              ),
            );
        },
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
