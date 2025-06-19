import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:dine_ease/views/login_signup/login.dart';
import 'package:dine_ease/views/login_signup/profile_page.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final authService=AuthService();

  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  final _confirmPasswordController=TextEditingController();

  String? selectedRole;
  final List<String> roles = ['Hotel', 'Guest'];

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

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.black,
    minimumSize: Size(double.infinity,50),
    // padding: EdgeInsets.symmetric(horizontal: 100),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );

  void signup() async{
    final email=_emailController.text;
    final password=_passwordController.text;
    final confirmPassword=_confirmPasswordController.text;
    if(password!=confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Error: Passwords do not match")));
      return;
    }
    try{
      await authService.signUpWithEmailPassword(email, password);
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfilePage()),);
      }
    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:  Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final screen_height=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
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
                  controller: _emailController,
                  decoration: buildInputDecoration("Email"),
                ),
                SizedBox(height: screen_height/50,),
                TextFormField(
                  controller: _passwordController,
                  decoration: buildInputDecoration("Password"),
                ),
                SizedBox(height: screen_height/50,),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: buildInputDecoration("Confirm Password"),
                ),
                SizedBox(height: screen_height/50,),
                DropdownButtonFormField(
                    decoration: buildInputDecoration("Select Role"),
                    value: selectedRole,
                    isExpanded: true,
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
                  onPressed: signup,
                  child: const Text(
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
                    const Text("Already have an account?"),
                    TextButton(
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text(
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
