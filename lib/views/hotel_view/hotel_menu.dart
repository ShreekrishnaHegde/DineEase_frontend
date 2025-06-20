import 'package:flutter/material.dart';

import 'MenuItem.dart';

class HotelMenu extends StatefulWidget {
  const HotelMenu({super.key});

  @override
  State<HotelMenu> createState() => _HotelMenuState();
}

class _HotelMenuState extends State<HotelMenu> {
  final Map<String, List<MenuItem>> menu = {
    'Starters': [
      MenuItem(name: 'Spring Rolls', price: 120.0),
      MenuItem(name: 'Garlic Bread', price: 90.0),
    ],
    'Main Course': [
      MenuItem(name: 'Paneer Butter Masala', price: 240.0),
      MenuItem(name: 'Veg Biryani', price: 200.0),
    ],
    'Desserts': [
      MenuItem(name: 'Gulab Jamun', price: 80.0),
      MenuItem(name: 'Ice Cream', price: 60.0),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: ListView(
    children: menu.entries.map((entry) {
      final category = entry.key;
      final items = entry.value;
      return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0),
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
              ),
            ),
              ...items.map((item) => Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 4.0),
                child: ListTile(
                  title: Text(item.name),
                  trailing: Text('₹${item.price.toStringAsFixed(2)}'),
                ),
              )),
          ],
      );
      }).toList(),
    ),
    );
  }
}
