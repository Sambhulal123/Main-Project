// import 'package:cyber_bullying/sendcomplaint.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
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
//       home: const view_complaint(title: 'View Reply'),
//     );
//   }
// }
//
// class view_complaint extends StatefulWidget {
//   const view_complaint({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<view_complaint> createState() => _view_complaintState();
// }
//
// class _view_complaintState extends State<view_complaint> {
//   _view_complaintState() {
//     view_complaints();
//   }
//
//   // List<int> id_=[];
//   // List<String> complaint_=[];
//   // List<String> date_=[];
//   // List<String> reply_=[];
//   // List<String> status_=[];
//
//   List<String> id_ = <String>[];
//   List<String> date_ = <String>[];
//
//   List<String> complaint_ = <String>[];
//   List<String> reply_ = <String>[];
//   List<String> status_ = <String>[];
//
//   Future<void> view_complaints() async {
//     List<String> id = <String>[];
//     List<String> date = <String>[];
//     List<String> complaint = <String>[];
//     List<String> reply = <String>[];
//     List<String> status = <String>[];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_viewreply/';
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
//         date.add(arr[i]['date']);
//         complaint.add(arr[i]['complaint']);
//         reply.add(arr[i]['reply']);
//         status.add(arr[i]['status']);
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         complaint_ = complaint;
//         reply_ = reply;
//         status_ = status;
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
//                 builder: (context) => HomeNewPage(
//                       title: '',
//                     )));
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//           leadingWidth: 0.0,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.grey.shade300,
//                 radius: 20.0,
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   splashRadius: 1.0,
//                   icon: Icon(
//                     Icons.arrow_back_ios_new,
//                     color: Colors.green,
//                     size: 24.0,
//                   ),
//                 ),
//               ),
//               Text(
//                 'Reply',
//                 style: GoogleFonts.poppins(
//                   color: Colors.green,
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 width: 40.0,
//                 child: IconButton(
//                   onPressed: () {},
//                   splashRadius: 1.0,
//                   icon: Icon(
//                     Icons.more_vert,
//                     color: Colors.white,
//                     size: 34.0,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: ListView.builder(
//           physics: BouncingScrollPhysics(),
//           // padding: EdgeInsets.all(5.0),
//           // shrinkWrap: true,
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("long press" + index.toString());
//               },
//               title: Padding(
//                   padding: const EdgeInsets.all(0),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 400,
//                         child: Card(
//                           elevation: 6,
//                           margin: EdgeInsets.all(10),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Container(
//                             // color: Colors.orangeAccent,
//                             padding: EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Date: " + date_[index],
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Complaint: ",
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                     Text(
//                                       '${complaint_[index]}',
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Reply         : ",
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                     Text(
//                                       '${reply_[index]}',
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "Status       : " + status_[index],
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: status_[index] == "Replied"
//                                         ? Colors.green
//                                         : Colors.red,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => UserSendComplaint(
//                           title: '',
//                         )));
//           },
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }


import 'package:cyber_bullying/sendcomplaint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class view_complaint extends StatefulWidget {
  const view_complaint({super.key, required this.title});
  final String title;

  @override
  State<view_complaint> createState() => _view_complaintState();
}

class _view_complaintState extends State<view_complaint> {
  _view_complaintState() {
    view_complaints();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> complaint_ = <String>[];
  List<String> reply_ = <String>[];
  List<String> status_ = <String>[];

  Future<void> view_complaints() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> complaint = <String>[];
    List<String> reply = <String>[];
    List<String> status = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewreply/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        complaint.add(arr[i]['complaint']);
        reply.add(arr[i]['reply']);
        status.add(arr[i]['status']);
      }

      setState(() {
        id_ = id;
        date_ = date;
        complaint_ = complaint;
        reply_ = reply;
        status_ = status;
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
              MaterialPageRoute(builder: (context) => HomeNewPage(title: '')),
            );
          },
        ),
        title: Text(
          'Complaints & Replies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: view_complaints,
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
              child: Icon(Icons.support_agent_rounded, color: Colors.white, size: 50),
            ),
            SizedBox(height: 24),
            Text(
              "No Complaints Yet",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your complaints and replies will appear here",
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
          bool isReplied = status_[index] == "replied";
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with Date and Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_rounded, color: Colors.grey[400], size: 14),
                              SizedBox(width: 6),
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
                            color: isReplied
                                ? Colors.green.withOpacity(0.2)
                                : Colors.orange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isReplied
                                  ? Colors.green.withOpacity(0.5)
                                  : Colors.orange.withOpacity(0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isReplied ? Icons.check_circle_rounded : Icons.pending_rounded,
                                color: isReplied ? Colors.green : Colors.orange,
                                size: 14,
                              ),
                              SizedBox(width: 6),
                              Text(
                                status_[index],
                                style: TextStyle(
                                  color: isReplied ? Colors.green : Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Complaint Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[800]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.report_problem_rounded, color: Colors.orange, size: 16),
                              SizedBox(width: 8),
                              Text(
                                'Your Complaint',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            complaint_[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12),

                    // Reply Section (only if replied)
                    if (isReplied)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.support_agent_rounded, color: Colors.green, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Admin Reply',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              reply_[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (!isReplied)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.schedule_rounded, color: Colors.orange, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'Waiting for admin response',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserSendComplaint(title: ''),
            ),
          );
        },
        backgroundColor: Color(0xFF6366F1),
        child: Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }
}