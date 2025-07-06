import 'dart:async';

import 'package:dine_ease/models/HotelProfileModel.dart';
import 'package:dine_ease/service/customer_service/customer_profile_service.dart';
import 'package:dine_ease/service/hotel_service/HotelProfileService.dart';
import 'package:dine_ease/views/customer_view/customer_profile.dart';
import 'package:dine_ease/views/customer_view/customer_view_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service/auth_service/auth_gate.dart';
import '../../service/auth_service/auth_service.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final TextEditingController _searchController = TextEditingController();
  final HotelProfileService _hotelProfileService=HotelProfileService();
  final CustomerProfileService _customerProfileService=CustomerProfileService();
  List<HotelProfileModel> _results=[];
  Timer? _debounce;
  final authService=AuthService();
  String _fullname="";
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadProfile();
    _searchController.addListener(_onSearchChanged);
  }
  Future<void> loadProfile() async {
    final profile = await _customerProfileService.fetchProfile();
    setState(() {
      _fullname = profile.fullname;
      isLoading = false;
    });
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            "DineEase",
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.w700,

              letterSpacing: 0.8,
              height: 1.4,
            ),
          ),
        backgroundColor: Colors.deepOrangeAccent,

        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepOrangeAccent),
              child: Text(
                "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Profile"),
              onTap: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerProfile()));
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: (){
                authService.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => AuthGate()));
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isLoading ? "Loading..." : "Hello, $_fullname 👋",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for hotels...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _results.clear();
                      });
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Expanded(
                child: _results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/customer/nodata.png"
                        ),
                        SizedBox(height: 16,),
                        Text(
                          "No matching hotels found",
                          style: GoogleFonts.poppins(fontSize: 16,color: Colors.black54),
                        )
                      ],
                    )
                ) :
                    ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context,index){
                        final hotel = _results[index];
                        return  Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 1.5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(12),
                              leading: CircleAvatar(
                                backgroundColor: Colors.deepOrange.shade100,
                                child: const Icon(Icons.store, color: Colors.deepOrange),
                              ),
                              title: Text(
                                hotel.hotelName!,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                hotel.address!,
                                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CustomerViewMenu(username: hotel.email),
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
