import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService = AuthService();
  String? email;
  void logout() async{
    await authService.signOut();
  }
  @override
  void initState() {
    super.initState();
    email = authService.getCurrentUserEmail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed:logout ,
            icon:const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text("$email"),
      ),
    );
  }
}
