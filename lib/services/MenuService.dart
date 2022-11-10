import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../model/Menu.dart';
import '../model/auth_token.dart';
import 'services_firebase.dart';
import 'dart:developer';

class ProductService extends FirebaseService {
  ProductService([AuthToken? authToken]) : super(authToken);

  Future<List<Menu>> fetchMenu([bool filterByUer = false]) async {
    final List<Menu> products = [];
    try {
      final filter =
          filterByUer ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      print(filter);
      final productUrl =
          Uri.parse('$databaseUrl/menu.json?auth=$token&$filter');
      final response = await http.get(productUrl);
      final productsMap = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        print(productsMap['error']);
        return products;
      }
      final userFavoriteURL =
          Uri.parse('$databaseUrl/userFavorite/$userId.json?auth=$token');
      final userFavoriteResponde = await http.get(userFavoriteURL);
      final userFavoriteMap = jsonDecode(userFavoriteResponde.body);
      productsMap.forEach((productId, product) {
        final isFavorite = (userFavoriteMap == null)
            ? false
            : (userFavoriteMap[productId] ?? false);
        products.add(Menu.fromJson({
          'id': productId,
          ...product,
        }).copyWith(isFavorite: isFavorite));
      });
      return products;
    } catch (error) {
      print(error);
      return products;
    }
  }

  Future<Menu?> addMenu(Menu product) async {
    try {
      final url = Uri.parse('$databaseUrl/menu.json?auth$token');
      final responde = await http.post(url,
          body: json.encode(product.toJson()
            ..addAll({
              'creatorId': userId,
            })));
      if (responde.statusCode != 200) {
        throw Exception(json.decode(responde.body)['error']);
      }
      return product.copyWith(
        id: json.decode(responde.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  
  Future<bool> updateMenu(Menu product) async{
    
    try{
      
      final url =
      Uri.parse('$databaseUrl/menu/${product.id}.json?auth=$token');
     
      final response = await http.put(
        url,
        body: json.encode(product.toJson() 
        ..addAll({
              'creatorId': userId,
            }))
      );
      print(product.title);
 
      if(response.statusCode != 200){
      
        throw Exception(json.decode(response.body)['error']);
      }
      
      return true;
      
    }catch(error){
      print(error);
      return false;
    }
  }

  Future<bool> deleteProduct (String id) async{
    try{
       final url =
      Uri.parse('$databaseUrl/menu/$id.json?auth=$token');
      final response = await http.delete(url);
      if(response.statusCode != 200){
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
   }catch(error){
      print(error);
      return false;
    }
  }
Future<bool> saveFavoriteStatus (Menu product) async{
  try{
     final url =
      Uri.parse('$databaseUrl/menu/${product.id}.json?auth=$token');
final response = 
await http.put(url, 
body: json.encode(product.isFavorite,));
if(response.statusCode != 200){
  throw Exception(json.decode(response.body)['error']);
}
return true;
   }catch(error){
      print(error);
      return false;
    }
}

}
