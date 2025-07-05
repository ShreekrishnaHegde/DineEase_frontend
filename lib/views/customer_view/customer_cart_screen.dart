import 'package:dine_ease/models/Item.dart';
import 'package:dine_ease/service/customer_service/customer_order_service.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: _cart.isEmpty?
      const Center(child: Text("Your cart is empty"),)
      : ListView(
        padding: EdgeInsets.all(16),
        children: _cart.entries.map((entry){
          final item=entry.key;
          final qty=entry.value;
          return ListTile(
            title: Text(item.name),
            subtitle: Text("Price: ₹${item.itemPrice}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: (){
                    _decreaseQty(item);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text("$qty"),
                IconButton(
                  onPressed: (){
                    _increaseQty(item);
                  },
                  icon: const Icon(Icons.add_circle_outline),
                )
              ],
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total : $total",
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            ElevatedButton(
              onPressed: _cart.isEmpty?null:
              ()async{
                try{
                  await orderService.placeOrder(hotelUsername: _username,  cart: _cart);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Order Placed")),
                  );
                }catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              },
              child: const Text("Place Order"),
            )
          ],
        ),
      ),
    );
  }
}
