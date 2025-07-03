import 'package:dine_ease/models/Item.dart';

class Category{
  String name;
  List<Item> items;
  String id;
  Category({this.id="",required this.name, this.items=const []});

  factory Category.fromJson(Map<String,dynamic> json) => Category(
    id:json['categoryId'] ?? '',
    name: json['categoryName'],
    items: (json['items'] as List).map((e) => Item.fromJson(e)).toList(),
  );
  Map<String,dynamic> toJson()=> {
        "name": name,
        "items": items.map((e) => e.toJson()).toList(),
  };
}