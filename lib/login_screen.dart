import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/auth_services.dart';
import 'package:mad_project/feeformscreen.dart';

class Login01 extends StatefulWidget {
  const Login01({super.key});

  @override
  State<Login01> createState() => _Login01State();
}

class _Login01State extends State<Login01> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> _login() async {
    try {
      User? user = await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewForm()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign in: $e')));
    }
  }
  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.03), // 3% of screen height
              Padding(
                padding: EdgeInsets.all(width * 0.05),  // 5% of screen width
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(width * 0.02),  // 2% of screen width
                      child: Text(
                        "Login Page",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.09,  // 9% of screen width
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
                          fontSize: width * 0.06,  // 6% of screen width
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
                  padding: EdgeInsets.all(width * 0.07),  // 7% of screen width
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
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(width * 0.02),
                                child: TextField(
                                  controller: _passwordController,
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
                      Text("Forgot Password"),
                      SizedBox(height: height * 0.04),  // 4% of screen height
                      MaterialButton(
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.05,  // 5% of screen width
                            ),
                          ),
                        ),
                        height: height * 0.06,  // Button height 6% of screen height
                        color: Colors.orange[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {
                          _login();
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


// import 'package:flutter/material.dart';
// import 'package:mad_project/fee_reciptForm.dart';
// import 'package:mad_project/feeformscreen.dart';
//
// class Login01 extends StatefulWidget {
//   const Login01({super.key});
//
//   @override
//   State<Login01> createState() => _Login01State();
// }
//
// class _Login01State extends State<Login01> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(begin: Alignment.topCenter, colors: [
//               Colors.orange.shade900,
//               Colors.orange.shade800,
//               Colors.orange.shade400,
//             ])),
//         child: Column(
//           children: [
//             SizedBox(height: 30,),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       "Login Page",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 35,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       "Welcome back",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(height: 20,),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(60),
//                       topRight: Radius.circular(60)),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(30),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 40,),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Color.fromRGBO(225, 95, 27, .3),
//                                   blurRadius: 20,
//                                   offset: Offset(0, 10)
//                               ),
//                             ]
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                               ),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: "Email",
//
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                               ),
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: "Password",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 30,),
//                       Text("Forgot Password"),
//                       SizedBox(height: 40,),
//                       MaterialButton(
//                           child: Center(child: Text("Login",style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),),),
//                           height: 50,
//                           color: Colors.orange[900],
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50)
//                           ),
//                           onPressed: (){
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>NewForm()));
//
//                           }),
//                       SizedBox(height: 50,),
//                       Text("Continuie with Social Media"),
//                       SizedBox(height: 30,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: MaterialButton(
//                                 child: Center(child: Text("Facebook",style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//
//                                 ),),),
//                                 height: 49,
//                                 color: Colors.blue,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(50)
//                                 ),
//                                 onPressed: (){
//
//                                 }),
//
//                           ),
//                           SizedBox(width: 20,),
//                           Expanded(
//                             child: MaterialButton(
//                                 child: Center(child: Text("Github",style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),),),
//                                 height: 50,
//                                 color: Colors.black,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(50)
//                                 ),
//                                 onPressed: (){
//
//                                 }),
//                           ),
//                         ],
//                       )
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }