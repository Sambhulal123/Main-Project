//
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'Edit_profile_new.dart';
// import 'home.dart';
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
//       title: '',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//     );
//   }
// }
//
// class userProfile_new1 extends StatefulWidget {
//   const userProfile_new1({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<userProfile_new1> createState() => _userProfile_new1State();
// }
//
// class _userProfile_new1State extends State<userProfile_new1> {
//   bool isPrivate = true; // Tracks which button is active
//   String name_ = "";
//   String dob_ = "";
//   String gender_ = "";
//   String email_ = "";
//   String phone_ = "";
//   String place_ = "";
//   String post_ = "";
//   String pin_ = "";
//   String photo_ = "";
//
//   @override
//   void initState() {
//     super.initState();
//     senddata();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomeNewPage(
//               title: '',
//             ),
//           ),
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.grey.shade300,
//         body: SingleChildScrollView(
//           child: Stack(
//             children: [
//               SizedBox(
//                 height: 280,
//                 width: double.infinity,
//                 child: Image.network(
//                   photo_,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(16.0),
//                           margin: const EdgeInsets.only(top: 16.0),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20.0),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.only(left: 110.0),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: 170,
//                                           child: Text(
//                                             ' $name_',
//
//                                           ),
//                                         ),
//                                         const SizedBox(height: 40),
//                                       ],
//                                     ),
//                                     const Spacer(),
//                                     CircleAvatar(
//                                       backgroundColor: Colors.blueAccent,
//                                       child: IconButton(
//                                         onPressed: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   UserEditProfile(
//                                                     title: '',
//                                                   ),
//                                             ),
//                                           );
//                                         },
//                                         icon: const Icon(
//                                           Icons.edit_outlined,
//                                           color: Colors.white,
//                                           size: 18,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 10.0),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           height: 90,
//                           width: 90,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             image: DecorationImage(
//                               image: NetworkImage(photo_),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           margin: const EdgeInsets.only(left: 20.0),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20.0),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             title: const Text('Bio'),
//                             subtitle: Text(pin_),
//                             leading: const Icon(Icons.rate_review),
//                           ),
//                           ListTile(
//                             title: const Text('Email'),
//                             subtitle: Text(email_),
//                             leading: const Icon(Icons.mail_outline),
//                           ),
//                           ListTile(
//                             title: const Text("Phone"),
//                             subtitle: Text(phone_),
//                             leading: const Icon(Icons.phone),
//                           ),
//                           ListTile(
//                             title: const Text('Address'),
//                             subtitle: Text('${place_} \n ${post_} '),
//                             leading: const Icon(Icons.location_city),
//                           ),
//                           const SizedBox(height: 20.0),
//
//                           // Private and Public Buttons
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // Private Button
//                               ElevatedButton(
//                                 onPressed: () => _changeAccountVisibility(true),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: isPrivate
//                                       ? Colors.blue
//                                       : Colors.grey.shade300,
//                                   foregroundColor: isPrivate
//                                       ? Colors.white
//                                       : Colors.black,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   ),
//                                 ),
//                                 child: const Text('Private'),
//                               ),
//                               const SizedBox(width: 20),
//
//                               // Public Button
//                               ElevatedButton(
//                                 onPressed: () => _changeAccountVisibility(false),
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: !isPrivate
//                                       ? Colors.blue
//                                       : Colors.grey.shade300,
//                                   foregroundColor: !isPrivate
//                                       ? Colors.white
//                                       : Colors.black,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   ),
//                                 ),
//                                 child: const Text('Public'),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _changeAccountVisibility(bool makePrivate) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString("lid",).toString();
//     String endpoint = makePrivate ? 'add_private_account' : 'add_public_account';
//
//     final urls = Uri.parse('$url/$endpoint/');
//     try {
//       final response = await http.post(urls, body: {'lid': lid});
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           setState(() {
//             isPrivate = makePrivate;
//           });
//           Fluttertoast.showToast(
//             msg: makePrivate
//                 ? "Account set to Private"
//                 : "Account set to Public",
//           );
//         } else {
//           Fluttertoast.showToast(msg: 'Operation failed');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   void senddata() async {
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
//           String gender = jsonDecode(response.body)['gender'];
//           String email = jsonDecode(response.body)['email'];
//           String phone = jsonDecode(response.body)['phone'].toString();
//           String place = jsonDecode(response.body)['place'];
//           String post = jsonDecode(response.body)['post'];
//           String pin = jsonDecode(response.body)['pin'].toString();
//           String image = sh.getString("img_url").toString() +
//               jsonDecode(response.body)['image'];
//
//           setState(() {
//             name_ = name;
//             dob_ = dob;
//             gender_ = gender;
//             email_ = email;
//             phone_ = phone;
//             place_ = place;
//             post_ = post;
//             pin_ = pin;
//             photo_ = image;
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
// }
//


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Edit_profile_new.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(
        primaryColor: Color(0xFF6366F1),
        scaffoldBackgroundColor: Color(0xFF0F0F0F),
        cardTheme: CardTheme(
          color: Color(0xFF1A1A1A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: TextTheme(
          displaySmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class userProfile_new1 extends StatefulWidget {
  const userProfile_new1({super.key, required this.title});

  final String title;

  @override
  State<userProfile_new1> createState() => _userProfile_new1State();
}

class _userProfile_new1State extends State<userProfile_new1> {
  bool isPrivate = true;
  String name_ = "";
  String dob_ = "";
  String gender_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String post_ = "";
  String pin_ = "";
  String photo_ = "";

  @override
  void initState() {
    super.initState();
    senddata();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeNewPage(title: ''),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0F0F0F),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: Color(0xFF1A1A1A),
                leading: IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.white, size: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeNewPage(title: ''),
                      ),
                    );
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF6366F1).withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Profile Image and Name
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(0xFF6366F1),
                                width: 3,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                photo_,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Color(0xFF2A2A2A),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey[600],
                                        size: 40,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name_,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  email_,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Color(0xFF6366F1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserEditProfile(title: ''),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Privacy Toggle
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFF252525),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => _changeAccountVisibility(true),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isPrivate ? Color(0xFF6366F1) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock_outline,
                                        color: isPrivate ? Colors.white : Colors.grey[500],
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Private',
                                        style: TextStyle(
                                          color: isPrivate ? Colors.white : Colors.grey[500],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => _changeAccountVisibility(false),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: !isPrivate ? Color(0xFF6366F1) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.public,
                                        color: !isPrivate ? Colors.white : Colors.grey[500],
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Public',
                                        style: TextStyle(
                                          color: !isPrivate ? Colors.white : Colors.grey[500],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
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
                ),

                SizedBox(height: 20),

                // Personal Information
                _buildSection(
                  title: 'Personal Information',
                  children: [
                    _buildInfoItem(
                      icon: Icons.description_outlined,
                      title: 'Bio',
                      value: pin_.isNotEmpty ? pin_ : 'No bio added',
                    ),
                    _buildInfoItem(
                      icon: Icons.cake_outlined,
                      title: 'Date of Birth',
                      value: dob_.isNotEmpty ? dob_ : 'Not specified',
                    ),
                    _buildInfoItem(
                      icon: Icons.person_outline,
                      title: 'Gender',
                      value: gender_.isNotEmpty ? gender_ : 'Not specified',
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Contact Information
                _buildSection(
                  title: 'Contact Information',
                  children: [
                    _buildInfoItem(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: email_,
                    ),
                    _buildInfoItem(
                      icon: Icons.phone_outlined,
                      title: 'Phone',
                      value: phone_.isNotEmpty ? phone_ : 'Not provided',
                    ),
                    _buildInfoItem(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      value: '${place_}${post_.isNotEmpty ? ', $post_' : ''}',
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

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[800]),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Color(0xFF6366F1),
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _changeAccountVisibility(bool makePrivate) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString("lid").toString();
    String endpoint = makePrivate ? 'add_private_account' : 'add_public_account';

    final urls = Uri.parse('$url/$endpoint/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          setState(() {
            isPrivate = makePrivate;
          });
          Fluttertoast.showToast(
            msg: makePrivate ? "Account set to Private" : "Account set to Public",
            backgroundColor: Color(0xFF6366F1),
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(msg: 'Operation failed');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void senddata() async {
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
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'];
          String post = jsonDecode(response.body)['post'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String image = sh.getString("img_url").toString() +
              jsonDecode(response.body)['image'];

          setState(() {
            name_ = name;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            place_ = place;
            post_ = post;
            pin_ = pin;
            photo_ = image;
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
}