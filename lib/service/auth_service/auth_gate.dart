//This will continuously listen for the state changes

//Unauth- login page
//auth- profile page

import 'package:dine_ease/views/landingPage/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../views/login_signup/profile_page.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //Listen to the auth state change
      stream: Supabase.instance.client.auth.onAuthStateChange,
      //Build appropriate page based on auth change
      builder: (context,snapshot){
        //Loading
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        //check if there is a valid session currently
        final session=snapshot.hasData?snapshot.data!.session:null;
        if(session!=null){
          return const ProfilePage();
        }
        else{
          return const LandingScreen();
        }
      },
    );
  }
}
