// import 'package:cyber_bullying/Loginmain.dart';
// import 'package:cyber_bullying/addcomments.dart';
// import 'package:cyber_bullying/sendreply.dart';
// import 'package:flutter/material.dart';
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
//       home: const MyViewCommetPage(title: 'View Reply'),
//     );
//   }
// }
//
// class MyViewCommetPage extends StatefulWidget {
//   const MyViewCommetPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyViewCommetPage> createState() => _MyViewCommetPageState();
// }
//
// class _MyViewCommetPageState extends State<MyViewCommetPage> {
//   _MyViewCommetPageState() {
//     viewreply();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> userid_ = <String>[];
//
//   List<String> uploadpost_ = <String>[];
//   List<String> comment_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> userphoto_ = <String>[];
//
//   Future<void> viewreply() async {
//     List<String> id = <String>[];
//     List<String> userid = <String>[];
//     List<String> uploadpost = <String>[];
//     List<String> comment = <String>[];
//     List<String> date = <String>[];
//     List<String> userphoto = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String pid = sh.getString('pid').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_viewcommentsandreply/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'pid': pid,
//         'lid': lid,
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         userid.add(arr[i]['userid']);
//         uploadpost.add(arr[i]['uploadpost'].toString());
//         comment.add(arr[i]['comment']);
//         date.add(arr[i]['date']);
//         userphoto.add(sh.getString('img_url').toString() + arr[i]['userphoto']);
//       }
//
//       setState(() {
//         id_ = id;
//         userid_ = userid;
//         uploadpost_ = uploadpost;
//         comment_ = comment;
//         date_ = date;
//         userphoto_ = userphoto;
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
//                 MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home',)),
//               );
//             },
//           ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text('comment'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(bottom: 60.0),
//           child: ListView.builder(
//             physics: BouncingScrollPhysics(),
//             // padding: EdgeInsets.all(5.0),
//             // shrinkWrap: true,
//             itemCount: id_.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                 onLongPress: () {
//                   print("long press" + index.toString());
//                 },
//                 title: Card(
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: CircleAvatar(
//                               backgroundImage: NetworkImage(userphoto_[index]),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: Text(userid_[index]),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: Text(date_[index]),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(5),
//                             child: Container(
//                                 width: 300, child: Text(comment_[index])),
//                           ),
//                         ],
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.start,
//                       //   children: [
//                       //     Padding(
//                       //       padding: EdgeInsets.all(5),
//                       //       child: ElevatedButton(
//                       //           onPressed: () async {
//                       //             SharedPreferences sh =
//                       //                 await SharedPreferences.getInstance();
//                       //             sh.setString("cid", id_[index]);
//                       //             // sh.setString("pid", id_[index]);
//                       //             Navigator.push(
//                       //                 context,
//                       //                 MaterialPageRoute(
//                       //                   builder: (context) =>
//                       //                       UserSendReplyPage(title: 'replys'),
//                       //                   // MyCommentPage(title: 'Reply'),
//                       //                 ));
//                       //           },
//                       //           child: Text("Reply")),
//                       //     ),
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                   elevation: 8,
//                   margin: EdgeInsets.all(10),
//                 ),
//               );
//             },
//           ),
//         ),
//         floatingActionButton: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.only(
//                 left: 20,
//               ),
//               width: MediaQuery.of(context).size.width - 50,
//               child: TextField(
//                 controller: commentscontroller,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(), hintText: 'comments'),
//               ),
//             ),
//             Container(
//               // width: MediaQuery.of(context).size.width - 100,
//               child: IconButton(
//                   onPressed: () => _send_data(), icon: Icon(Icons.send)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _send_data() async {
//     String comment = commentscontroller.text;
//
//     if (comment.length == 0) {
//       SnackBar snackdemo = SnackBar(
//         content: Text('Missing comment'),
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
//       String pid = sh.getString('pid').toString();
//
//       final urls = Uri.parse('$url/user_addcomment/');
//       try {
//         final response = await http.post(urls, body: {
//           'lid': lid,
//           'postid': pid,
//           'comment': comment,
//         });
//         if (response.statusCode == 200) {
//           String status = jsonDecode(response.body)['status'];
//           if (status == 'ok') {
//             commentscontroller.text = '';
//             viewreply();
//           } else if (status == 'no') {
//             commentscontroller.text = '';
//             Fluttertoast.showToast(msg: 'Warning:You are account will be blocked');
//           } else if(status=='warning') {
//             Fluttertoast.showToast(msg: 'You Add Toxic Comments');
//           }
//           else if(status=='blocked'){
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       LoginNewFull(),
//                 ));
//
//           }
//         } else {
//           Fluttertoast.showToast(msg: 'Network Error');
//         }
//       } catch (e) {
//         Fluttertoast.showToast(msg: e.toString());
//       }
//     }
//   }
//
//   TextEditingController commentscontroller = TextEditingController();
// }


import 'package:cyber_bullying/Loginmain.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home.dart';

class MyViewCommetPage extends StatefulWidget {
  const MyViewCommetPage({super.key, required this.title});
  final String title;

  @override
  State<MyViewCommetPage> createState() => _MyViewCommetPageState();
}

class _MyViewCommetPageState extends State<MyViewCommetPage> {
  _MyViewCommetPageState() {
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> userid_ = <String>[];
  List<String> uploadpost_ = <String>[];
  List<String> comment_ = <String>[];
  List<String> date_ = <String>[];
  List<String> userphoto_ = <String>[];
  TextEditingController commentscontroller = TextEditingController();

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> userid = <String>[];
    List<String> uploadpost = <String>[];
    List<String> comment = <String>[];
    List<String> date = <String>[];
    List<String> userphoto = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('pid').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewcommentsandreply/';

      var data = await http.post(Uri.parse(url), body: {
        'pid': pid,
        'lid': lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        userid.add(arr[i]['userid']);
        uploadpost.add(arr[i]['uploadpost'].toString());
        comment.add(arr[i]['comment']);
        date.add(arr[i]['date']);
        userphoto.add(sh.getString('img_url').toString() + arr[i]['userphoto']);
      }

      setState(() {
        id_ = id;
        userid_ = userid;
        uploadpost_ = uploadpost;
        comment_ = comment;
        date_ = date;
        userphoto_ = userphoto;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

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
          'Comments',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Comments List
          Expanded(
            child: id_.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.comment, size: 80, color: Colors.grey[600]),
                  SizedBox(height: 16),
                  Text(
                    "No comments yet",
                    style: TextStyle(color: Colors.grey[400], fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Be the first to comment!",
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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User info and date
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(userphoto_[index]),
                                backgroundColor: Colors.grey[800],
                                onBackgroundImageError: (exception, stackTrace) {
                                  // Handle image error
                                },
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userid_[index],
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          // Comment text
                          Text(
                            comment_[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.4,
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

          // Comment Input Section
          Container(
            color: Colors.grey[900],
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Text Field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: commentscontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      maxLines: null,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Send Button
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _send_data,
                    icon: Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _send_data() async {
    String comment = commentscontroller.text.trim();

    if (comment.isEmpty) {
      _showSnackBar('Please write a comment');
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String pid = sh.getString('pid').toString();

    final urls = Uri.parse('$url/user_addcomment/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'postid': pid,
        'comment': comment,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          commentscontroller.text = '';
          viewreply();
          _showSuccessSnackBar('Comment added successfully');
        } else if (status == 'no') {
          commentscontroller.text = '';
          _showWarningSnackBar('Warning: Your account will be blocked');
        } else if (status == 'warning') {
          _showWarningSnackBar('You added toxic comments');
        } else if (status == 'blocked') {
          _showErrorSnackBar('Account blocked. Redirecting to login...');
          Future.delayed(Duration(milliseconds: 2000), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginNewFull()),
                  (route) => false,
            );
          });
        }
      } else {
        _showErrorSnackBar('Network error. Please try again.');
      }
    } catch (e) {
      _showErrorSnackBar('Error: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}