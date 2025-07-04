import 'package:flutter/material.dart';

class HotelStats extends StatefulWidget {
  const HotelStats({super.key});

  @override
  State<HotelStats> createState() => _HotelStatsState();
}

class _HotelStatsState extends State<HotelStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sale Stats",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
    );
  }
}
