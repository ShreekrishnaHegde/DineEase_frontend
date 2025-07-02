
import 'package:dine_ease/models/Category.dart';

import '../../models/Item.dart';

class MenuService{
  final List<Category> _categories = [
    Category(
      name: "Starters",
      items: [
        Item(name: "Spring Roll", price: 120),
        Item(name: "Soup", price: 100),
      ],
    ),
    Category(
      name: "Main Course",
      items: [
        Item(name: "Paneer Butter Masala", price: 180),
        Item(name: "Naan", price: 40),
      ],
    ),
  ];

  List<Category> getCategories()=> _categories;
  void addCategory(String name){
    _categories.add(Category(name: name));
  }
  void deleteCategory(int index){
    _categories.removeAt(index);
  }
  void addItem(int categoryIndex,Item item){
    _categories[categoryIndex].items.add(item);
  }
  void deleteItem(int categoryIndex,int itemIndex){
    _categories[categoryIndex].items.removeAt(itemIndex);
  }

}