import 'package:dine_ease/views/login_signup/login.dart';
import 'package:dine_ease/views/login_signup/signup.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(

      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      minimumSize: Size(double.infinity,50),
      // padding: EdgeInsets.symmetric(horizontal: 100),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(

          ),
          child: Column(
            children: [
              //Image
              Image.asset(
                "assets/landing_screen/LS02.jpg",
                width: 0.8*screenWidth,
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              //SignUp Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45)
            ],
          ),
        ),
      )

    );
  }
}
