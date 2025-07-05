import 'dart:convert';
import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../models/Item.dart';
import '../auth_service/auth_service.dart';

class CustomerOrderService{
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  final AuthService authService = AuthService();
  late final String? customerUsername=authService.getCurrentUserEmail();
  Future<void> placeOrder({
    required String hotelUsername,
    required Map<Item,int> cart,
})async{
    final items=cart.entries.map((entry)=>{
      "itemId":entry.key.id,
      "itemName":entry.key.name,
      "itemPrice":entry.key.itemPrice,
      "quantity":entry.value,
    }).toList();
    final double total = items.fold<double>(
      0.0,
          (sum, item) => sum + (item['itemPrice'] as num).toDouble() * (item['quantity'] as num).toDouble(),
    );
    final body=jsonEncode({
      "hotelUsername": hotelUsername,
      "customerUsername": customerUsername,
      "items": items,
      "totalAmount": total,
      "status": "PENDING"
    });
    final response=await http.post(
      Uri.parse("$baseUrl/api/orders"),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if(response.statusCode!=200){
      throw Exception("Failed to Place the order: ${response.body}");
    }
  }


}