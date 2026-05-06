// // import 'package:clinicpharma/homenew.dart';
// import 'package:cyber_bullying/home.dart';
// import 'package:easy_search_bar/easy_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// // import 'package:http/http.dart' as http;
// import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
//
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
//       home: const Myotheruserandsendrequestpage(title: 'View Reply'),
//     );
//   }
// }
//
// class Myotheruserandsendrequestpage extends StatefulWidget {
//   const Myotheruserandsendrequestpage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<Myotheruserandsendrequestpage> createState() =>
//       _MyotheruserandsendrequestpageState();
// }
//
// class _MyotheruserandsendrequestpageState
//     extends State<Myotheruserandsendrequestpage> {
//   _MyotheruserandsendrequestpageState() {
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> name_ = <String>[];
//
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
//       String url = '$urls/user_viewothersusers/';
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
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => HomeNewPage(title: 'Home'),
//             ));
//         return false;
//       },
//       child: Scaffold(
//         appBar: EasySearchBar(
//             title: Text('Search'),
//             onSearch: (p0) async {
//               print("hello" + p0);
//               List<String> id = <String>[];
//               List<String> name = <String>[];
//               List<String> image = <String>[];
//               List<String> gender = <String>[];
//
//               try {
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 String urls = sh.getString('url').toString();
//                 String lid = sh.getString('lid').toString();
//                 String url = '$urls/user_viewothersusers_post/';
//
//                 var data = await http.post(Uri.parse(url), body: {
//                   'lid': lid,
//                   'name': p0,
//                 });
//                 var jsondata = json.decode(data.body);
//                 String statuss = jsondata['status'];
//
//                 var arr = jsondata["data"];
//
//                 print(arr.length);
//
//                 for (int i = 0; i < arr.length; i++) {
//                   id.add(arr[i]['id'].toString());
//                   name.add(arr[i]['name']);
//                   image.add(
//                       sh.getString('img_url').toString() + arr[i]['image']);
//                   gender.add(arr[i]['gender']);
//                 }
//
//                 setState(() {
//                   id_ = id;
//                   name_ = name;
//                   image_ = image;
//                   gender_ = gender;
//                 });
//
//                 print(statuss);
//               } catch (e) {
//                 print("Error ------------------- " + e.toString());
//                 //there is error during converting file image to base64 encoding.
//               }
//             }),
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
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.all(5),
//                                   child: CircleAvatar(
//                                     backgroundImage:
//                                         NetworkImage(image_[index]),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(5),
//                                   child: Text(name_[index]),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         ElevatedButton(
//                             onPressed: () async {
//                               SharedPreferences sh =
//                                   await SharedPreferences.getInstance();
//                               String url = sh.getString('url').toString();
//                               String lid = sh.getString('lid').toString();
//
//                               final urls =
//                                   Uri.parse('$url/user_sendfriendrequest/');
//                               try {
//                                 final response = await http.post(urls, body: {
//                                   'lid': lid,
//                                   'uid': id_[index],
//                                 });
//                                 if (response.statusCode == 200) {
//                                   String status =
//                                       jsonDecode(response.body)['status'];
//                                   if (status == 'ok') {
//                                     Fluttertoast.showToast(msg: "Requested");
//
//                                     viewreply();
//                                         // ));
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: 'already requested');
//                                   }
//                                 } else {
//                                   Fluttertoast.showToast(msg: 'Network Error');
//                                 }
//                               } catch (e) {
//                                 Fluttertoast.showToast(msg: e.toString());
//                               }
//                             },
//                             child: Text('Follow'))
//                       ]),
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


import 'package:cyber_bullying/home.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Myotheruserandsendrequestpage extends StatefulWidget {
  const Myotheruserandsendrequestpage({super.key, required this.title});
  final String title;

  @override
  State<Myotheruserandsendrequestpage> createState() =>
      _MyotheruserandsendrequestpageState();
}

class _MyotheruserandsendrequestpageState
    extends State<Myotheruserandsendrequestpage> {
  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> image_ = <String>[];
  List<String> gender_ = <String>[];
  bool isLoading = false;
  bool isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    _loadAllUsers(); // Load all users when page opens
  }

  Future<void> _loadAllUsers() async {
    setState(() {
      isLoading = true;
    });

    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> image = <String>[];
    List<String> gender = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewothersusers/';

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
        isLoading = false;
        isInitialLoad = false;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
      setState(() {
        isLoading = false;
        isInitialLoad = false;
      });
    }
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      // If search is empty, show all users again
      _loadAllUsers();
      return;
    }

    setState(() {
      isLoading = true;
    });

    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> image = <String>[];
    List<String> gender = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewothersusers_post/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid,
        'name': query,
      });
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
        isLoading = false;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: EasySearchBar(
        title: Text(
          'Discover People',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        searchBackgroundColor: Colors.grey[900]!,
        searchCursorColor: Colors.blue,
        searchTextStyle: TextStyle(color: Colors.white),
        onSearch: _searchUsers,
      ),
      body: isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Loading users...',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      )
          : id_.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people, size: 80, color: Colors.grey[600]),
            SizedBox(height: 16),
            Text(
              isInitialLoad ? "Loading users..." : "No users found",
              style: TextStyle(color: Colors.grey[400], fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              isInitialLoad
                  ? "Please wait..."
                  : "Try searching for different names",
              style: TextStyle(color: Colors.grey[500], fontSize: 14),
            ),
          ],
        ),
      )
          : ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // User Avatar
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          image_[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[400],
                                size: 30,
                              ),
                            );
                          },
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
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                gender_[index] == 'Male'
                                    ? Icons.male
                                    : gender_[index] == 'Female'
                                    ? Icons.female
                                    : Icons.transgender,
                                color: Colors.grey[400],
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                gender_[index],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Follow Button
                    Container(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () => _sendFriendRequest(id_[index]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                        ),
                        child: Text(
                          'Follow',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

  void _sendFriendRequest(String userId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/user_sendfriendrequest/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'uid': userId,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(
            msg: "Friend request sent!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Already sent request',
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
  }
}