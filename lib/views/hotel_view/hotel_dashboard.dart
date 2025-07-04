import 'dart:ui';

import 'package:dine_ease/service/auth_service/auth_gate.dart';
import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:dine_ease/views/hotel_view/hotel_profile.dart';
import 'package:dine_ease/views/hotel_view/hotel_stats.dart';
import 'package:flutter/material.dart';

import 'hotel_menu.dart';

class HotelDashboard extends StatefulWidget {
  const HotelDashboard({super.key});

  @override
  State<HotelDashboard> createState() => _HotelDashboardState();
}

class _HotelDashboardState extends State<HotelDashboard> {
  final authService=AuthService();

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
      body: Center(
        child: Text("You will see your orders here"),
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
