// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
//
// // import 'package:http/http.dart' as http;
// import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
// import 'sendcomplaint.dart';
//
// void main() {
//   runApp(const ViewReply());
// }
//
// class ViewReply extends StatelessWidget {
//   const ViewReply({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Reply',
//       theme: ThemeData(
//         colorScheme:
//             ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const MyViewfriendrequestandAcceptPage(title: 'View Reply'),
//     );
//   }
// }
//
// class MyViewfriendrequestandAcceptPage extends StatefulWidget {
//   const MyViewfriendrequestandAcceptPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyViewfriendrequestandAcceptPage> createState() =>
//       _MyViewfriendrequestandAcceptPageState();
// }
//
// class _MyViewfriendrequestandAcceptPageState
//     extends State<MyViewfriendrequestandAcceptPage> {
//   _MyViewfriendrequestandAcceptPageState() {
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> name_ = <String>[];
//   List<String> image_ = <String>[];
//   List<String> gender_ = <String>[];
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> name = <String>[];
//     List<String> image = <String>[];
//     List<String> gender = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_viewfriedrequest/';
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
//         image.add(sh.getString('img_url').toString() + arr[i]['image']);
//         gender.add(arr[i]['gender']);
//       }
//
//       setState(() {
//         id_ = id;
//         name_ = name;
//         image_ = image;
//         gender_ = gender;
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           leading: BackButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomeNew()),
//               );
//             },
//           ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text('FriendRequest'),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//                 padding: const EdgeInsets.all(0.7),
//                 child: Card(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: CircleAvatar(
//                                   backgroundImage: NetworkImage(image_[index]),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Container(
//                                     width: 100,
//                                     child: Text(name_[index])),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           ElevatedButton(
//                               onPressed: () async {
//                                 SharedPreferences sh =
//                                     await SharedPreferences.getInstance();
//                                 String url = sh.getString('url').toString();
//                                 String lid = sh.getString('lid').toString();
//
//                                 final urls = Uri.parse('$url/user_followback/');
//                                 try {
//                                   final response = await http.post(urls, body: {
//                                     'lid': lid,
//                                     'uid': id_[index],
//                                   });
//                                   if (response.statusCode == 200) {
//                                     String status =
//                                         jsonDecode(response.body)['status'];
//                                     if (status == 'ok') {
//                                       Fluttertoast.showToast(msg: "Requested");
//
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 MyViewfriendrequestandAcceptPage(
//                                                     title: ''),
//                                           ));
//                                     } else {
//                                       Fluttertoast.showToast(
//                                           msg: 'already requested');
//                                     }
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: 'Network Error');
//                                   }
//                                 } catch (e) {
//                                   Fluttertoast.showToast(msg: e.toString());
//                                 }
//                               },
//                               child: Text('Follow back')),
//                           ElevatedButton(
//                               onPressed: () async {
//                                 SharedPreferences sh =
//                                     await SharedPreferences.getInstance();
//                                 String url = sh.getString('url').toString();
//                                 String lid = sh.getString('lid').toString();
//
//                                 final urls = Uri.parse('$url/user_remove/');
//                                 try {
//                                   final response = await http.post(urls, body: {
//                                     'lid': lid,
//                                     'uid': id_[index],
//                                   });
//                                   if (response.statusCode == 200) {
//                                     String status =
//                                         jsonDecode(response.body)['status'];
//                                     if (status == 'ok') {
//                                       Fluttertoast.showToast(msg: "Removed");
//
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 MyViewfriendrequestandAcceptPage(
//                                                     title: ''),
//                                           ));
//                                     } else {
//                                       Fluttertoast.showToast(
//                                           msg: 'already removed');
//                                     }
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: 'Network Error');
//                                   }
//                                 } catch (e) {
//                                   Fluttertoast.showToast(msg: e.toString());
//                                 }
//                               },
//                               child: Text('Remove')),
//                         ],
//                       ),
//                     ],
//                   ),
//                   elevation: 8,
//                   margin: EdgeInsets.all(10),
//                 ));
//           },
//         ),
//         // floatingActionButton: FloatingActionButton(onPressed: () {
//         //
//         //   Navigator.push(
//         //       context,
//         //       MaterialPageRoute(builder: (context) => MySendComplaint()));
//         //
//         // },
//         //   child: Icon(Icons.plus_one),
//         // ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home.dart';

class MyViewfriendrequestandAcceptPage extends StatefulWidget {
  const MyViewfriendrequestandAcceptPage({super.key, required this.title});
  final String title;

  @override
  State<MyViewfriendrequestandAcceptPage> createState() =>
      _MyViewfriendrequestandAcceptPageState();
}

class _MyViewfriendrequestandAcceptPageState
    extends State<MyViewfriendrequestandAcceptPage> {
  _MyViewfriendrequestandAcceptPageState() {
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> image_ = <String>[];
  List<String> gender_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> image = <String>[];
    List<String> gender = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewfriedrequest/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        image.add(sh.getString('img_url').toString() + arr[i]['image']);
        gender.add(arr[i]['gender']);
      }

      setState(() {
        id_ = id;
        name_ = name;
        image_ = image;
        gender_ = gender;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeNew()),
            );
          },
        ),
        title: Text(
          'Friend Requests',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: id_.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(Icons.people_alt_rounded, color: Colors.white, size: 50),
            ),
            SizedBox(height: 24),
            Text(
              "No Friend Requests",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "When you receive friend requests,\nthey'll appear here",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E1E1E), Color(0xFF252525)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    // User Avatar
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: CircleAvatar(
                          backgroundColor: Color(0xFF1A1A1A),
                          child: CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(image_[index]),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),

                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name_[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                gender_[index] == 'Male'
                                    ? Icons.male_rounded
                                    : gender_[index] == 'Female'
                                    ? Icons.female_rounded
                                    : Icons.transgender_rounded,
                                color: Colors.grey[400],
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                gender_[index],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue.withOpacity(0.5)),
                            ),
                            child: Text(
                              'Wants to be friends',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 12),

                    // Action Buttons
                    Column(
                      children: [
                        // Accept Button
                        Container(
                          width: 120,
                          height: 36,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF6366F1).withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences sh = await SharedPreferences.getInstance();
                              String url = sh.getString('url').toString();
                              String lid = sh.getString('lid').toString();

                              final urls = Uri.parse('$url/user_followback/');
                              try {
                                final response = await http.post(urls, body: {
                                  'lid': lid,
                                  'uid': id_[index],
                                });
                                if (response.statusCode == 200) {
                                  String status = jsonDecode(response.body)['status'];
                                  if (status == 'ok') {
                                    Fluttertoast.showToast(
                                      msg: "Friend request accepted!",
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyViewfriendrequestandAcceptPage(title: ''),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'Already friends',
                                      backgroundColor: Colors.orange,
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
                                  msg: 'Error: ${e.toString()}',
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_rounded, color: Colors.white, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Accept',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        // Remove Button
                        Container(
                          width: 120,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[700]!),
                          ),
                          child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences sh = await SharedPreferences.getInstance();
                              String url = sh.getString('url').toString();
                              String lid = sh.getString('lid').toString();

                              final urls = Uri.parse('$url/user_remove/');
                              try {
                                final response = await http.post(urls, body: {
                                  'lid': lid,
                                  'uid': id_[index],
                                });
                                if (response.statusCode == 200) {
                                  String status = jsonDecode(response.body)['status'];
                                  if (status == 'ok') {
                                    Fluttertoast.showToast(
                                      msg: "Request removed",
                                      backgroundColor: Colors.orange,
                                      textColor: Colors.white,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyViewfriendrequestandAcceptPage(title: ''),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'Already removed',
                                      backgroundColor: Colors.orange,
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
                                  msg: 'Error: ${e.toString()}',
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.close_rounded, color: Colors.grey[400], size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
