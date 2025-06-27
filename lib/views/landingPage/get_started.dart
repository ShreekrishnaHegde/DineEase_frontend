import 'package:dine_ease/views/landingPage/landing_screen.dart';
import 'package:flutter/material.dart';

import '../login_signup/login.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(

      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      minimumSize: Size(double.infinity,50),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              "assets/landing_screen/LS02.jpg",
              width: 0.8*screenWidth,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
              child: ElevatedButton(
                style: raisedButtonStyle,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LandingScreen()));
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

