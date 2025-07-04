import 'package:dine_ease/models/HotelProfileModel.dart';
import 'package:dine_ease/views/customer_view/customer_view_menu.dart';
import 'package:flutter/material.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final TextEditingController _searchController = TextEditingController();
  List<HotelProfileModel> _results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Hotels"),
      ),
      body: Padding(
       padding: const EdgeInsets.all(16),
       child: Column(
         children: [
           TextField(
             controller: _searchController,
             // onChanged: _onSearchChanged,
             decoration: InputDecoration(labelText: 'Hotels'),
           ),

         ],
       ),
      ),
    );
  }
}
