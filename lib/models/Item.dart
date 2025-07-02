import 'package:dine_ease/views/hotel_view/MenuItem.dart';

class Item{
  String name;
  double price;
  String id;
  Item({this.id="",required this.name,required this.price});

  factory Item.fromJson(Map<String,dynamic> json) => Item(
    id: json['_id'] ?? '',
    name: json['name'],
    price: (json['price'] as num).toDouble(),
  );
  Map<String,dynamic> toJson()=>{
    "name":name,
    "price":price,
  };
}