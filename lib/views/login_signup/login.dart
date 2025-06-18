import 'package:dine_ease/service/auth_service/auth_service.dart';
import 'package:dine_ease/views/login_signup/signup.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  InputDecoration buildInputDecoration(String labelText,IconData icon) {
    return InputDecoration(
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
      prefixIcon: Icon(icon, color: Colors.grey),
      filled: true,
      fillColor: Colors.grey.shade100,
    );
  }

  final authService=AuthService();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  void login() async{
    final email=_emailController.text;
    final password=_emailController.text;
    try{
      await authService.signInWithEmailPassword(email, password);

    }
    catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    final screen_width=MediaQuery.of(context).size.width;
    final screen_height=MediaQuery.of(context).size.height;

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          "Login",
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
                SizedBox(height: screen_height/15,),
                TextFormField(
                  controller: _emailController,
                  decoration:  buildInputDecoration("Enter your email", Icons.email),
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: _passwordController,
                  decoration: buildInputDecoration("Enter the password", Icons.password),
                ),
                SizedBox(height: 30,),
                ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () { },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "SignUp",
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
