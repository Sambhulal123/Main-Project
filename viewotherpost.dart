// // import 'package:cyber_bullying/addcomments.dart';
// // import 'package:cyber_bullying/viewcomment.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:fluttertoast/fluttertoast.dart';
// //
// // // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'home.dart';
// // import 'sendcomplaint.dart';
// //
// // void main() {
// //   runApp(const ViewReply());
// // }
// //
// // class ViewReply extends StatelessWidget {
// //   const ViewReply({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'View Reply',
// //       theme: ThemeData(
// //         colorScheme:
// //             ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
// //         useMaterial3: true,
// //       ),
// //       home: const Viewotherspost(title: 'View Reply'),
// //     );
// //   }
// // }
// //
// // class Viewotherspost extends StatefulWidget {
// //   const Viewotherspost({super.key, required this.title});
// //
// //   final String title;
// //
// //   @override
// //   State<Viewotherspost> createState() => MyViewfriendlistPage();
// // }
// //
// // class MyViewfriendlistPage extends State<Viewotherspost> {
// //   MyViewfriendlistPage() {
// //     viewreply();
// //   }
// //
// //   List<String> id_ = <String>[];
// //   List<String> name_ = <String>[];
// //
// //   List<String> image_ = <String>[];
// //   List<String> post_ = <String>[];
// //   List<String> date_ = <String>[];
// //   List<String> liked_ = <String>[];
// //
// //   List<String> likes_ = <String>[];
// //
// //   Future<void> viewreply() async {
// //     List<String> id = <String>[];
// //     List<String> name = <String>[];
// //     List<String> image = <String>[];
// //     List<String> post = <String>[];
// //     List<String> date = <String>[];
// //     List<String> liked = <String>[];
// //     List<String> likes = <String>[];
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/user_viewotherpost/';
// //
// //       var data = await http.post(Uri.parse(url), body: {'lid': lid});
// //       var jsondata = json.decode(data.body);
// //       String statuss = jsondata['status'];
// //
// //       var arr = jsondata["data"];
// //
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         name.add(arr[i]['name'].toString());
// //         image.add(sh.getString('img_url').toString() + arr[i]['image']);
// //         post.add(sh.getString('img_url').toString() + arr[i]['post']);
// //         date.add(arr[i]['date'].toString());
// //         liked.add(arr[i]['liked'].toString());
// //         likes.add(arr[i]['likes'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         name_ = name;
// //         image_ = image;
// //         post_ = post;
// //         date_ = date;
// //         liked_ = liked;
// //         likes_ = likes;
// //       });
// //
// //       print(statuss);
// //     } catch (e) {
// //       print("Error ------------------- " + e.toString());
// //       //there is error during converting file image to base64 encoding.
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         return true;
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           leading: BackButton(
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home',)),
// //               );
// //             },
// //           ),
// //           backgroundColor: Theme.of(context).colorScheme.primary,
// //           title: Text('otherPost'),
// //         ),
// //         body: ListView.builder(
// //           physics: BouncingScrollPhysics(),
// //           // padding: EdgeInsets.all(5.0),
// //           // shrinkWrap: true,
// //           itemCount: id_.length,
// //           itemBuilder: (BuildContext context, int index) {
// //             return Padding(
// //                 padding: const EdgeInsets.all(0.7),
// //                 child: Card(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     children: [
// //                       Column(
// //                         children: [
// //                           Row(
// //                             children: [
// //                               Padding(
// //                                 padding: EdgeInsets.all(4),
// //                                 child: CircleAvatar(
// //                                   backgroundImage: NetworkImage(image_[index]),
// //                                 ),
// //                               ),
// //                               Column(
// //                                 children: [
// //                                   Padding(
// //                                     padding: EdgeInsets.all(0),
// //                                     child: Text(name_[index]),
// //                                   ),
// //                                   Padding(
// //                                     padding: EdgeInsets.all(0),
// //                                     child: Text(date_[index]),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                           Padding(
// //                             padding: EdgeInsets.all(5),
// //                             child: Image.network(
// //                               post_[index],
// //                               errorBuilder: (context, error, stackTrace) =>
// //                                   Image.asset('assets/post.jpg'),
// //                             ),
// //                           ),
// //                           Padding(
// //                             padding: EdgeInsets.all(5),
// //                             child: Row(
// //                               children: [
// //                                 Container(
// //                                   child: Row(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     children: [
// //                                       IconButton(
// //                                         icon: liked_[index] == 'yes'
// //                                             ? Icon(
// //                                                 Icons.thumb_up,
// //                                                 color: Colors.blue,
// //                                               )
// //                                             : Icon(
// //                                                 Icons.thumb_up_alt_outlined,
// //                                               ),
// //                                         onPressed: () async {
// //                                           SharedPreferences sh =
// //                                               await SharedPreferences
// //                                                   .getInstance();
// //                                           String url =
// //                                               sh.getString('url').toString();
// //                                           String lid =
// //                                               sh.getString('lid').toString();
// //
// //                                           final urls = Uri.parse('$url/likes/');
// //                                           try {
// //                                             final response =
// //                                                 await http.post(urls, body: {
// //                                               'lid': lid,
// //                                               'pid': id_[index],
// //                                             });
// //                                             if (response.statusCode == 200) {
// //                                               String status = jsonDecode(
// //                                                   response.body)['status'];
// //                                               if (status == 'ok') {
// //                                                 viewreply();
// //                                               } else {
// //                                                 Fluttertoast.showToast(
// //                                                     msg: 'Network Error');
// //                                               }
// //                                             }
// //                                           } catch (e) {
// //                                             Fluttertoast.showToast(
// //                                                 msg: e.toString());
// //                                           }
// //                                         },
// //                                       ),
// //                                       Text(likes_[index]),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 IconButton(
// //                                   icon: Icon(
// //                                     Icons.comment,
// //                                   ),
// //                                   onPressed: () async {
// //                                     SharedPreferences sh =
// //                                         await SharedPreferences.getInstance();
// //                                     sh.setString("pid", id_[index]);
// //                                     Navigator.push(
// //                                         context,
// //                                         MaterialPageRoute(
// //                                           builder: (context) =>
// //                                               MyViewCommetPage(
// //                                                   title: 'comments'),
// //                                         ));
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                   elevation: 8,
// //                   margin: EdgeInsets.all(10),
// //                 ));
// //           },
// //         ),
// //         // floatingActionButton: FloatingActionButton(onPressed: () {
// //         //
// //         //   Navigator.push(
// //         //       context,
// //         //       MaterialPageRoute(builder: (context) => MySendComplaint()));
// //         //
// //         // },
// //         //   child: Icon(Icons.plus_one),
// //         // ),
// //       ),
// //     );
// //   }
// // }
// //
// //
//
//
// import 'package:cyber_bullying/viewcomment.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'home.dart';
//
// class Viewotherspost extends StatefulWidget {
//   const Viewotherspost({super.key, required this.title});
//   final String title;
//
//   @override
//   State<Viewotherspost> createState() => _ViewotherspostState();
// }
//
// class _ViewotherspostState extends State<Viewotherspost> {
//   _ViewotherspostState() {
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> name_ = <String>[];
//   List<String> image_ = <String>[];
//   List<String> post_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> liked_ = <String>[];
//   List<String> likes_ = <String>[];
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> name = <String>[];
//     List<String> image = <String>[];
//     List<String> post = <String>[];
//     List<String> date = <String>[];
//     List<String> liked = <String>[];
//     List<String> likes = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_viewotherpost/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         name.add(arr[i]['name'].toString());
//         image.add(sh.getString('img_url').toString() + arr[i]['image']);
//         post.add(sh.getString('img_url').toString() + arr[i]['post']);
//         date.add(arr[i]['date'].toString());
//         liked.add(arr[i]['liked'].toString());
//         likes.add(arr[i]['likes'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         name_ = name;
//         image_ = image;
//         post_ = post;
//         date_ = date;
//         liked_ = liked;
//         likes_ = likes;
//       });
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home')),
//             );
//           },
//         ),
//         title: Text(
//           'Discover Posts',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[900],
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   // Header
//                   Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           radius: 20,
//                           backgroundImage: NetworkImage(image_[index]),
//                           backgroundColor: Colors.grey[800],
//                         ),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 name_[index],
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               SizedBox(height: 2),
//                               Text(
//                                 date_[index],
//                                 style: TextStyle(
//                                   color: Colors.grey[400],
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Post Image
//                   Container(
//                     width: double.infinity,
//                     child: Image.network(
//                       post_[index],
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                           Container(
//                             height: 200,
//                             color: Colors.grey[800],
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(Icons.error, color: Colors.grey[600], size: 40),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   'Failed to load image',
//                                   style: TextStyle(color: Colors.grey[500]),
//                                 ),
//                               ],
//                             ),
//                           ),
//                     ),
//                   ),
//
//                   // Actions
//                   Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         // Like Button
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[800],
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 icon: liked_[index] == 'yes'
//                                     ? Icon(Icons.thumb_up, color: Colors.blue, size: 22)
//                                     : Icon(Icons.thumb_up_alt_outlined, color: Colors.grey[400], size: 22),
//                                 onPressed: () async {
//                                   SharedPreferences sh = await SharedPreferences.getInstance();
//                                   String url = sh.getString('url').toString();
//                                   String lid = sh.getString('lid').toString();
//
//                                   final urls = Uri.parse('$url/likes/');
//                                   try {
//                                     final response = await http.post(urls, body: {
//                                       'lid': lid,
//                                       'pid': id_[index],
//                                     });
//                                     if (response.statusCode == 200) {
//                                       String status = jsonDecode(response.body)['status'];
//                                       if (status == 'ok') {
//                                         viewreply();
//                                       } else {
//                                         Fluttertoast.showToast(msg: 'Network Error');
//                                       }
//                                     }
//                                   } catch (e) {
//                                     Fluttertoast.showToast(msg: e.toString());
//                                   }
//                                 },
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(right: 12),
//                                 child: Text(
//                                   likes_[index],
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         SizedBox(width: 12),
//
//                         // Comment Button
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[800],
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: IconButton(
//                             icon: Icon(Icons.comment, color: Colors.grey[400], size: 22),
//                             onPressed: () async {
//                               SharedPreferences sh = await SharedPreferences.getInstance();
//                               sh.setString("pid", id_[index]);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => MyViewCommetPage(title: 'comments'),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:cyber_bullying/viewcomment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home.dart';

class Viewotherspost extends StatefulWidget {
  const Viewotherspost({super.key, required this.title});
  final String title;

  @override
  State<Viewotherspost> createState() => _ViewotherspostState();
}

class _ViewotherspostState extends State<Viewotherspost> {
  _ViewotherspostState() {
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> image_ = <String>[];
  List<String> post_ = <String>[];
  List<String> date_ = <String>[];
  List<String> liked_ = <String>[];
  List<String> likes_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> image = <String>[];
    List<String> post = <String>[];
    List<String> date = <String>[];
    List<String> liked = <String>[];
    List<String> likes = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewotherpost/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name'].toString());
        image.add(sh.getString('img_url').toString() + arr[i]['image']);
        post.add(sh.getString('img_url').toString() + arr[i]['post']);
        date.add(arr[i]['date'].toString());
        liked.add(arr[i]['liked'].toString());
        likes.add(arr[i]['likes'].toString());
      }

      setState(() {
        id_ = id;
        name_ = name;
        image_ = image;
        post_ = post;
        date_ = date;
        liked_ = liked;
        likes_ = likes;
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
              MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home')),
            );
          },
        ),
        title: Text(
          'Discover',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
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
              child: Icon(Icons.photo_library_rounded, color: Colors.white, size: 50),
            ),
            SizedBox(height: 24),
            Text(
              "No Posts Yet",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "When people share posts, they'll appear here",
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
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
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
                                radius: 18,
                                backgroundImage: NetworkImage(image_[index]),
                                backgroundColor: Colors.transparent,
                              ),
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
                              SizedBox(height: 2),
                              Text(
                                date_[index],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.more_horiz, color: Colors.grey[400], size: 20),
                        ),
                      ],
                    ),
                  ),

                  // Post Image
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: ClipRRect(
                      child: Image.network(
                        post_[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(0xFF2A2A2A),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.broken_image_rounded, color: Colors.grey[600], size: 50),
                                SizedBox(height: 12),
                                Text(
                                  'Image not available',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Color(0xFF2A2A2A),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Actions
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // Like Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: liked_[index] == 'yes'
                                    ? Icon(Icons.favorite_rounded, color: Colors.red, size: 24)
                                    : Icon(Icons.favorite_border_rounded, color: Colors.grey[400], size: 24),
                                onPressed: () async {
                                  SharedPreferences sh = await SharedPreferences.getInstance();
                                  String url = sh.getString('url').toString();
                                  String lid = sh.getString('lid').toString();

                                  final urls = Uri.parse('$url/likes/');
                                  try {
                                    final response = await http.post(urls, body: {
                                      'lid': lid,
                                      'pid': id_[index],
                                    });
                                    if (response.statusCode == 200) {
                                      String status = jsonDecode(response.body)['status'];
                                      if (status == 'ok') {
                                        viewreply();
                                      } else {
                                        Fluttertoast.showToast(msg: 'Network Error');
                                      }
                                    }
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                },
                              ),
                              SizedBox(width: 4),
                              Text(
                                likes_[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                        ),

                        SizedBox(width: 12),

                        // Comment Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.chat_bubble_outline_rounded, color: Colors.grey[400], size: 22),
                            onPressed: () async {
                              SharedPreferences sh = await SharedPreferences.getInstance();
                              sh.setString("pid", id_[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyViewCommetPage(title: 'comments'),
                                ),
                              );
                            },
                          ),
                        ),

                        Spacer(),

                        // Share Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.share_rounded, color: Colors.grey[400], size: 22),
                            onPressed: () {
                              // Add share functionality
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}