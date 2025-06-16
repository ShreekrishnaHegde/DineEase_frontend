import 'package:dine_ease/views/login_signup/login.dart';
import 'package:dine_ease/views/login_signup/signup.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      foregroundColor: Colors.black87,
      minimumSize: Size(double.infinity, 50),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      backgroundColor: Colors.amberAccent,
    );
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.black87,
      backgroundColor: Colors.grey[300],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Image
            Image.asset(
              'assets/landing_screen/LS01.png',
              width: 0.8*screenWidth,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                },
                // style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                style: flatButtonStyle,
                child: Text("Login"),
              ),
            ),
            //SignUp Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                },
                style: flatButtonStyle,
                child: Text("SignUp"),
              ),
            ),
            SizedBox(height: 45)
          ],
        ),
      )

    );
  }
}
