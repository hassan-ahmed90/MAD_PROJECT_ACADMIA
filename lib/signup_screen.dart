import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/auth_services.dart';
import 'package:mad_project/feeformscreen.dart';
import 'package:mad_project/login_screen.dart';

class Signup01 extends StatefulWidget {
  const Signup01({super.key});

  @override
  State<Signup01> createState() => _Signup01State();
}

class _Signup01State extends State<Signup01> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passwordControl = TextEditingController();
  final TextEditingController _nameControl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> _signup() async {
    try {
      User? user = await _authService.signUpWithEmail(
        _emailControl.text.trim(),
        _passwordControl.text.trim(),
      );
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login01()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign up: $e')));
    }
  }
  @override
  Widget build(BuildContext context) {
    // Get the screen size using MediaQuery
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400,
            ],
          ),
        ),
        child: SingleChildScrollView(  // Ensure scrollability
          child: Column(
            children: [
              SizedBox(height: height * 0.03),  // 3% of screen height
              Padding(
                padding: EdgeInsets.all(width * 0.05),  // 5% of screen width
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(width * 0.02),  // 2% of screen width
                      child: Text(
                        "SignUp Page",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.09,  // Font size 9% of screen width
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Text(
                        "Welcome back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.06,  // Font size 6% of screen width
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),  // 2% of screen height
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.07),  // Padding 7% of screen width
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.04),  // 4% of screen height
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(width * 0.02),  // 2% padding
                                child: TextFormField(
                                  controller: _nameControl,
                                  decoration: InputDecoration(
                                    hintText: "Academy Name",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.02),
                                child: TextField(
                                  controller: _emailControl,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.02),
                                child: TextField(
                                  controller: _passwordControl,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),  // 3% of screen height
                      Text("Already have an account"),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login01()));
                        },
                        child: Text("SignIn"),
                      ),
                      SizedBox(height: height * 0.04),  // 4% of screen height
                      MaterialButton(
                        child: Center(
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.05,  // Font size 5% of screen width
                            ),
                          ),
                        ),
                        height: height * 0.06,  // Button height 6% of screen height
                        color: Colors.orange[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {
                          _signup();
                        },
                      ),
                      SizedBox(height: height * 0.05),  // 5% of screen height
                      Text("Continue with Social Media"),
                      SizedBox(height: height * 0.03),  // 3% of screen height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MaterialButton(
                              child: Center(
                                child: Text(
                                  "Facebook",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.045,  // 4.5% of screen width
                                  ),
                                ),
                              ),
                              height: height * 0.06,  // Button height 6% of screen height
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: width * 0.05),  // 5% of screen width
                          Expanded(
                            child: MaterialButton(
                              child: Center(
                                child: Text(
                                  "Github",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.045,  // 4.5% of screen width
                                  ),
                                ),
                              ),
                              height: height * 0.06,
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

