import 'package:flutter/cupertino.dart';
import 'package:myshop/model/product.dart';

import '../../model/cart_item.dart';

class CartManager with ChangeNotifier{
  final Map<String, CartItem> _items = {
   
  };

  int get productCount{
    return _items.length;
  }

  List<CartItem> get product {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, CartItem>> get productEntries{
    return _items.entries;
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, CartItem) { 
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void addItem(Product product){
    if(_items.containsKey(product.id)){
      _items.update(
        product.id!,
        (existingCartItem) => existingCartItem.copyWith(
          quantity: existingCartItem.quantity +1,
        ) ,
      );
    }
    else{
      _items.putIfAbsent(
       product.id! , 
        () => CartItem(id: 'c${DateTime.now().toIso8601String()}', title: product.title, quantity: 1, price: product.price, imageUrl: product.imageUrl));
    }
    notifyListeners();
  }
void removeItem(String productId){
_items.remove(productId);
notifyListeners();
}

void removeSingleItem(String productId){
  if(!_items.containsKey(productId)){
    return;
  }
  if(_items[productId]?.quantity as num > 1){
    _items.update(productId, (existingCartItem) => existingCartItem.copyWith(
      quantity: existingCartItem.quantity-1,
    ),
    );
  }
}

}