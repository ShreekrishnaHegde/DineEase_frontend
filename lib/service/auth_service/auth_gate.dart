//This will continuously listen for the state changes

//Unauth- login page
//auth- profile page


import 'package:dine_ease/views/customer_view/customer_dashboard.dart';
import 'package:dine_ease/views/hotel_view/hotel_dashboard.dart';
import 'package:dine_ease/views/landingPage/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_service.dart';



class AuthGate extends StatelessWidget {
  AuthGate({super.key});
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<AuthState>(
      //Listen to the auth state change
      stream: Supabase.instance.client.auth.onAuthStateChange,
      //Build appropriate page based on auth change
      builder: (context,snapshot){
        final session = Supabase.instance.client.auth.currentSession;
        //Loading
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //check if there is a valid session currently

        if(session!=null){
          return session.user.userMetadata?['role']=="Customer" ? CustomerDashboard(): HotelDashboard(hotelUsername: authService.getCurrentUserEmail()!,);
        }
        else{
          return const LandingScreen();
        }
      },
    );
  }
}
