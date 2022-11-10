import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../model/Menu.dart';
import '../../model/auth_token.dart';
import '../../services/MenuService.dart';

class MenuManager with ChangeNotifier{
    List<Menu> _items = [];
  final ProductService _productService;

  MenuManager([AuthToken? authToken]) : _productService = ProductService(authToken);

  set authToken(AuthToken? authToken){
    _productService.authToken = authToken;
  }

  Future<void> fetchMenu([bool filterByUer = false]) async{
    _items = await _productService.fetchMenu(filterByUer);
    notifyListeners();
  }

   Future<void> addProduct(Menu product) async{
    final newProduct = await _productService.addMenu(product);
    if(newProduct != null){
      _items.add(newProduct);
       notifyListeners();
    }
   
  }
  Future<void> updateMenu(Menu menu) async{
    final index= _items.indexWhere((item) => item.id == menu.id);
   if(index != null){
       print(index);
   
      if(await _productService.updateMenu(menu)){
      _items[index].description = menu.description;
      _items[index].title = menu.title;
      print(menu.title);


      notifyListeners();
      }
       
      
     
    }
  }



  int get itemcount {
    return _items.length;
  }

  List<Menu> get items {
    return _items;
  }

  List<Menu> get favoriteItems{
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Menu findById(String id){
    return _items.firstWhere((element) => element.id == id);
  }

  // void addProduct(Product product){
  //   _items.add(
  //     product.copyWith(
  //       id: 'p${DateTime.now().toIso8601String()}',
  //     ),
  //   );
  //   notifyListeners();
  // }
  
  Future<void> toggleFavoriteStatus(Menu product) async{
    final saveStatus = product.isFavorite;
    product.isFavorite = !saveStatus;
    if(!await _productService.saveFavoriteStatus(product)){
      product.isFavorite = saveStatus;
    }
  }

 Future<void>  deleteMenu(String id) async{
 final index= _items.indexWhere((item) => item.id == id);
 Menu? existingProduct = _items[index];
 _items.removeAt(index);
 notifyListeners();
 if(!await _productService.deleteProduct(id)){
  _items.insert(index, existingProduct);
  notifyListeners();
 }
  }
}