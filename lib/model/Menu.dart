

import 'package:flutter/foundation.dart';

class Menu{
   String? id;
   String title;
   String description;
 
   String imageUrl;
  final ValueNotifier<bool> _isFavorite;

  Menu({
    this.id,
    required this.title,
    required this.description,
   
    required this.imageUrl,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);
  set isFavorite(bool newValue){
    _isFavorite.value = newValue;
  }

  bool get isFavorite{
return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable{
    return _isFavorite;
  }

  Menu copyWith({
     String? id,
   String? title,
   String? description,
 
   String? imageUrl,
   bool? isFavorite,
  }){
    return Menu(
      id: id ?? this.id,
      title: title ?? this.title, 
      description: description ?? this.description, 
      
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite
      );
  }

  Map<String, dynamic> toJson(){
    return{
      'title':title,
      'description': description,
  
      'imageUrl':imageUrl,
    };
  }

  static Menu fromJson(Map<String, dynamic> json){
    return Menu(id: json['id'], description: json['description'], imageUrl: json['imageUrl'], title: json['title']);
  }

}