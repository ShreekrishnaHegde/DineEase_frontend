
import 'package:dine_ease/models/Item.dart';

class Category{
  String name;
  List<Item> items;
  Category({
    required this.name, List<Item>? items
})
  : this.items=items ?? [];
}