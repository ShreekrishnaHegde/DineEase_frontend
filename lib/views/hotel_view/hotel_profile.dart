import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.lightBlue,
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
              const SizedBox(height: 24,),

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
                controller: _hotelNameController,
                decoration:  InputDecoration(
                    labelText: "Hotel Name",
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration:  InputDecoration(
                    labelText: "Address",
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
                child: ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )
                  ),
                  child: Text(
                      "Save",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
