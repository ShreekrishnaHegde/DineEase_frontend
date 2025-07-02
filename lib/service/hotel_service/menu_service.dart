
import 'dart:convert';
import 'dart:ui';

import 'package:dine_ease/models/Category.dart';
import 'package:http/http.dart' as http;
import '../../models/Item.dart';

class MenuService{
  final String baseUrl="";


  Future<List<Category>> getCategories() async{
    final response=await http.get(Uri.parse("$baseUrl/categories"));
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) => Category.from)
    }
    else{
      throw Exception("Failed to load categories");
    }
  }
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