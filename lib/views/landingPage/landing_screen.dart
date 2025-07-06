import 'package:dine_ease/views/login_signup/login.dart';
import 'package:dine_ease/views/login_signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepOrangeAccent,
      minimumSize: Size(double.infinity,50),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //Image
              Image.asset(
                "assets/landing_screen/LS02.jpg",
                width: 0.70*screenWidth,
              ),
              Text(
                "Welcome to DineEase",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepOrangeAccent,
                  letterSpacing: 0.8,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset(
                "assets/icons/logo1.png",
                height: screenHeight/12,
              ),
              Text(
                "Order food with ease. \nLogin or create a new account to get started!",
                style: GoogleFonts.poppins( // Clean body font
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.75),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
              ),
              const SizedBox(height: 12),
              //SignUp Button
             ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              const SizedBox(height: 45)
            ],
          ),
        ),
      )

    );
  }
}
