import 'package:another_flushbar/flushbar.dart';
import 'package:dine_ease/models/Item.dart';
import 'package:dine_ease/service/customer_service/customer_order_service.dart';
import 'package:dine_ease/service/notification_service.dart';
import 'package:dine_ease/views/customer_view/customer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerCartScreen extends StatefulWidget {
  final Map<Item,int> cart;
  final String username;
  const CustomerCartScreen({super.key,required this.cart,required this.username});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  late Map<Item,int> _cart;
  late String _username;
  CustomerOrderService orderService=CustomerOrderService();
  @override
  void initState() {
    super.initState();
    _cart = Map<Item, int>.from(widget.cart);
    _username = widget.username;
  }
  void _increaseQty(Item item){
    setState(() {
      _cart[item]=(_cart[item]??0)+1;
    });
  }
  void _decreaseQty(Item item){
    setState(() {
      if(_cart[item]!=null && _cart[item]!>1){
        _cart[item]=_cart[item]!-1;
      }else{
        _cart.remove(item);
      }
    });
  }
  double  get total => _cart.entries.fold(
    0,
        (sum, entry) => sum + entry.key.itemPrice * entry.value,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
            "Your Cart",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: _cart.isEmpty?
        Center(
        child: Text(
            "Your cart is empty",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54)
          ),
        )
      : ListView(
        padding: EdgeInsets.all(16),
        children: _cart.entries.map((entry){
          final item=entry.key;
          final qty=entry.value;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                  item.name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                  "Price: ₹${item.itemPrice}",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){
                      _decreaseQty(item);
                    },
                    icon: const Icon(Icons.remove_circle_outline,),
                  ),
                  Text(
                      "$qty",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    onPressed: (){
                      _increaseQty(item);
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [ BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -2),
            blurRadius: 6,
          ),]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total : $total",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _cart.isEmpty?null:
              ()async{
                try{
                  await orderService.placeOrder(hotelUsername: _username,  cart: _cart);
                  Flushbar(
                      messageText: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.white),
                          const SizedBox(width: 12),
                          const Text(
                            "Order Placed Successfully!",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),duration: const Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: BorderRadius.circular(12),
                    backgroundColor: Color(0xFF3166B8),
                    animationDuration: const Duration(milliseconds: 500),
                  ).show(context);
                  await Future.delayed(const Duration(seconds: 2));
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const CustomerDashboard()),
                    );
                  }
                }catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              label: const Text(
                "Place Order",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
