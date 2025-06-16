import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final screen_width=MediaQuery.of(context).size.width;
    final screen_height=MediaQuery.of(context).size.height;
    final InputDecoration emailDecoration=InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Enter your username',
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      prefixIcon: Icon(Icons.email, color: Colors.grey),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
    final InputDecoration passwordDecoration=InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Enter the password',
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      prefixIcon: Icon(Icons.email, color: Colors.grey),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: screen_height/5,),
                TextFormField(
                  decoration:  emailDecoration,
                ),
                SizedBox(height: 20,),

                TextFormField(
                  decoration: passwordDecoration,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
