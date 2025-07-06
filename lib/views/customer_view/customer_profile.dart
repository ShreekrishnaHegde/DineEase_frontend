import 'package:dine_ease/service/customer_service/customer_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_flushbar/flushbar.dart'; // Use this newer package

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
    Flushbar(
      message: "Profile Updated",
      duration: Duration(seconds: 2),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      margin: EdgeInsets.all(12),
      icon: Icon(Icons.check_circle, color: Colors.white),
    ).show(context);
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
          title: Text(
            "My Profile",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Text(
                "Update your information",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                readOnly: true,
                initialValue: email,
                decoration:  InputDecoration(
                    labelText: "Email",
                  labelStyle: GoogleFonts.poppins(),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fullnameController,
                decoration:  InputDecoration(
                    labelText: "Full Name",
                    labelStyle: GoogleFonts.poppins(),
                    filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  )
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                  ),
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
