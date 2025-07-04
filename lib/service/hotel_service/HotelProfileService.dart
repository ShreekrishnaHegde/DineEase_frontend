import 'dart:convert';

import 'package:dine_ease/models/HotelProfileModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../auth_service/auth_service.dart';

class HotelProfileService{
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  final AuthService authService = AuthService();
  late final String? username=authService.getCurrentUserEmail();
  //To fetch Profile details
  Future<HotelProfileModel> fetchProfile() async {
    final response = await http.get(Uri.parse("$baseUrl/api/hotel/$username/profile"));
    print(response.body);
    if (response.statusCode == 200) {
      return HotelProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }
  //To update Profile details
  Future<void> updateProfile(HotelProfileModel profile) async {
    final response = await http.put(
      Uri.parse("$baseUrl/api/hotel/$username/profile"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(profile.toJson()),
    );
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }
}