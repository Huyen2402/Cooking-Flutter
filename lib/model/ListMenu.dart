class ListMenu {
  final String id;
  final String title;
  final int quantity;

  final String imageUrl;


  ListMenu({
  required this.id,
  required this.title,
  required this.quantity,
  
  required this.imageUrl

});

ListMenu copyWith({
  String? id,
  String? title,
  int? quantity,

  String? imageUrl
}){
  return ListMenu(
    id: id ?? this.id,
    title: title ?? this.title,
    quantity: quantity ?? this.quantity,
   
    imageUrl: imageUrl ?? this.imageUrl
  );
}
}

