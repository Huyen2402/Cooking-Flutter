import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myshop/ui/cart/cart_manager.dart';
import 'package:myshop/ui/cart/cart_screen.dart';
import 'package:myshop/ui/products/products_manager.dart';
import 'package:myshop/ui/share/app_drawer.dart';
import 'package:provider/provider.dart';
import 'product_grid.dart';
import 'top_right_badge.dart';


enum FilterOptions {favorites , all}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreen();
}

class _ProductOverviewScreen extends State<ProductOverviewScreen> {
  final _showOnlyFavorite = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState(){
    super.initState();
    _fetchProducts = context.read<ProductManager>().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking with me'),
        actions: <Widget>[
         
          buildShoppingCartIcon(),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchProducts,
        builder: ((context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return ValueListenableBuilder<bool>(valueListenable: _showOnlyFavorite, 
            builder: (context, value, child) {
              return ProductGrid(value);
            });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Widget buildShoppingCartIcon(){
    return Consumer<CartManager>(
     builder: (context, cartManager, child)  {
      return TopRightBadge(
      data: cartManager.productCount,
      child: IconButton(icon: const Icon(Icons.check),
      onPressed: () {
        Navigator.of(context).pushNamed(CartScreen.routeName);
      },),
      
    );
     });
  }

  Widget buildProductFilterMenu(){
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue){
     if(selectedValue == FilterOptions.favorites){
      _showOnlyFavorite.value =true;
     } else{
      _showOnlyFavorite.value = false;
     }
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorite'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show all'),
        )
      ],
    );
  }
}