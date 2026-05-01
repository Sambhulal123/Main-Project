// import 'package:cyber_bullying/reviewrate.dart';
// import 'package:cyber_bullying/sendcommentreply.dart';
// import 'package:cyber_bullying/uerviewownpost.dart';
// import 'package:cyber_bullying/view_complaintp.dart';
// import 'package:cyber_bullying/view_prof_new.dart';
// import 'package:cyber_bullying/viewapprovedrequest.dart';
// import 'package:cyber_bullying/viewcomment.dart';
// import 'package:cyber_bullying/viewfriendlist.dart';
// import 'package:cyber_bullying/viewfriendrequestandaccept.dart';
// import 'package:cyber_bullying/viewnotification.dart';
// import 'package:cyber_bullying/viewotherpost.dart';
// import 'package:cyber_bullying/viewotheruserandsendrequest.dart';
// import 'package:cyber_bullying/viewpost.dart';
// import 'package:cyber_bullying/viewprofile.dart';
// import 'package:cyber_bullying/viewprofilenew.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'Loginmain.dart';
// import 'addpost.dart';
// import 'changepassword.dart';
// import 'chatfromfriends.dart';
// import 'login.dart';
// import 'sendcomplaint.dart';
//
// import 'viewreply.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const HomeNew());
// }
//
// class HomeNew extends StatelessWidget {
//   const HomeNew({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Home',
//       theme: ThemeData(
//         colorScheme:
//             ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const HomeNewPage(title: 'Home'),
//     );
//   }
// }
//
// class HomeNewPage extends StatefulWidget {
//   const HomeNewPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<HomeNewPage> createState() => _HomeNewPageState();
// }
//
// class _HomeNewPageState extends State<HomeNewPage> {
//   _HomeNewPageState() {
//     viewreply();
//     _send_data2();
//     a();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> name_ = <String>[];
//   List<String> loc_ = <String>[];
//   List<String> image_ = <String>[];
//   List<String> post_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> cap_ = <String>[];
//   List<String> liked_ = <String>[];
//   List<String> likes_ = <String>[];
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> name = <String>[];
//     List<String> loc = <String>[];
//     List<String> image = <String>[];
//     List<String> post = <String>[];
//     List<String> date = <String>[];
//     List<String> liked = <String>[];
//     List<String> likes = <String>[];
//     List<String> cap = <String>[];
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_viewotherspost/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         name.add(arr[i]['name']);
//         loc.add(arr[i]['loc']);
//         image.add(sh.getString('img_url').toString() + arr[i]['image']);
//         post.add(sh.getString('img_url').toString() + arr[i]['post']);
//         date.add(arr[i]['date']);
//         cap.add(arr[i]['cap']);
//         liked.add(arr[i]['liked']);
//         likes.add(arr[i]['likes']);
//       }
//
//       setState(() {
//         id_ = id;
//         name_ = name;
//         loc_ = loc;
//         image_ = image;
//         post_ = post;
//         cap_ = cap;
//         date_ = date;
//         liked_ = liked;
//         likes_ = likes;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   String uname_ = "";
//   String email_ = "";
//   String uphoto_ = "";
//
//   a() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String name = sh.getString('name').toString();
//     String email = sh.getString('email').toString();
//     String photo = sh.getString('photo').toString();
//
//     setState(() {
//       uname_ = name;
//       email_ = email;
//       uphoto_ = photo;
//     });
//   }
//
//   TextEditingController unameController = new TextEditingController();
//   TextEditingController passController = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 18, 82, 98),
//           title: Text(
//             "Home",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child:
//                 Card(
//                   elevation: 10,
//                   child: Column(
//                     children: [
//                       ListTile(
//                         title: Text(name_[index]),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(cap_[index]),
//                             Text(loc_[index]),
//                           ],
//                         ),
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(image_[index]),
//                         ),
//                         trailing:   Text(date_[index]),
//                       ),
//                       Image.network(
//                         post_[index],
//                         height: MediaQuery.of(context).size.height * 0.4, // Adjust as needed
//                         width: double.infinity,
//                         fit: BoxFit.fill,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           IconButton(
//                             icon: liked_[index] == 'yes'
//                                 ? Icon(
//                               Icons.thumb_up,
//                               color: Colors.blue,
//                             )
//                                 : Icon(
//                               Icons.thumb_up_alt_outlined,
//                             ),
//                             onPressed: () async {
//                               SharedPreferences sh =
//                               await SharedPreferences.getInstance();
//                               String url = sh.getString('url').toString();
//                               String lid = sh.getString('lid').toString();
//
//                               final urls = Uri.parse('$url/likes/');
//                               try {
//                                 final response =
//                                 await http.post(urls, body: {
//                                   'lid': lid,
//                                   'pid': id_[index],
//                                 });
//                                 if (response.statusCode == 200) {
//                                   String status =
//                                   jsonDecode(response.body)['status'];
//                                   if (status == 'ok') {
//                                     viewreply();
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: 'Network Error');
//                                   }
//                                 }
//                               } catch (e) {
//                                 Fluttertoast.showToast(msg: e.toString());
//                               }
//                             },
//                           ),
//                           Text(likes_[index]),
//                           IconButton(
//                             icon: Icon(
//                               Icons.comment,
//                             ),
//                             onPressed: () async {
//                               SharedPreferences sh =
//                               await SharedPreferences.getInstance();
//                               sh.setString("pid", id_[index]);
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         MyViewCommetPage(
//                                             title: 'comments'),
//                                   ));
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )
//
//             );
//               // Padding(
//               //   padding: const EdgeInsets.all(0.7),
//               //   child: Card(
//               //     child: Column(
//               //       mainAxisAlignment: MainAxisAlignment.start,
//               //       children: [
//               //         Column(
//               //           children: [
//               //             Row(
//               //               children: [
//               //                 Padding(
//               //                   padding: EdgeInsets.all(4),
//               //                   child: CircleAvatar(
//               //                     backgroundImage: NetworkImage(image_[index]),
//               //                   ),
//               //                 ),
//               //                 Column(
//               //                   children: [
//               //                     Padding(
//               //                       padding: EdgeInsets.all(0),
//               //                       child: Text(name_[index]),
//               //                     ),
//               //                     Padding(
//               //                       padding: EdgeInsets.all(0),
//               //                       child: Text(date_[index]),
//               //                     ),
//               //                   ],
//               //                 ),
//               //               ],
//               //             ),
//               //             Padding(
//               //               padding: EdgeInsets.all(5),
//               //               child: Image.network(
//               //                 post_[index],
//               //                 errorBuilder: (context, error, stackTrace) =>
//               //                     Image.asset('assets/post.jpg'),
//               //               ),
//               //             ),
//               //             Padding(
//               //               padding: EdgeInsets.all(5),
//               //               child: Row(
//               //                 children: [
//               //                   IconButton(
//               //                     icon: liked_[index] == 'yes'
//               //                         ? Icon(
//               //                             Icons.thumb_up,
//               //                             color: Colors.blue,
//               //                           )
//               //                         : Icon(
//               //                             Icons.thumb_up_alt_outlined,
//               //                           ),
//               //                     onPressed: () async {
//               //                       SharedPreferences sh =
//               //                           await SharedPreferences.getInstance();
//               //                       String url = sh.getString('url').toString();
//               //                       String lid = sh.getString('lid').toString();
//               //
//               //                       final urls = Uri.parse('$url/likes/');
//               //                       try {
//               //                         final response =
//               //                             await http.post(urls, body: {
//               //                           'lid': lid,
//               //                           'pid': id_[index],
//               //                         });
//               //                         if (response.statusCode == 200) {
//               //                           String status =
//               //                               jsonDecode(response.body)['status'];
//               //                           if (status == 'ok') {
//               //                             viewreply();
//               //                           } else {
//               //                             Fluttertoast.showToast(
//               //                                 msg: 'Network Error');
//               //                           }
//               //                         }
//               //                       } catch (e) {
//               //                         Fluttertoast.showToast(msg: e.toString());
//               //                       }
//               //                     },
//               //                   ),
//               //                   Text(likes_[index]),
//               //                   IconButton(
//               //                     icon: Icon(
//               //                       Icons.comment,
//               //                     ),
//               //                     onPressed: () async {
//               //                       SharedPreferences sh =
//               //                           await SharedPreferences.getInstance();
//               //                       sh.setString("pid", id_[index]);
//               //                       Navigator.push(
//               //                           context,
//               //                           MaterialPageRoute(
//               //                             builder: (context) =>
//               //                                 MyViewCommetPage(
//               //                                     title: 'comments'),
//               //                           ));
//               //                     },
//               //                   ),
//               //                 ],
//               //               ),
//               //             ),
//               //           ],
//               //         ),
//               //       ],
//               //     ),
//               //     elevation: 8,
//               //     margin: EdgeInsets.all(10),
//               //   ));
//           },
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 18, 82, 98),
//                 ),
//                 child: Column(children: [
//
//                   CircleAvatar(
//                       radius: 29, backgroundImage: NetworkImage(pphoto_)),
//                   Text(pname_, style: TextStyle(color: Colors.white)),
//                   Text(email_, style: TextStyle(color: Colors.white)),
//                 ]),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: const Text('Home'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomeNewPage(title: 'Home',),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.contact_page_outlined),
//                 title: const Text('  Profile '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => userProfile_new1(
//                           title: 'Profile',
//                         ),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.password),
//                 title: const Text(' change password '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Mychangepasswordpage(
//                           title: "Password",
//                         ),
//                       ));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.post_add),
//                 title: const Text('My Post'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => myviewOwnPostPage(),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.people_alt_outlined),
//                 title: const Text('Users'),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Myotheruserandsendrequestpage(
//                           title: "Request",
//                         ),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.image),
//                 title: const Text('Others post'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Viewotherspost(
//                           title: " Other Post",
//                         ),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.add_alert),
//                 title: const Text('Notification'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Viewnotification(
//                           title: "Notification",
//                         ),
//                       ));
//                 },
//               ),
//
//               // ListTile(
//               //   leading: Icon(Icons.medical_services_outlined),
//               //   title: const Text(' View approved request '),
//               //   onTap: () {
//               //     Navigator.pop(context);
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => MyApprovedrequestPage(
//               //             title: "Test Details",
//               //           ),
//               //         ));
//               //   },
//               // ),
//               ListTile(
//                 leading: Icon(Icons.request_page),
//                 title: const Text('Friend Request'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MyViewfriendrequestandAcceptPage(
//                           title: "Friend Request",
//                         ),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.list_alt_outlined),
//                 title: const Text('View friend list'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MyFriendlistpage(
//                           title: "Friends",
//                         ),
//                       ));
//                 },
//               ),
//               // ListTile(
//               //   leading: Icon(Icons.shopping_cart_sharp),
//               //   title: const Text(' View comment and reply'),
//               //   onTap: () {
//               //     Navigator.pop(context);
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => MysendcommentandreplyPage(
//               //             title: '',
//               //           ),
//               //         ));
//               //   },
//               // ),
//               // ListTile(
//               //   leading: Icon(Icons.feed_outlined),
//               //   title: const Text('view comment '),
//               //   onTap: () {
//               //     Navigator.pop(context);
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => Viewreplypage(
//               //             title: "View Complaint",
//               //           ),
//               //         ));
//               //   },
//               // ),
//               // ListTile(
//               //   leading: Icon(Icons.change_circle),
//               //   title: const Text(' send complaint  '),
//               //   onTap: () {
//               //     Navigator.pop(context);
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => UserSendComplaint(
//               //             title: "Change Password",
//               //           ),
//               //         ));
//               //   },
//               // ),
//               ListTile(
//                 leading: Icon(Icons.comment),
//                 title: const Text('complaint'),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => view_complaint(
//                           title: 'Complaints',
//                         ),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: const Text('Review And Rating'),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MyReviewPageIns(
//                           title: 'Review',
//                         ),
//                       ));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: const Text('Logout'),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginNewFull(),
//                       ));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _send_data() async {
//     String uname = unameController.text;
//     String password = passController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/myapp/user_loginpost/');
//     try {
//       final response = await http.post(urls, body: {
//         'name': uname,
//         'password': password,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           String lid = jsonDecode(response.body)['lid'];
//           sh.setString("lid", lid);
//           // Navigator.push(context, MaterialPageRoute(
//           //   builder: (context) => MyHomePage(title: "Home"),));
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
//   String pname_ = "";
//   String dob_ = "";
//   String gender_ = "";
//   String pemail_ = "";
//   String phone_ = "";
//   String place_ = "";
//   String ppost_ = "";
//   String pin_ = "";
//   String pphoto_ = "";
//
//   void _send_data2() async {
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
//           String pname = jsonDecode(response.body)['name'];
//           String dob = jsonDecode(response.body)['dob'].toString();
//           String gender = jsonDecode(response.body)['gender'];
//           String email = jsonDecode(response.body)['email'];
//           String phone = jsonDecode(response.body)['phone'].toString();
//           String place = jsonDecode(response.body)['place'];
//           String ppost = jsonDecode(response.body)['post'];
//           String pin = jsonDecode(response.body)['pin'].toString();
//           String pimage = sh.getString("img_url").toString() +
//               jsonDecode(response.body)['image'];
//
//           setState(() {
//             pname_ = pname;
//             dob_ = dob;
//             gender_ = gender;
//             email_ = email;
//             phone_ = phone;
//             place_ = place;
//             ppost_ = ppost;
//             pin_ = pin;
//             pphoto_ = pimage;
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



import 'package:cyber_bullying/reviewrate.dart';
import 'package:cyber_bullying/sendcommentreply.dart';
import 'package:cyber_bullying/uerviewownpost.dart';
import 'package:cyber_bullying/view_complaintp.dart';
import 'package:cyber_bullying/view_prof_new.dart';
import 'package:cyber_bullying/viewapprovedrequest.dart';
import 'package:cyber_bullying/viewcomment.dart';
import 'package:cyber_bullying/viewfriendlist.dart';
import 'package:cyber_bullying/viewfriendrequestandaccept.dart';
import 'package:cyber_bullying/viewnotification.dart';
import 'package:cyber_bullying/viewotherpost.dart';
import 'package:cyber_bullying/viewotheruserandsendrequest.dart';
import 'package:cyber_bullying/viewpost.dart';
import 'package:cyber_bullying/viewprofile.dart';
import 'package:cyber_bullying/viewprofilenew.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Loginmain.dart';
import 'addpost.dart';
import 'changepassword.dart';
import 'chatfromfriends.dart';
import 'login.dart';
import 'sendcomplaint.dart';

import 'viewreply.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF00D4FF),
          secondary: Color(0xFF00D4FF),
          surface: Color(0xFF121212),
          background: Color(0xFF121212),
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFF121212),
        cardTheme: CardTheme(
          color: Color(0xFF1E1E1E),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const HomeNewPage(title: 'Home'),
    );
  }
}

class HomeNewPage extends StatefulWidget {
  const HomeNewPage({super.key, required this.title});

  final String title;

  @override
  State<HomeNewPage> createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {
  _HomeNewPageState() {
    viewreply();
    _send_data2();
    a();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> loc_ = <String>[];
  List<String> image_ = <String>[];
  List<String> post_ = <String>[];
  List<String> date_ = <String>[];
  List<String> cap_ = <String>[];
  List<String> liked_ = <String>[];
  List<String> likes_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> loc = <String>[];
    List<String> image = <String>[];
    List<String> post = <String>[];
    List<String> date = <String>[];
    List<String> liked = <String>[];
    List<String> likes = <String>[];
    List<String> cap = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewotherspost/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        loc.add(arr[i]['loc']);
        image.add(sh.getString('img_url').toString() + arr[i]['image']);
        post.add(sh.getString('img_url').toString() + arr[i]['post']);
        date.add(arr[i]['date']);
        cap.add(arr[i]['cap']);
        liked.add(arr[i]['liked']);
        likes.add(arr[i]['likes']);
      }

      setState(() {
        id_ = id;
        name_ = name;
        loc_ = loc;
        image_ = image;
        post_ = post;
        cap_ = cap;
        date_ = date;
        liked_ = liked;
        likes_ = likes;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  String uname_ = "";
  String email_ = "";
  String uphoto_ = "";

  a() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String name = sh.getString('name').toString();
    String email = sh.getString('email').toString();
    String photo = sh.getString('photo').toString();

    setState(() {
      uname_ = name;
      email_ = email;
      uphoto_ = photo;
    });
  }

  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF1A1A1A),
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh, color: Color(0xFF00D4FF)),
              onPressed: () {
                viewreply();
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF121212),
                Color(0xFF1A1A1A),
              ],
            ),
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1E1E1E),
                        Color(0xFF252525),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        // Header Section
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF252525),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF00D4FF),
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    image_[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Icon(Icons.person, color: Colors.grey),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name_[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      loc_[index],
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFF00D4FF).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF00D4FF).withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  date_[index],
                                  style: TextStyle(
                                    color: Color(0xFF00D4FF),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Caption
                        if (cap_[index].isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF1A1A1A),
                            ),
                            child: Text(
                              cap_[index],
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                              ),
                            ),
                          ),

                        // Post Image
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: ClipRRect(
                            child: Image.network(
                              post_[index],
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.35,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                      color: Color(0xFF00D4FF),
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.35,
                                    color: Colors.grey[800],
                                    child: Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey[600],
                                        size: 50,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),

                        // Actions Section
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFF252525),
                          ),
                          child: Row(
                            children: [
                              // Like Button
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFF1A1A1A),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: liked_[index] == 'yes'
                                          ? Icon(
                                        Icons.thumb_up,
                                        color: Color(0xFF00D4FF),
                                        size: 22,
                                      )
                                          : Icon(
                                        Icons.thumb_up_alt_outlined,
                                        color: Colors.grey[400],
                                        size: 22,
                                      ),
                                      onPressed: () async {
                                        SharedPreferences sh =
                                        await SharedPreferences.getInstance();
                                        String url = sh.getString('url').toString();
                                        String lid = sh.getString('lid').toString();

                                        final urls = Uri.parse('$url/likes/');
                                        try {
                                          final response =
                                          await http.post(urls, body: {
                                            'lid': lid,
                                            'pid': id_[index],
                                          });
                                          if (response.statusCode == 200) {
                                            String status =
                                            jsonDecode(response.body)['status'];
                                            if (status == 'ok') {
                                              viewreply();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: 'Network Error');
                                            }
                                          }
                                        } catch (e) {
                                          Fluttertoast.showToast(msg: e.toString());
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Text(
                                        likes_[index],
                                        style: TextStyle(
                                          color: Colors.grey[300],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 12),

                              // Comment Button
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFF1A1A1A),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.comment,
                                    color: Colors.grey[400],
                                    size: 22,
                                  ),
                                  onPressed: () async {
                                    SharedPreferences sh =
                                    await SharedPreferences.getInstance();
                                    sh.setString("pid", id_[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyViewCommetPage(title: 'comments'),
                                        ));
                                  },
                                ),
                              ),

                              Spacer(),

                              // Share Button
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFF1A1A1A),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.grey[400],
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    // Add share functionality here
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        drawer: Drawer(
          backgroundColor: Color(0xFF1A1A1A),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer Header
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF00D4FF),
                      Color(0xFF0099CC),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          pphoto_,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.person, color: Colors.white, size: 40),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      pname_,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      email_,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Items
              _buildDrawerItem(
                icon: Icons.home_filled,
                title: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeNewPage(title: 'Home'),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => userProfile_new1(title: 'Profile'),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.lock,
                title: 'Change Password',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mychangepasswordpage(title: "Password"),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.post_add,
                title: 'My Post',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => myviewOwnPostPage(),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.people,
                title: 'Users',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Myotheruserandsendrequestpage(title: "Request"),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.image,
                title: 'Others Post',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Viewotherspost(title: "Other Post"),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.notifications,
                title: 'Notification',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Viewnotification(title: "Notification"),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.person_add,
                title: 'Friend Request',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyViewfriendrequestandAcceptPage(title: "Friend Request"),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.list,
                title: 'Friend List',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyFriendlistpage(title: "Friends"),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.report,
                title: 'Complaint',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => view_complaint(title: 'Complaints'),
                    ),
                  );
                },
              ),
              _buildDrawerItem(
                icon: Icons.star,
                title: 'Review & Rating',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyReviewPageIns(title: 'Review'),
                    ),
                  );
                },
              ),
              Divider(color: Colors.grey[700]),
              _buildDrawerItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginNewFull(),
                    ),
                  );
                },
                isLogout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isLogout ? Colors.red.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : Color(0xFF00D4FF),
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isLogout ? Colors.red : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _send_data() async {
    String uname = unameController.text;
    String password = passController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/myapp/user_loginpost/');
    try {
      final response = await http.post(urls, body: {
        'name': uname,
        'password': password,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'];
          sh.setString("lid", lid);
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

  String pname_ = "";
  String dob_ = "";
  String gender_ = "";
  String pemail_ = "";
  String phone_ = "";
  String place_ = "";
  String ppost_ = "";
  String pin_ = "";
  String pphoto_ = "";

  void _send_data2() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_viewprofile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String pname = jsonDecode(response.body)['name'];
          String dob = jsonDecode(response.body)['dob'].toString();
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'];
          String ppost = jsonDecode(response.body)['post'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String pimage = sh.getString("img_url").toString() +
              jsonDecode(response.body)['image'];

          setState(() {
            pname_ = pname;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            place_ = place;
            ppost_ = ppost;
            pin_ = pin;
            pphoto_ = pimage;
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