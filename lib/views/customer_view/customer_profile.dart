import 'package:dine_ease/service/customer_service/customer_profile_service.dart';
import 'package:flutter/material.dart';

import '../../models/CustomerProfileModel.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final CustomerProfileService _customerProfileService=CustomerProfileService();
  final _fullnameController = TextEditingController();
  String email = '';
  bool isLoading = true;
  Future<void> loadProfile() async {
    final profile = await _customerProfileService.fetchProfile();
    setState(() {
      _fullnameController.text = profile.fullname;
      email = profile.email;
      isLoading = false;
    });
  }
  Future<void> saveProfile() async {
    final updated = CustomerProfileModel(
      email: email,
      fullname: _fullnameController.text,
    );
    await _customerProfileService.updateProfile(updated);
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
                controller: _fullnameController,
                decoration: const InputDecoration(labelText: "Owner Name"),
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
