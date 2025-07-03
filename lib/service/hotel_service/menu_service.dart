
import 'dart:convert';
import 'package:dine_ease/models/Category.dart';
import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:http/http.dart' as http;
import '../../models/Item.dart';

class MenuService{
  final String baseUrl = "API_BASE_URL/api/hotel";
  final AuthService authService = AuthService();
  late final String? username;

  Future<List<Category>> getCategories() async{
    username = authService.getCurrentUserEmail();
    final response=await http.get(Uri.parse("$baseUrl/$username/menu/items"));
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) => Category.fromJson(e)).toList();
    }
    else{
      throw Exception("Failed to load categories");
    }
  }
  Future<void> addCategory(String name) async{
    username = authService.getCurrentUserEmail();
    await http.post(
      Uri.parse("$baseUrl/category"),
      body: jsonEncode({"name":name}),
      headers: {'Content-Type': 'application/json'},
    );
  }
  Future<void> deleteCategory(String categoryId) async{
    username = authService.getCurrentUserEmail();
    await http.delete(Uri.parse("$baseUrl/category/$categoryId"));
  }
  Future<void> addItem(String categoryId,List<Item> items) async{
    username = authService.getCurrentUserEmail();
    final itemList=items.map((e) => e.toJson()).toList();
    await http.post(
      Uri.parse("$baseUrl/item/$categoryId"),
      body: jsonEncode(itemList),
      headers: {'Content-Type': 'application/json'},
    );
  }
  Future<void> deleteItem(String categoryId,String itemId) async{
    username = authService.getCurrentUserEmail();
    await http.delete(Uri.parse("$baseUrl/item/$categoryId/$itemId"));
  }

}