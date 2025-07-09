import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../service/customer_service/customer_order_service.dart';

class CustomerOrderPage extends StatefulWidget {
  const CustomerOrderPage({super.key});

  @override
  State<CustomerOrderPage> createState() => _CustomerOrderPageState();
}

class _CustomerOrderPageState extends State<CustomerOrderPage> {
  final CustomerOrderService _orderService = CustomerOrderService();
  late Future<List<Map<String, dynamic>>> _ordersFuture;
  void initState() {
    super.initState();
    _ordersFuture=_orderService.fetchCustomerOrder();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("You have not placed any orders yet."));
          }

          final orders = snapshot.data!.reversed.toList();
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order #${orders.length-index}",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                      const SizedBox(height: 6),
                      Text("Hotel: ${order['hotelName']}", style: GoogleFonts.poppins()),
                      Text("Total: ₹${order['totalAmount']}", style: GoogleFonts.poppins()),
                      Text(
                        "Items: ${order['items'].length}",
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                      const SizedBox(height: 8),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
