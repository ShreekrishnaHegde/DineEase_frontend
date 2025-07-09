import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
class HotelOrderService{
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  Future<List<dynamic>> fetchOrders(String hotelUsername) async{
    final response=await http.get(
      Uri.parse("$baseUrl/api/orders/hotel/$hotelUsername")
    );
    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else {
      throw Exception("Failed to fetch orders");
    }
  }
}