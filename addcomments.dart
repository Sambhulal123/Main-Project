//
// import 'dart:convert';
// import 'package:cyber_bullying/Loginmain.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
//       home: const MyCommentPage(title: 'Flutter Comment Page'),
//     );
//   }
// }
//
// class MyCommentPage extends StatefulWidget {
//   const MyCommentPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyCommentPage> createState() => _MyCommentPageState();
// }
//
// class _MyCommentPageState extends State<MyCommentPage> {
//   TextEditingController commentsController = TextEditingController();
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context);
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: Text(widget.title),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextField(
//                 controller: commentsController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter your comment',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               isLoading
//                   ? const CircularProgressIndicator()
//                   : ElevatedButton(
//                 onPressed: _sendData,
//                 child: const Text('Send'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _sendData() async {
//     String comment = commentsController.text.trim();
//     if (comment.isEmpty) {
//       _showSnackBar('Comment cannot be empty');
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     String? lid = sh.getString('lid');
//     String? pid = sh.getString('pid');
//
//     if (url == null || lid == null || pid == null) {
//       _showSnackBar('Invalid user session. Please log in again.');
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     final uri = Uri.parse('$url/add_comment/');
//     try {
//       final response = await http.post(uri, body: {
//         'comment': comment,
//         'postid': pid,
//         'lid': lid,
//       });
//
//       setState(() {
//         isLoading = false;
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == 'ok') {
//           _showSnackBar('Comment submitted successfully!');
//           commentsController.clear(); // Clear the text field
//         } else if (status == 'warning') {
//           _showSnackBar("wa");
//         } else if (status == 'blocked') {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     LoginNewFull(),
//               ));
//
//           // Optional: Navigate the user to a "blocked" screen or logout
//         } else {
//           _showSnackBar('Failed to submit comment.');
//         }
//       } else {
//         _showSnackBar('Network error. Please try again later.');
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       _showSnackBar('Error: ${e.toString()}');
//     }
//   }
//
//   void _showSnackBar(String message) {
//     SnackBar snackBar = SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.redAccent,
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.all(10),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }


import 'dart:convert';
import 'package:cyber_bullying/Loginmain.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCommentPage extends StatefulWidget {
  const MyCommentPage({super.key, required this.title});
  final String title;

  @override
  State<MyCommentPage> createState() => _MyCommentPageState();
}

class _MyCommentPageState extends State<MyCommentPage> {
  TextEditingController commentsController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Add Comment',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Comment Input
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: commentsController,
                  style: TextStyle(color: Colors.white),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Write your comment...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Character Count
              Container(
                width: double.infinity,
                child: Text(
                  '${commentsController.text.length} characters',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ),

              Spacer(),

              // Send Button
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _sendData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.blue.withOpacity(0.5),
                  ),
                  child: isLoading
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                      : Text(
                    'POST COMMENT',
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
      ),
    );
  }

  void _sendData() async {
    String comment = commentsController.text.trim();
    if (comment.isEmpty) {
      _showSnackBar('Please write a comment');
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String? lid = sh.getString('lid');
    String? pid = sh.getString('pid');

    if (url == null || lid == null || pid == null) {
      _showSnackBar('Session expired. Please login again.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final uri = Uri.parse('$url/add_comment/');
    try {
      final response = await http.post(uri, body: {
        'comment': comment,
        'postid': pid,
        'lid': lid,
      });

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          _showSuccessSnackBar('Comment posted successfully!');
          commentsController.clear();
          Future.delayed(Duration(milliseconds: 1500), () {
            Navigator.pop(context);
          });
        } else if (status == 'warning') {
          _showSnackBar('Warning: Please check your comment');
        } else if (status == 'blocked') {
          _showSnackBar('Account blocked. Redirecting to login...');
          Future.delayed(Duration(milliseconds: 2000), () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginNewFull()),
                  (route) => false,
            );
          });
        } else {
          _showSnackBar('Failed to post comment');
        }
      } else {
        _showSnackBar('Network error. Please try again.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnackBar('Error: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
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
}