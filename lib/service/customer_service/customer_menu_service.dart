import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/Category.dart';
import '../auth_service/auth_service.dart';

class CustomerMenuService{
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  final AuthService authService = AuthService();
  Future<List<Category>> getCategories(String username) async{
    final response=await http.get(Uri.parse("$baseUrl/api/hotel/$username/menu/items"));
    if(response.statusCode==200){
      List data=jsonDecode(response.body);
      return data.map((e) => Category.fromJson(e)).toList();
    }
    else{
      throw Exception("Failed to load categories");
    }
  }

}