import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Image
            Image.asset(
              'assets/landing_screen/logo.png',
              width: 0.75*screenWidth,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                child: Text("Login"),
              ),
            ),
            //SignUp Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                child: Text("SignUp"),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      )

    );
  }
}
