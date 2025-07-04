import 'dart:async';

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
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        _searchHotels(query);
      } else {
        setState(() {
          _results.clear();
        });
      }
    });
  }
  Future<void> _searchHotels(String query) async {
    try {
      final results = await _hotelProfileService.searchHotels(query);
      setState(() {
        _results = results;
      });
    } catch (e) {
      print("Search error: $e");
    }
  }
  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }
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
              const SizedBox(height: 20,),
              Expanded(
                child: _results.isEmpty
                ?const Center(child: Text("No Results Found")) :
                    ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context,index){
                        final hotel = _results[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(hotel.hotelName!),
                            subtitle: Text(hotel.address!),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CustomerViewMenu(
                                    hotelId: hotel.hotelId!,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
              )
            ],
          ),
        ),
      ),
    );
  }
}
