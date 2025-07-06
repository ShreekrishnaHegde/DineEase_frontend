import 'package:dine_ease/models/Category.dart';
import 'package:dine_ease/models/Item.dart';
import 'package:dine_ease/service/customer_service/customer_menu_service.dart';
import 'package:dine_ease/service/hotel_service/menu_service.dart';
import 'package:dine_ease/views/customer_view/customer_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late String _username;
  @override
  void initState(){
    super.initState();
    _loadMenu();
    _username=widget.username;
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        title: Text(
            item.name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
        ),
        subtitle: Text(
            '₹${item.itemPrice}',
            style: GoogleFonts.poppins(
              color: Colors.grey[700],
              fontSize: 14,
          ),
        ),
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
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Hotel Menu",
            style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: _categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                category.name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.expand_more),
              children: [
                const SizedBox(height: 8),
                ...category.items.map((item) => _buildItemTile(item)).toList(),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _cart.isNotEmpty?(){
              Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerCartScreen(cart: _cart,username: _username)));
            }:null,
            icon: const Icon(Icons.restaurant_menu),
            label: const Text(
              "View Order",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
