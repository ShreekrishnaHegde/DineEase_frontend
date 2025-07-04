import 'package:dine_ease/models/HotelProfileModel.dart';
import 'package:dine_ease/service/hotel_service/HotelProfileService.dart';
import 'package:dine_ease/views/customer_view/customer_view_menu.dart';
import 'package:flutter/material.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final TextEditingController _searchController = TextEditingController();
  final HotelProfileService _hotelProfileService=HotelProfileService();
  List<HotelProfileModel> _results=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello ",
                style: TextStyle(fontWeight: FontWeight.bold),

              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for hotels...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
