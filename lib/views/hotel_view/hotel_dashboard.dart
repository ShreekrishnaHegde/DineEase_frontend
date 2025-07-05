import 'dart:async';
import 'dart:ui';

import 'package:dine_ease/service/auth_service/auth_gate.dart';
import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:dine_ease/service/hotel_service/hotel_order_service.dart';
import 'package:dine_ease/views/hotel_view/hotel_profile.dart';
import 'package:dine_ease/views/hotel_view/hotel_stats.dart';
import 'package:flutter/material.dart';

import 'hotel_menu.dart';

class HotelDashboard extends StatefulWidget {
  const HotelDashboard({super.key,required this.hotelUsername});
  final String hotelUsername;


  @override
  State<HotelDashboard> createState() => _HotelDashboardState();
}

class _HotelDashboardState extends State<HotelDashboard> {
  List<dynamic> _orders = [];
  final authService=AuthService();
  final hotelOrderService=HotelOrderService();
  late String _hotelUsername;
  Timer? _timer;
  @override
  void initState(){
    super.initState();
    _hotelUsername=widget.hotelUsername;
    _hotelUsername = widget.hotelUsername;
    _loadOrders(); // initial load
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      _loadOrders(); // refresh every 5 seconds
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
      setState(() {
        _orders = data;
      });
    } catch (e) {
      print('Failed to load orders: $e');
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
        title: const Text(
            "Hotel Name"
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HotelProfile()));
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
      body: FutureBuilder<List<dynamic>>(
        future: hotelOrderService.fetchOrders(_hotelUsername),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No orders Currently"));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
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
                        Text("Status: ${order['status']}"),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),

      bottomNavigationBar:  BottomAppBar(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HotelMenu()));
                  },
                  child: const Text(
                    "Menu",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HotelStats()));
                  },
                  child: const Text(
                    "Statistics",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
