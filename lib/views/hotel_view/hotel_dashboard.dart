import 'dart:async';
import 'package:dine_ease/service/auth_service/auth_gate.dart';
import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:dine_ease/service/hotel_service/HotelProfileService.dart';
import 'package:dine_ease/service/hotel_service/hotel_order_service.dart';
import 'package:dine_ease/service/notification_service.dart';
import 'package:dine_ease/views/hotel_view/hotel_profile.dart';
import 'package:dine_ease/views/hotel_view/hotel_stats.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'hotel_menu.dart';

class HotelDashboard extends StatefulWidget {
  const HotelDashboard({super.key,required this.hotelUsername});
  final String hotelUsername;


  @override
  State<HotelDashboard> createState() => _HotelDashboardState();
}

class _HotelDashboardState extends State<HotelDashboard> {
  List<dynamic> _orders = [];
  List<dynamic> _previousOrders=[];
  final authService=AuthService();
  final hotelOrderService=HotelOrderService();
  final hotelProfileService=HotelProfileService();
  late String _hotelUsername;
  String hotelName="";
  String _fullname="";
  Timer? _timer;
  bool isLoading=true;
  @override
  void initState(){
    super.initState();
    _hotelUsername=widget.hotelUsername;
    _hotelUsername = widget.hotelUsername;
    NotificationService().initNotification();
    loadProfile();
    _loadOrders(); // initial load
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _loadOrders(); // refresh every 5 seconds
    });
  }
  Future<void> loadProfile() async {
    final profile = await hotelProfileService.fetchProfile();
    setState(() {
      hotelName = profile.hotelName!;
      _fullname=profile.fullname;
      isLoading = false;
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  Future<void> _loadOrders() async {
    try {
      final data = await hotelOrderService.fetchOrders(_hotelUsername);
      if (_previousOrders.isNotEmpty && data.length > _previousOrders.length) {
        await NotificationService().showNotification(
          title: "New Order",
          body: "You received a new customer order!",
        );
      }
      setState(() {
        _previousOrders=_orders;
        _orders = data;
      });
    }
    catch(e){
      debugPrint("Failed to fetch orders or show notification: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    //How many orders to show?
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: (){},
          )
        ],
        centerTitle: true,
        title:  Text(
          isLoading ? "Loading..." : hotelName,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      _fullname.isNotEmpty ? _fullname[0].toUpperCase() : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              )
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Profile"),
              onTap: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HotelProfile()))
                  .then((_)=>{
                    loadProfile(),
                  });
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
      body:
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : _orders.isEmpty
          ? const Center(child: Text("No orders currently"))
          : ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            color: Colors.grey.shade100,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text("Order #${index + 1}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.from(order['items']).map((item) => Text(
                      "${item['itemName']} x${item['quantity']} - ₹${item['itemPrice'] * item['quantity']}")),
                  const SizedBox(height: 6),
                  Text("Total: ₹${order['totalAmount']}"),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:  BottomAppBar(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HotelMenu()));
                  },
                  child: Text(
                    "Menu",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HotelStats()));
                  },
                  child: Text(
                    "Statistics",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
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
