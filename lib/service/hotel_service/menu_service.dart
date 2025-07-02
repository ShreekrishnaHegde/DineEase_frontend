
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
      return data.map((e) => Category.fromJson(e)).toList();
    }
    else{
      throw Exception("Failed to load categories");
    }
  }
  Future<void> addCategory(String name) async{
    await http.post(
      Uri.parse("$baseUrl/category"),
      body: jsonEncode({"name":name});
    );
  }
  Future<void> deleteCategory(String categoryId) async{
    await http.delete(Uri.parse("$baseUrl/category/$categoryId"));
  }
  void addItem(String categoryId,List<Item> items) async{
    final itemList=items.map((e) => e.toJson()).toList();
    await http.post(
      Uri.parse("$baseUrl/item/$categoryId"),
      body: jsonEncode(itemList),
    );
  }
  Future<void> deleteItem(String categoryId,String itemId) async{
    await http.delete(Uri.parse("$baseUrl/item/$categoryId/$itemId"));
  }

}