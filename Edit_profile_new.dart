// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cyber_bullying/view_prof_new.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// var _formKey = GlobalKey<FormState>();
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const UserEditProfile(title: 'SIGNUP'),
//     );
//   }
// }
//
// class UserEditProfile extends StatefulWidget {
//   const UserEditProfile({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<UserEditProfile> createState() => _UserEditProfileState();
// }
//
// class _UserEditProfileState extends State<UserEditProfile> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController postController = TextEditingController();
//   TextEditingController pinController = TextEditingController();
//   TextEditingController regController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//
//   String gender = "Male";
//   String photo = "";
//
//   final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
//
//   _UserEditProfileState() {
//     view_data();
//   }
//
//   void view_data() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//
//     final urls = Uri.parse('$url/user_viewprofile/');
//     try {
//       final response = await http.post(urls, body: {'lid': lid});
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           String name = jsonDecode(response.body)['name'];
//           String dob = jsonDecode(response.body)['dob'].toString();
//           String gen = jsonDecode(response.body)['gender'];
//           String email = jsonDecode(response.body)['email'];
//           String phone = jsonDecode(response.body)['phone'].toString();
//           String place = jsonDecode(response.body)['place'];
//           String post = jsonDecode(response.body)['post'];
//           String pin = jsonDecode(response.body)['pin'].toString();
//           String image = sh.getString("img_url").toString() +
//               jsonDecode(response.body)['image'];
//
//           setState(() {
//             nameController.text = name;
//             dobController.text = dob;
//             gender = gen;
//             emailController.text = email;
//             phoneController.text = phone;
//             placeController.text = place;
//             postController.text = post;
//             pinController.text = pin;
//             photo = image;
//           });
//         } else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//     );
//
//     if (picked != null) {
//       setState(() {
//         dobController.text = _dateFormatter.format(picked);
//       });
//     }
//   }
//
//   var _isLoading = 'false';
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: ()async{
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Align(
//             child: Text(widget.title, textAlign: TextAlign.center),
//             alignment: Alignment.center,
//           ),
//         ),
//         body: SingleChildScrollView(
//             child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   SizedBox(
//                     width: 15,
//                   ),
//                   if (_selectedImage1 != null) ...{
//                     InkWell(
//                       child: Image.file(
//                         _selectedImage1!,
//                         height: 90,
//                         width: 90,
//                       ),
//                       radius: 60,
//                       onTap: _checkPermissionAndChooseImage,
//                       // borderRadius: BorderRadius.all(Radius.circular(200)),
//                     ),
//                   } else ...{
//                     // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
//                     InkWell(
//                       onTap: _checkPermissionAndChooseImage,
//                       child: Column(
//                         children: [
//                           Image(
//                             image: NetworkImage(photo),
//                             height: 90,
//                             width: 90,
//                           ),
//                           Text('Select Photo',
//                               style: TextStyle(color: Colors.cyan))
//                         ],
//                       ),
//                     ),
//                   },
//                 ],
//               ),
//
//               // Image.asset('assets/photo.png', height: 80, width: 40),
//               Padding(
//                 padding: EdgeInsets.all(5),
//                 child: TextFormField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.abc_outlined),
//                     floatingLabelBehavior: FloatingLabelBehavior.auto,
//                     labelText: 'Name',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Must enter your Name';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(7),
//                 child: TextFormField(
//                   controller: dobController,
//                   readOnly: true,
//                   onTap: () {
//                     _selectDate(context);
//                   },
//                   decoration: InputDecoration(
//                       labelText: 'Date of Birth',
//                       prefixIcon: Icon(Icons.date_range_outlined),
//                       floatingLabelBehavior: FloatingLabelBehavior.auto,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25))),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Must enter valid DOB';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               // Padding(
//               //   padding: EdgeInsets.all(7),
//               //   child: TextFormField(
//               //     controller: dobController,
//               //     decoration: InputDecoration(
//               //       labelText: 'Date Of Birth',
//               //       prefixIcon: Icon(Icons.date_range_outlined),
//               //       floatingLabelBehavior: FloatingLabelBehavior.auto,
//               //       border: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(20)),
//               //     ),
//               //     validator: (v){
//               //       if(v!.isEmpty){
//               //         return 'Must enter valid DOB';
//               //       }
//               //       return null;
//               //     },
//               //   ),
//               // ),
//               SizedBox(
//                 height: 3,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(7),
//                 child: Row(
//                   children: [
//                     Text(" Gender:"),
//                     SizedBox(
//                       width: .5,
//                     ),
//                     Radio(
//                         value: "Male",
//                         groupValue: gender,
//                         onChanged: (value) {
//                           setState(() {
//                             gender = "Male";
//                           });
//                         }),
//                     Text("Male"),
//                     SizedBox(
//                       width: .5,
//                     ),
//                     Radio(
//                         value: "Female",
//                         groupValue: gender,
//                         onChanged: (value) {
//                           setState(() {
//                             gender = "Female";
//                           });
//                         }),
//                     Text("Female"),
//                     SizedBox(
//                       width: .5,
//                     ),
//                     Radio(
//                         value: "Others",
//                         groupValue: gender,
//                         // onChanged: (String? value) {
//                         //   gender = "Others";
//                         onChanged: (value) {
//                           setState(() {
//                             gender = "Others";
//                           });
//                         }),
//                     Text("Others")
//                   ],
//                 ),
//               ),
//
//               // RadioListTile(
//               //     value: "Male",
//               //     groupValue: gender,
//               //     title: Text("Male"),
//               //     onChanged: (value) {
//               //       setState(() {
//               //         gender = "Male";
//               //       });
//               //     }),
//               // RadioListTile(
//               //     value: "Female",
//               //     groupValue: gender,
//               //     title: Text("Female"),
//               //     onChanged: (value) {
//               //       setState(() {
//               //         gender = "Female";
//               //       });
//               //     }),
//               // RadioListTile(
//               //     value: "Others",
//               //     groupValue: gender,
//               //     title: Text("Others"),
//               //     onChanged: (value) {
//               //       setState(() {
//               //         gender = "Others";
//               //       });
//               //     }),
//               Padding(
//                 padding: EdgeInsets.all(7),
//                 child: TextFormField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.email_outlined),
//                     floatingLabelBehavior: FloatingLabelBehavior.auto,
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty ||
//                         !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                             .hasMatch(value)) {
//                       return 'Enter a valid email!';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(7),
//                 child: TextFormField(
//                   maxLength: 10,
//                   controller: phoneController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.phone),
//                     floatingLabelBehavior: FloatingLabelBehavior.auto,
//                     labelText: 'Phone',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty || !RegExp(r"^[6789][0-9]{9}").hasMatch(v)) {
//                       return 'enter valid number';
//                     }
//                     if(v.length<10){
//                       return 'enter valid number';
//                     }
//
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(7),
//                 child: TextFormField(
//                   controller: placeController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.place_outlined),
//                     floatingLabelBehavior: FloatingLabelBehavior.auto,
//                     labelText: 'Place',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                   ),
//                   // validator: (v) {
//                   //   if (v!.isEmpty) {
//                   //     return 'Must enter valid place';
//                   //   }
//                   //   return null;
//                   // },
//                 ),
//               ),
//               // Padding(
//               //   padding: EdgeInsets.all(7),
//               //   child: TextFormField(
//               //     controller: postController,
//               //     decoration: InputDecoration(
//               //       labelText: 'Post',
//               //       prefixIcon: Icon(Icons.post_add_outlined),
//               //       floatingLabelBehavior: FloatingLabelBehavior.auto,
//               //       border: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(20)),
//               //     ),
//               //     validator: (v) {
//               //       if (v!.isEmpty) {
//               //         return 'Must enter valid post';
//               //       }
//               //       return null;
//               //     },
//               //   ),
//               // ),
//
//               // TextField(
//               //   controller: stateController,
//               //   decoration: InputDecoration(
//               //     labelText: 'State',
//               //     border: OutlineInputBorder(),
//               //   ),
//               // ),
//               Padding(
//                 padding: EdgeInsets.all(7),
//                 child: TextFormField(
//                   controller: pinController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.rate_review),
//                     floatingLabelBehavior: FloatingLabelBehavior.auto,
//                     labelText: 'Bio',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                   ),
//                   // validator: (v) {
//                   //   if (v!.isEmpty ){
//                   //     return 'Please Fill';
//                   //   }
//                   //   return null;
//                   // },
//                 ),
//               ),
//
//               // Padding(
//               //   padding: EdgeInsets.all(7),
//               //   child: TextFormField(
//               //     controller: passwordController,
//               //     decoration: InputDecoration(
//               //       prefixIcon: Icon(Icons.password_outlined),
//               //       floatingLabelBehavior: FloatingLabelBehavior.auto,
//               //       labelText: 'Password',
//               //       border: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(20)),
//               //     ),
//               //     validator: (v){
//               //       if(v!.isEmpty){
//               //         return 'Must enter Password';
//               //       }
//               //       return null;
//               //     },
//               //   ),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.all(7),
//               //   child: TextFormField(
//               //     controller: confirmPasswordController,
//               //     decoration: InputDecoration(
//               //       prefixIcon: Icon(Icons.password_outlined),
//               //       floatingLabelBehavior: FloatingLabelBehavior.auto,
//               //       labelText: 'Confirm Password',
//               //       border: OutlineInputBorder(
//               //           borderRadius: BorderRadius.circular(20)),
//               //     ),
//               //     validator: (value) {
//               //       if (value!.isEmpty) {
//               //         return 'Enter a valid email!';
//               //       }
//               //       else if(value!=passwordController.text)
//               //       {
//               //         return 'Passwords Missmatch ';
//               //       }
//               //       return null;
//               //     },
//               //   ),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.all(7),
//               //   child: Row(children: [
//               //     SizedBox(
//               //         width: 200,
//               //         child: Text("  Please Choose Your Blood Group : ")),
//               //     DropdownButton(
//               //       value: intrest,
//               //       // A variable to hold the selected item's value.
//               //       onChanged: (String? newValue) {
//               //         setState(() {
//               //           intrest = newValue.toString();
//               //           // Update the selected item when the user makes a selection.
//               //         });
//               //       },
//               //       items: <String>[
//               //         'A+',
//               //         'A-',
//               //         'B+',
//               //         'B-',
//               //         'O+',
//               //         'O-',
//               //         'AB+',
//               //         'AB-',
//               //       ].map<DropdownMenuItem<String>>((String value) {
//               //         return DropdownMenuItem<String>(
//               //           value: value,
//               //           child: Text(value),
//               //         );
//               //       }).toList(),
//               //     ),
//               //   ]),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.all(7),
//               //   child: Row(
//               //     children: [
//               //       Text("  Donate blood ? :"),
//               //       Radio(
//               //           value: "Yes",
//               //           groupValue: blood,
//               //           onChanged: (value) {
//               //             setState(() {
//               //               gender = "Yes";
//               //             });
//               //           }),
//               //       Text("Yes"),
//               //       SizedBox(
//               //         width: 3,
//               //       ),
//               //       Radio(
//               //           value: "No",
//               //           groupValue: blood,
//               //           onChanged: (value) {
//               //             setState(() {
//               //               gender = "No";
//               //             });
//               //           }),
//               //       Text("No"),
//               //       SizedBox(
//               //         width: 3,
//               //       ),
//               //     ],
//               //   ),
//               // ),
//
//               // Row(children: [
//               //   Text("Please Choose Your Blood Group"),
//               //   RadioListTile(
//               //       value: "Yes",
//               //       groupValue: blood,
//               //       title: Text("Yes"),
//               //       onChanged: (value) {
//               //         setState(() {
//               //           blood = "Yes";
//               //         });
//               //       }),
//               //   RadioListTile(
//               //       value: "No",
//               //       groupValue: blood,
//               //       title: Text("No"),
//               //       onChanged: (value) {
//               //         setState(() {
//               //           blood = "No";
//               //         });
//               //       }),
//               // ]),
//               // Row(mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     Text("Are You intrested to donate blood? :"),
//               //
//               //   ],),
//               //   children: [
//               // Text("Are You intrested to donate blood?"),
//
//               //   ],
//               // ),
//
//               SizedBox(
//                 height: 4,
//               ),
//               ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       if (uploadimage1 == null) {
//                         senddata();
//                       } else {
//                         Fluttertoast.showToast(
//                             msg: "Upload photo",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.BOTTOM,
//                             backgroundColor: Colors.grey,
//                             textColor: Colors.white,
//                             fontSize: 12.0);
//                       }
//                     } else {
//                       Fluttertoast.showToast(
//                           msg: "Fill all the fields",
//                           toastLength: Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.BOTTOM,
//                           backgroundColor: Colors.grey,
//                           textColor: Colors.white,
//                           fontSize: 12.0);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25))),
//                   child: Text('submit')),
//             ],
//           ),
//         )),
//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: _incrementCounter,
//         //   tooltip: 'Increment',
//         //   child: const Icon(Icons.add),
//         // ), // This trailing comma makes auto-formatting nicer for build methods.
//       ),
//     );
//   }
//
//   void senddata() async {
//     String name = nameController.text;
//     String dob = dobController.text;
//     String email = emailController.text;
//     String phone = phoneController.text;
//     String place = placeController.text;
//     String post = postController.text;
//     String pin = pinController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url").toString();
//     String lid = sh.getString("lid").toString();
//
//     final urls = Uri.parse('$url/user_viewprofileandeditprofile/');
//
//     try {
//       var request = http.MultipartRequest('POST', urls);
//
//       // Add text fields
//       request.fields['lid'] = lid;
//       request.fields['name'] = name;
//       request.fields['dob'] = dob;
//       request.fields['gender'] = gender;
//       request.fields['email'] = email;
//       request.fields['phone'] = phone;
//       request.fields['place'] = place;
//       request.fields['post'] = post;
//       request.fields['pin'] = pin;
//
//       // Add image file (if selected)
//       if (photo1 != null && photo1.isNotEmpty) {
//         request.files.add(await http.MultipartFile.fromPath('image', photo1));
//       }
//
//       // Send the request
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         var responseData = await response.stream.bytesToString();
//         var jsonData = jsonDecode(responseData);
//
//         String status = jsonData['status'];
//
//         if (status == "ok") {
//           Fluttertoast.showToast(msg: "Updated..");
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => userProfile_new1(title: "Profile"),
//             ),
//           );
//         } else if (status == 'no') {
//           Fluttertoast.showToast(msg: "Email already exists..");
//         } else {
//           Fluttertoast.showToast(msg: "Email Already Exists");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Request failed (${response.statusCode})");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   String photo1 = '';
//   File? uploadimage1;
//
//   File? _selectedImage1;
//   String? _encodedImage1;
//
//   Future<void> _chooseAndUploadImage1() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.camera);
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage1 = File(pickedImage.path);
//         _encodedImage1 = base64Encode(_selectedImage1!.readAsBytesSync());
//         photo1 = _encodedImage1.toString();
//       });
//     }
//   }
//
//   Future<void> _checkPermissionAndChooseImage() async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       _chooseAndUploadImage1();
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: const Text('Permission Denied'),
//           content: const Text(
//             'Please go to app settings and grant permission to choose an image.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }


import 'dart:convert';
import 'dart:io';

import 'package:cyber_bullying/view_prof_new.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

var _formKey = GlobalKey<FormState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile',
      theme: ThemeData(
        primaryColor: Color(0xFF6366F1),
        scaffoldBackgroundColor: Color(0xFF0F0F0F),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF1A1A1A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF6366F1)),
          ),
          labelStyle: TextStyle(color: Colors.grey[400]),
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
      home: const UserEditProfile(title: 'Edit Profile'),
    );
  }
}

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key, required this.title});

  final String title;

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  String gender = "Male";
  String photo = "";

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  _UserEditProfileState() {
    view_data();
  }

  void view_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_viewprofile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String dob = jsonDecode(response.body)['dob'].toString();
          String gen = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'];
          String post = jsonDecode(response.body)['post'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String image = sh.getString("img_url").toString() +
              jsonDecode(response.body)['image'];

          setState(() {
            nameController.text = name;
            dobController.text = dob;
            gender = gen;
            emailController.text = email;
            phoneController.text = phone;
            placeController.text = place;
            postController.text = post;
            pinController.text = pin;
            photo = image;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Color(0xFF1A1A1A),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        dobController.text = _dateFormatter.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0F0F0F),
        appBar: AppBar(
          backgroundColor: Color(0xFF1A1A1A),
          elevation: 0,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Profile Photo Section
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF6366F1),
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: _selectedImage != null
                                  ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              )
                                  : (photo.isNotEmpty
                                  ? Image.network(
                                photo,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildPlaceholderImage(),
                              )
                                  : _buildPlaceholderImage()),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFF6366F1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF0F0F0F),
                                  width: 3,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.camera_alt_rounded,
                                    color: Colors.white, size: 18),
                                onPressed: _pickImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap camera icon to change photo',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Personal Information Section
                _buildSection(
                  title: 'Personal Information',
                  children: [
                    _buildTextField(
                      controller: nameController,
                      icon: Icons.person_outline,
                      label: 'Full Name',
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildDateField(),
                    SizedBox(height: 16),
                    _buildGenderSelector(),
                  ],
                ),

                SizedBox(height: 24),

                // Contact Information Section
                _buildSection(
                  title: 'Contact Information',
                  children: [
                    _buildTextField(
                      controller: emailController,
                      icon: Icons.email_outlined,
                      label: 'Email Address',
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: phoneController,
                      icon: Icons.phone_iphone_rounded,
                      label: 'Phone Number',
                      maxLength: 10,
                      validator: (v) {
                        if (v!.isEmpty || !RegExp(r"^[6789][0-9]{9}").hasMatch(v)) {
                          return 'Enter a valid phone number';
                        }
                        if (v.length < 10) {
                          return 'Phone number must be 10 digits';
                        }
                        return null;
                      },
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Location Information Section
                _buildSection(
                  title: 'Location Information',
                  children: [
                    _buildTextField(
                      controller: placeController,
                      icon: Icons.location_on_outlined,
                      label: 'Place',
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: pinController,
                      icon: Icons.description_outlined,
                      label: 'Bio',
                      maxLines: 3,
                    ),
                  ],
                ),

                SizedBox(height: 32),

                // Submit Button
                Container(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Color(0xFF2A2A2A),
      child: Icon(
        Icons.person,
        color: Colors.grey[600],
        size: 40,
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    String? Function(String?)? validator,
    int? maxLength,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[500]),
        counterStyle: TextStyle(color: Colors.grey[500]),
      ),
      validator: validator,
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        prefixIcon: Icon(Icons.calendar_today_rounded, color: Colors.grey[500]),
        suffixIcon: Icon(Icons.arrow_drop_down_rounded, color: Colors.grey[500]),
      ),
      validator: (v) {
        if (v!.isEmpty) {
          return 'Please select your date of birth';
        }
        return null;
      },
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF252525),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[700]!),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildGenderOption(
                  value: "Male",
                  label: "Male",
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.grey[700],
              ),
              Expanded(
                child: _buildGenderOption(
                  value: "Female",
                  label: "Female",
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.grey[700],
              ),
              Expanded(
                child: _buildGenderOption(
                  value: "Others",
                  label: "Others",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required String value,
    required String label,
  }) {
    bool isSelected = gender == value;
    return InkWell(
      onTap: () {
        setState(() {
          gender = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6366F1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      senddata();
    } else {
      Fluttertoast.showToast(
        msg: "Please fill all required fields correctly",
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
    }
  }

  void senddata() async {
    String name = nameController.text;
    String dob = dobController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String place = placeController.text;
    String post = postController.text;
    String pin = pinController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    final urls = Uri.parse('$url/user_viewprofileandeditprofile/');

    try {
      var request = http.MultipartRequest('POST', urls);

      // Add text fields
      request.fields['lid'] = lid;
      request.fields['name'] = name;
      request.fields['dob'] = dob;
      request.fields['gender'] = gender;
      request.fields['email'] = email;
      request.fields['phone'] = phone;
      request.fields['place'] = place;
      request.fields['post'] = post;
      request.fields['pin'] = pin;

      // Add image file (if selected)
      if (_selectedImage != null) {
        request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseData);

        String status = jsonData['status'];

        if (status == "ok") {
          Fluttertoast.showToast(
            msg: "Profile updated successfully!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => userProfile_new1(title: "Profile"),
            ),
          );
        } else if (status == 'no') {
          Fluttertoast.showToast(msg: "Email already exists");
        } else {
          Fluttertoast.showToast(msg: "Email already exists");
        }
      } else {
        Fluttertoast.showToast(msg: "Request failed (${response.statusCode})");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
}