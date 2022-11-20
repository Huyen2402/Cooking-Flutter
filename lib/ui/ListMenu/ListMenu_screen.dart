import 'package:flutter/material.dart';
// import 'package:myshop/ui/order/order_manager.dart';
import 'package:provider/provider.dart';

import '../Menu/Menu_grid.dart';
import '../Menu/Menu_manager.dart';
import 'ListMenu_manager.dart';
import 'ListMenu_card.dart';

class ListMenuScreen extends StatefulWidget {
  static const routeName = '/cart';

  const ListMenuScreen({super.key});

  @override
  State<ListMenuScreen> createState() => _ListMenuScreenState();
  
}

class _ListMenuScreenState extends State<ListMenuScreen> {
   late Future<void> _fetchProducts;
    final _showOnlyFavorite = ValueNotifier<bool>(false);
  @override
   void initState(){
    super.initState();
    _fetchProducts = context.read<MenuManager>().fetchMenu();
  }
  Widget build(BuildContext context) {
     return  FutureBuilder(
      
        future: _fetchProducts,
        builder: ((context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return ValueListenableBuilder<bool>(valueListenable: _showOnlyFavorite, 
            builder: (context, value, child) {
              
              return MenuGrid(value);
            });
          }
          
          return const Center(
            child: CircularProgressIndicator(),
            
          );
        }),
      );
    // final cart = context.watch<ListMenuManager>();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Món ăn của bạn'),
    //   ),
    //   body: Column(
    //     children: <Widget>[
        
    //       const SizedBox(height: 10),
    //       Expanded(
    //         child: buildCartDetail(cart),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget buildCartDetail(ListMenuManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (e) => ListMenuCard(
              productId: e.key,
              cardItem: e.value,
            ),
          )
          .toList(),
    );
  }
}
