// import 'dart:convert';
//
// import 'package:animate_do/animate_do.dart';
// import 'package:cyber_bullying/register.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import '../main.dart';
// import 'home.dart';
// import 'ipmain.dart';
//
// void main() {
//   runApp(const MainApp());
// }
//
// class MainApp extends StatelessWidget {
//   const MainApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.from(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
//         ),
//       ),
//       home: LoginNewFull(),
//     );
//   }
// }
//
// // class login_new_full extends StatefulWidget {
// //   +++++++-login_new_full({
// //     Key? key,
// //   }) : super(key: key);
// //
// //   @override
// //   State<login_new_full> createState() => _LoginState();
// // }
//
// class LoginNewFull extends StatefulWidget {
//   const LoginNewFull({Key? key}) : super(key: key);
//
//   @override
//   State<LoginNewFull> createState() => _LoginState();
// }
//
//
//
// class _LoginState extends State<LoginNewFull> {
//   final FocusNode _focusNodePassword = FocusNode();
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();
//   final _formkey = GlobalKey<FormState>();
//
//   bool sh = true;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => ipmainp()));
//
//         return false;
//       },
//       child:
//       Scaffold(
//         body:
//         SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 height: 400,
//                 child: Stack(
//                   children: <Widget>[
//                     Positioned(
//                       top: -40,
//                       height: 400,
//                       width: width,
//                       child: FadeInUp(duration: Duration(seconds: 1), child: Container(
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage('assets/images/background.png'),
//                                 fit: BoxFit.fill
//                             )
//                         ),
//                       )),
//                     ),
//                     Positioned(
//                       height: 400,
//                       width: width+20,
//                       child: FadeInUp(duration: Duration(milliseconds: 1000), child: Container(
//                         decoration: BoxDecoration(
//                             image: DecorationImage(
//                                 image: AssetImage('assets/images/background-2.png'),
//                                 fit: BoxFit.fill
//                             )
//                         ),
//                       )),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 40),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
//                     SizedBox(height: 30,),
//                     FadeInUp(duration: Duration(milliseconds: 1700), child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                           border: Border.all(color: Color.fromRGBO(196, 135, 198, .3)),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromRGBO(196, 135, 198, .3),
//                               blurRadius: 20,
//                               offset: Offset(0, 10),
//                             )
//                           ]
//                       ),
//                       child: Column(
//                         children: <Widget>[
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                                 border: Border(bottom: BorderSide(
//                                     color: Color.fromRGBO(196, 135, 198, .3)
//                                 ))
//                             ),
//                             child: TextField(
//                               controller: _controllerUsername,
//                               decoration: InputDecoration(
//                                   border: InputBorder.none,
//                                   hintText: "Username",
//                                   hintStyle: TextStyle(color: Colors.grey.shade700)
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(10),
//                             child: TextField(
//                               controller: _controllerPassword,
//                               obscureText: sh,
//                               decoration: InputDecoration(
//                                   suffixIcon: IconButton(onPressed: (){
//                                     setState(() {
//                                       if(sh==true){
//                                         sh=false;
//                                       }
//                                       else{
//                                         sh=true;
//
//                                       }
//                                     });
//                                   }, icon: sh==true?Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined)),
//                                   border: InputBorder.none,
//                                   hintText: "Password",
//                                   hintStyle: TextStyle(color: Colors.grey.shade700)
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )),
//                     SizedBox(height: 30,),
//                     FadeInUp(duration: Duration(milliseconds: 1900), child: MaterialButton(
//                       onPressed: () {
//                         senddata();
//                       },
//                       color: Colors.indigo,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       height: 50,
//                       child: Center(
//                         child: Text("Login", style: TextStyle(color: Colors.white),),
//                       ),
//                     )),
//                     SizedBox(height: 30,),
//
//                     FadeInUp(duration: Duration(milliseconds: 1900), child: MaterialButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MyRegisterPage(title: ''),
//                             ));
//                       },
//                       child: Center(
//                         child: Text("Don\'t have an account ? click here", style: TextStyle(color: Colors.black),),
//                       ),
//                     )),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//
//     );
//   }
//
//   @override
//   void dispose() {
//     _focusNodePassword.dispose();
//     _controllerUsername.dispose();
//     _controllerPassword.dispose();
//     super.dispose();
//   }
//
//   void senddata() async {
//     String username = _controllerUsername.text;
//     String password = _controllerPassword.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/user_login/');
//     try {
//       final response = await http.post(urls, body: {
//         'username': username,
//         'password': password,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           String lid = jsonDecode(response.body)['lid'].toString();
//           sh.setString("lid", lid);
//
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomeNewPage(title: ''),
//               ));
//         } else {
//           Fluttertoast.showToast(msg: 'Account is blocked');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   String? validateUsername(String value) {
//     if (value.isEmpty) {
//       return 'Please enter a User Name';
//     }
//     return null;
//   }
//
//   String? validatePassword(String value) {
//     if (value.isEmpty) {
//       return 'Please enter a Password';
//     }
//     return null;
//   }
// }


import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:cyber_bullying/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'home.dart';
import 'ipmain.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent,
          secondary: Colors.cyanAccent,
        ),
      ),
      home: LoginNewFull(),
    );
  }
}

class LoginNewFull extends StatefulWidget {
  const LoginNewFull({Key? key}) : super(key: key);

  @override
  State<LoginNewFull> createState() => _LoginState();
}

class _LoginState extends State<LoginNewFull> {
  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool sh = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ipmainp()));
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0A0E21),
        body: SingleChildScrollView(
          child: Container(
            height: height,
            child: Stack(
              children: [
                // Background Elements
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -150,
                  left: -100,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Main Content
                Column(
                  children: [
                    SizedBox(height: height * 0.15),

                    // Logo/Image Section
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              Colors.purpleAccent,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.security,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Welcome Text
                    FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 5),

                    FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text(
                        "Sign in to continue",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SizedBox(height: 40),

                    // Login Form
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 1400),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF1D1E33),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Username Field
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[800]!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _controllerUsername,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500]),
                                        prefixIcon: Icon(
                                          Icons.person_outline,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Password Field
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: TextField(
                                      controller: _controllerPassword,
                                      obscureText: sh,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500]),
                                        prefixIcon: Icon(
                                          Icons.lock_outline,
                                          color: Colors.grey[500],
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              sh = !sh;
                                            });
                                          },
                                          icon: Icon(
                                            sh
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 30),

                          // Login Button
                          FadeInUp(
                            duration: Duration(milliseconds: 1500),
                            child: Container(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : senddata,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.blueAccent.withOpacity(0.3),
                                ),
                                child: _isLoading
                                    ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                                    : Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 25),

                          // Register Link
                          FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MyRegisterPage(title: ''),
                                  ),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Sign Up",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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

  @override
  void dispose() {
    _focusNodePassword.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void senddata() async {
    String username = _controllerUsername.text;
    String password = _controllerPassword.text;

    if (username.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all fields',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/user_login/');
    print(urls);
    try {
      final response = await http.post(urls, body: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'].toString();
          sh.setString("lid", lid);

          Fluttertoast.showToast(
            msg: 'Login successful',
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNewPage(title: ''),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Account is blocked',
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Network Error',
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Please enter a User Name';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a Password';
    }
    return null;
  }
}