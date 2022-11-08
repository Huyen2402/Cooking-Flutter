import 'package:flutter/material.dart';
// import 'package:myshop/ui/order/order_manager.dart';
import 'package:provider/provider.dart';

import 'ListMenu_manager.dart';
import 'ListMenu_card.dart';

class ListMenuScreen extends StatelessWidget {
  static const routeName = '/cart';

  const ListMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ListMenuManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Món ăn của bạn'),
      ),
      body: Column(
        children: <Widget>[
        
          const SizedBox(height: 10),
          Expanded(
            child: buildCartDetail(cart),
          )
        ],
      ),
    );
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
