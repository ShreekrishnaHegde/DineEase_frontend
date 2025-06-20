import 'dart:ui';

import 'package:flutter/material.dart';

import 'hotel_menu.dart';

class HotelDashboard extends StatefulWidget {
  const HotelDashboard({super.key});

  @override
  State<HotelDashboard> createState() => _HotelDashboardState();
}

class _HotelDashboardState extends State<HotelDashboard> {
  final List<String> orders = [
    "Order #1001 - Pizza",
    "Order #1002 - Burger",
    "Order #1003 - Pasta",
    "Order #1004 - Salad",
    "Order #1005 - Sushi",
  ];
  bool showAll=false;
  @override
  Widget build(BuildContext context) {
    //How many orders to show?
    final List<String> displayOrders=showAll ? orders : orders.take(3).toList();
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
                "Drawer Header",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Account"),
              onTap: (){
                setState(() {

                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text("Menu"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HotelMenu()));
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: displayOrders.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Tapped on ${displayOrders[index]}"),
                    ));
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        displayOrders[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
