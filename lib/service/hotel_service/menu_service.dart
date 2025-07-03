
import 'dart:convert';
import 'package:dine_ease/models/Category.dart';
import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/Item.dart';

class MenuService{
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  final AuthService authService = AuthService();
  late final String? username=authService.getCurrentUserEmail();

  //Method to get categories
  Future<List<Category>> getCategories() async{
    final response=await http.get(Uri.parse("$baseUrl/api/hotel/$username/menu/items"));
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) => Category.fromJson(e)).toList();
    }
    else{
      throw Exception("Failed to load categories");
    }
  }
  //Method to add a category
  Future<void> addCategory(String name) async{
    final response=await http.post(
      Uri.parse("$baseUrl/api/hotel/$username/menu/category"),
      body: jsonEncode({"categoryName":name}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to add category");
    }

  }
  //Method to delete a category
  Future<void> deleteCategory(String categoryId) async{
    final response=await http.delete(Uri.parse("$baseUrl/api/hotel/$username/menu/category/$categoryId"));
  }
  Future<void> addItems(String categoryId,List<Item> items) async{

    final itemList=items.map((e) => e.toJson()).toList();
    final response=await http.post(
      Uri.parse("$baseUrl/api/hotel/$username/menu/category/$categoryId/item"),
      body: jsonEncode(itemList),
      headers: {'Content-Type': 'application/json'},
    );
    print("hhhhhhhhhhhhhhhhhhhh");
    print(response.body);
  }
  Future<void> deleteItem(String categoryId,String itemId) async{
    await http.delete(Uri.parse("$baseUrl/item/$categoryId/$itemId"));
  }

}