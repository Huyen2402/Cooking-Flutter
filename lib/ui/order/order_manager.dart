import 'package:flutter/cupertino.dart';

import '../../model/cart_item.dart';
import '../../model/order_item.dart';

class OderManager with ChangeNotifier{
  final List<OrderItem> _orders = [
    OrderItem(
      id: 'o1',
      amount: 59.98,
       products: [
        CartItem(id: 'c1', title: 'Ốc hương xào bơ tỏi', quantity: 1, price: 2.99, imageUrl: 'https://cdn.tgdd.vn/Files/2021/08/25/1377750/cach-lam-oc-huong-xao-bo-toi-thom-ngon-don-gian-tai-nha-202108251415105438.jpg')
       ]
       ,
       dateTime: DateTime.now()
       )

  ];
  int get orderCount{
    return _orders.length;
  }

  List<OrderItem> get orders{
    return _orders;
  }

  void addOrders(List<CartItem> cartProduct, double total) async{
    _orders.insert(0, OrderItem(id:  'o${DateTime.now().toIso8601String()}',amount: total, products: cartProduct, dateTime: DateTime.now(),
    ),
    );
    notifyListeners();
  }
}