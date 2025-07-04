import 'package:flutter/material.dart';

import '../../models/HotelProfileModel.dart';
import '../../service/hotel_service/HotelProfileService.dart';

class HotelProfile extends StatefulWidget {
  const HotelProfile({super.key});

  @override
  State<HotelProfile> createState() => _HotelProfileState();
}

class _HotelProfileState extends State<HotelProfile> {
  final HotelProfileService _service = HotelProfileService();

  final _hotelNameController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _addressController = TextEditingController();
  String email = '';
  bool isLoading = true;
  Future<void> loadProfile() async {
    final profile = await _service.fetchProfile();
    setState(() {
      _hotelNameController.text = profile.hotelName??'';
      _fullnameController.text = profile.fullname;
      _addressController.text = profile.address??'';
      email = profile.email;
      isLoading = false;
    });
  }
  Future<void> saveProfile() async {
    final updated = HotelProfileModel(
      email: email,
      hotelName: _hotelNameController.text,
      fullname: _fullnameController.text,
      address: _addressController.text,
    );
    await _service.updateProfile(updated);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile Updated')));
  }
  @override
  void initState(){
    super.initState();
    loadProfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                initialValue: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hotelNameController,
                decoration: const InputDecoration(labelText: "Hotel Name"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fullnameController,
                decoration: const InputDecoration(labelText: "Owner Name"),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveProfile,
                  child: const Text("Save"),
                ),
              )
            ],
          ),
      )
    );
  }
}
