import 'package:flutter/material.dart';
import 'package:myshop/ui/screens.dart';
import 'package:myshop/ui/share/app_drawer.dart';
import 'package:provider/provider.dart';
import 'user_menu_list_tile.dart';


class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';
  const UserProductScreen({super.key});

  Future<void> _refreshProduct (BuildContext context) async{
    await context.read<MenuManager>().fetchProduct(true);
  }

  @override
  Widget build(BuildContext context) {
    final productManager = MenuManager();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa món ăn'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(child: buildUserProductListView(productManager), onRefresh: () => _refreshProduct(context));
        })
    );
  }

  Widget buildUserProductListView(MenuManager productManager) {
    return Consumer<MenuManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemcount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
}
