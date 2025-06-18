import 'package:dine_ease/views/login_signup/login.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  InputDecoration buildInputDecoration(String labelText,) {
    return InputDecoration(
      border: UnderlineInputBorder(),
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      // prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
  }
  @override
  Widget build(BuildContext context) {
    String? selectedRole;
    final screen_width=MediaQuery.of(context).size.width;
    final screen_height=MediaQuery.of(context).size.height;
    final List<String> roles = ['Hotel', 'Guest'];
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                SizedBox(height: screen_height/25,),
                TextFormField(
                  decoration: buildInputDecoration("Full Name"),
                ),
                SizedBox(height: screen_height/50,),
                TextFormField(
                  decoration: buildInputDecoration("Email"),
                ),
                SizedBox(height: screen_height/50,),
                TextFormField(
                  obscureText: true,
                  decoration: buildInputDecoration("Password"),
                ),
                SizedBox(height: screen_height/50,),
                DropdownButtonFormField(
                    decoration: buildInputDecoration("Select Role"),
                    value: selectedRole,
                    items: roles.map(
                            (role){
                          return DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          );
                        }
                    ).toList(),
                    onChanged: (value){
                      setState(() {
                        selectedRole=value;
                      });
                    }
                ),
                SizedBox(height: screen_height/50,),
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () { },
                  child: Text(
                    "Signup",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
