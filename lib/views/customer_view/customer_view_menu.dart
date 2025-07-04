import 'package:flutter/material.dart';

class CustomerViewMenu extends StatefulWidget {
  final String hotelId;
  const CustomerViewMenu({super.key,required this.hotelId});

  @override
  State<CustomerViewMenu> createState() => _CustomerViewMenuState();
}

class _CustomerViewMenuState extends State<CustomerViewMenu> {
  // Future<void> _loadMenu() async {
  //   _categories = await MenuService.getMenu(widget.hotelId);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hotel Menu"),
      ),
      body: Center(
        child: Text("Hotel Id: ") ,
      ),
    );
  }
}
