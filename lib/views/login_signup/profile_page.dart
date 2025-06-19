import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:dine_ease/views/landingPage/landing_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  void logout() async{
    await authService.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed:logout ,
            icon:const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: const Text("Hello World!"),
      ),
    );
  }
}
