import 'package:dine_ease/models/Category.dart';
import 'package:dine_ease/models/Item.dart';
import 'package:dine_ease/service/customer_service/customer_menu_service.dart';
import 'package:dine_ease/service/hotel_service/menu_service.dart';
import 'package:dine_ease/views/customer_view/customer_cart_screen.dart';
import 'package:flutter/material.dart';

class CustomerViewMenu extends StatefulWidget {
  final String username;
  const CustomerViewMenu({super.key,required this.username});

  @override
  State<CustomerViewMenu> createState() => _CustomerViewMenuState();
}

class _CustomerViewMenuState extends State<CustomerViewMenu> {
  final CustomerMenuService _customerMenuService=CustomerMenuService();
  List<Category> _categories = [];
  Map<Item,int> _cart = {};

  @override
  void initState(){
    super.initState();
    _loadMenu();
  }
  Future<void> _loadMenu() async{
    try {
      final menu = await _customerMenuService.getCategories(widget.username);
      setState(() {
        _categories = menu;
      });
    } catch (e) {
      print("Error loading menu: $e");
      // Optional: show SnackBar or error message
    }
  }
  void _addToCart(Item item) {
    setState(() {
      _cart[item] = (_cart[item] ?? 0) + 1;
    });
  }

  void _removeFromCart(Item item) {
    setState(() {
      if (_cart.containsKey(item) && _cart[item]! > 0) {
        _cart[item] = _cart[item]! - 1;
        if (_cart[item] == 0) _cart.remove(item);
      }
    });
  }
  Widget _buildItemTile(Item item) {
    int quantity = _cart[item] ?? 0;
    return ListTile(
      title: Text(item.name),
      subtitle: Text('₹${item.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _removeFromCart(item),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text('$quantity', style: const TextStyle(fontSize: 16)),
          IconButton(
            onPressed: () => _addToCart(item),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Menu"),
      ),
      body: _categories.isEmpty
      ? const Center(child: CircularProgressIndicator(),)
          :ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for(var category in _categories) ...[
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 20,fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 8,),
            for(var item in category.items) _buildItemTile(item),
            const Divider(),
      ],
          const SizedBox(height: 80,),
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
          ),
          onPressed: _cart.isNotEmpty?(){
            Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerCartScreen(cart: _cart)));
          }:null,
          child: const Text("View Order"),
        ),
      ),
    );
  }
}
