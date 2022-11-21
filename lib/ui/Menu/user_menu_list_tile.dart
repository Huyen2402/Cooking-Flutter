import 'package:flutter/material.dart';
import 'package:myshop/ui/Menu/EditMenu_screen.dart';
import 'package:provider/provider.dart';
import '../../model/Menu.dart';
import 'Menu_manager.dart';

class UserProductListTile extends StatelessWidget {
  final Menu product;
  const UserProductListTile(this.product, {super.key});
  

  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditMenuScreen.routeName,
          arguments: product.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        context.read<MenuManager>().deleteMenu(product.id!);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Product deleted',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      color: Theme.of(context).errorColor,
    );
  }
}
