// import 'dart:convert';
//
// import 'package:cyber_bullying/home.dart';
// import 'package:cyber_bullying/login.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'Loginmain.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const Mychangepasswordpage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class Mychangepasswordpage extends StatefulWidget {
//   const Mychangepasswordpage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<Mychangepasswordpage> createState() => _MychangepasswordpageState();
// }
//
// class _MychangepasswordpageState extends State<Mychangepasswordpage> {
//   TextEditingController oldpasswordcontroller = TextEditingController();
//   TextEditingController newpasswordcontroller = TextEditingController();
//   TextEditingController confirmpasswordcontroller = TextEditingController();
//
//   bool sh=true;
//   bool sh1=true;
//   bool sh2=true;
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomeNewPage(title: 'Home'),
//             ));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: Text('Change password'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TextField(
//                   obscureText: sh,
//                   controller: oldpasswordcontroller,
//                   decoration: InputDecoration(
//                     suffixIcon: IconButton(onPressed: (){
//                       setState(() {
//                         if(sh==true){
//                           sh=false;
//                         }
//                         else{
//                           sh=true;
//
//                         }
//                       });
//                     }, icon: sh==true?Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined)),
//                       border: OutlineInputBorder(
//                       ), hintText: 'oldpassword'),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   obscureText: sh2,
//                   controller: newpasswordcontroller,
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(onPressed: (){
//                         setState(() {
//                           if(sh2==true){
//                             sh2=false;
//                           }
//                           else{
//                             sh2=true;
//
//                           }
//                         });
//                       }, icon: sh2==true?Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined)),
//                       border: OutlineInputBorder(), hintText: 'newpassword'),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   obscureText: sh1,
//                   controller: confirmpasswordcontroller,
//                   decoration: InputDecoration(
//                       suffixIcon: IconButton(onPressed: (){
//                         setState(() {
//                           if(sh1==true){
//                             sh1=false;
//                           }
//                           else{
//                             sh1=true;
//
//                           }
//                         });
//                       }, icon: sh1==true?Icon(Icons.visibility_outlined):Icon(Icons.visibility_off_outlined)),
//                       border: OutlineInputBorder(), hintText: 'confirmpassword'),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       _send_data();
//                     },
//                     child: Text('submit'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _send_data() async {
//     String current = oldpasswordcontroller.text;
//     String newp = newpasswordcontroller.text;
//     String confirm = confirmpasswordcontroller.text;
//
//     if (current.length == 0) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Missing current password'),
//         backgroundColor: Colors.green,
//         elevation: 10,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackdemo);
//     } else if (current.length < 8) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Current password must be 8 characters'),
//         backgroundColor: Colors.green,
//         elevation: 10,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackdemo);
//     } else if (newp.length == 0) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Missing new password'),
//         backgroundColor: Colors.green,
//         elevation: 10,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackdemo);
//     } else if (newp.length < 8) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Current password must be 8 characters'),
//         backgroundColor: Colors.green,
//         elevation: 10,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackdemo);
//     } else if (confirm.length == 0) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Missing confirm password'),
//         backgroundColor: Colors.green,
//         elevation: 10,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackdemo);
//     } else if (confirm.length < 8) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Current password must be 8 characters'),
//         backgroundColor: Colors.green,
//         elevation: 10,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackdemo);
//     } else if (newp != confirm) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Mismatch between  new and confirm password'),
//         backgroundColor: Colors.green,
//         elevation: 10,
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackdemo);
//     } else {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//
//       final urls = Uri.parse('$url/user_chnagepassword/');
//       try {
//         final response = await http.post(urls, body: {
//           'oldpassword': current,
//           'newpassword': newp,
//           'confirmpassword': confirm,
//           'lid': lid,
//         });
//         if (response.statusCode == 200) {
//           String status = jsonDecode(response.body)['status'];
//           if (status == 'ok') {
//             // String lid = jsonDecode(response.body)['lid'];
//             // sh.setString("lid", lid);
//             Fluttertoast.showToast(msg: 'successfully changed');
//
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => LoginNewFull(),
//                 ));
//           } else {
//             Fluttertoast.showToast(msg: 'Not Found');
//           }
//         } else {
//           Fluttertoast.showToast(msg: 'Network Error');
//         }
//       } catch (e) {
//         Fluttertoast.showToast(msg: e.toString());
//       }
//     }
//   }
// }



import 'dart:convert';
import 'package:cyber_bullying/home.dart';
import 'package:cyber_bullying/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Loginmain.dart';

class Mychangepasswordpage extends StatefulWidget {
  const Mychangepasswordpage({super.key, required this.title});
  final String title;

  @override
  State<Mychangepasswordpage> createState() => _MychangepasswordpageState();
}

class _MychangepasswordpageState extends State<Mychangepasswordpage> {
  TextEditingController oldpasswordcontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  bool sh = true;
  bool sh1 = true;
  bool sh2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home')),
            );
          },
        ),
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Current Password
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                obscureText: sh,
                controller: oldpasswordcontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock, color: Colors.grey[400]),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        sh = !sh;
                      });
                    },
                    icon: Icon(
                      sh ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),

            SizedBox(height: 16),

            // New Password
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                obscureText: sh2,
                controller: newpasswordcontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock, color: Colors.grey[400]),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        sh2 = !sh2;
                      });
                    },
                    icon: Icon(
                      sh2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Confirm Password
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                obscureText: sh1,
                controller: confirmpasswordcontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock, color: Colors.grey[400]),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        sh1 = !sh1;
                      });
                    },
                    icon: Icon(
                      sh1 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Update Button
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _send_data();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'UPDATE PASSWORD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _send_data() async {
    String current = oldpasswordcontroller.text;
    String newp = newpasswordcontroller.text;
    String confirm = confirmpasswordcontroller.text;

    if (current.length == 0) {
      _showSnackBar('Please enter current password');
    } else if (current.length < 8) {
      _showSnackBar('Current password must be 8 characters');
    } else if (newp.length == 0) {
      _showSnackBar('Please enter new password');
    } else if (newp.length < 8) {
      _showSnackBar('New password must be 8 characters');
    } else if (confirm.length == 0) {
      _showSnackBar('Please confirm password');
    } else if (confirm.length < 8) {
      _showSnackBar('Confirm password must be 8 characters');
    } else if (newp != confirm) {
      _showSnackBar('New and confirm password do not match');
    } else {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();

      final urls = Uri.parse('$url/user_chnagepassword/');
      try {
        final response = await http.post(urls, body: {
          'oldpassword': current,
          'newpassword': newp,
          'confirmpassword': confirm,
          'lid': lid,
        });
        if (response.statusCode == 200) {
          String status = jsonDecode(response.body)['status'];
          if (status == 'ok') {
            Fluttertoast.showToast(
              msg: 'Password changed successfully',
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginNewFull()),
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Current password is incorrect',
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Network error',
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
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}