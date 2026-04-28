// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyChatApp());
// }
//
// class MyChatApp extends StatelessWidget {
//   const MyChatApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyChatPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyChatPage extends StatefulWidget {
//   const MyChatPage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyChatPage> createState() => _MyChatPageState();
// }
//
// class ChatMessage {
//   String messageContent;
//   String messageType;
//
//   ChatMessage({required this.messageContent, required this.messageType});
// }
//
// class _MyChatPageState extends State<MyChatPage> {
//   int _counter = 0;
//   String name = "";
//
//   _MyChatPageState() {
//     Timer.periodic(Duration(seconds: 2), (_) {
//       view_message();
//
//       // setState(() {
//       //
//       //   List<ChatMessage> messages1= messages;
//       //   messages1.add(ChatMessage(messageContent: "Hello, Will", messageType: "sender"));
//       //   setState(() {
//       //     messages=messages1;
//       //   });
//       // });
//       //
//       // print("Hiii");
//       // // Runs after every 1000ms
//     });
//   }
//
//   List<ChatMessage> messages = [];
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   TextEditingController te_message = TextEditingController();
//
//   List<String> from_id_ = <String>[];
//   List<String> to_id_ = <String>[];
//   List<String> message_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> time_ = <String>[];
//
//   Future<void> view_message() async {
//     final pref = await SharedPreferences.getInstance();
//     name = "Hello" ;pref.getString("name").toString();
//
//     // setState(() {
//     //   name = name;
//     // });
//
//     List<String> from_id = <String>[];
//     List<String> to_id = <String>[];
//     List<String> message = <String>[];
//     List<String> date = <String>[];
//     List<String> time = <String>[];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String urls = pref.getString('url').toString();
//       String url = '$urls/chat_view/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'from_id': pref.getString("lid").toString(),
//         'to_id': pref.getString("did").toString()
//         // 'lastmsgid': pref.getString("lastmsgid").toString()
//       });
//       var jsondata = json.decode(data.body);
//       String status = jsondata['status'];
//       print(status);
//
//       var arr = jsondata["data"];
//       print(arr);
//
//
//       messages.clear();
//
//
//       for (int i = 0; i < arr.length; i++) {
//         from_id.add(arr[i]['fid'].toString());
//         to_id.add(arr[i]['toid'].toString());
//         message.add(arr[i]['msg']);
//         date.add(arr[i]['date'].toString());
//         time.add(arr[i]['date'].toString());
//
//         if (pref.getString("lid").toString() == arr[i]['from'].toString()) {
//           messages.add(ChatMessage(
//               messageContent: arr[i]['msg'], messageType: "sender"));
//         } else {
//           messages.add(ChatMessage(
//               messageContent: arr[i]['msg'], messageType: "receiver"));
//         }
//       }
//
//       // messages.add(ChatMessage(messageContent: "....", messageType: "sender"));
//
//       setState(() {
//         from_id_ = from_id;
//         to_id_ = to_id;
//         message_ = message;
//         date_ = date;
//         time_ = time;
//
//         messages = messages;
//       });
//
//       print(status);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//           title: new Text(
//             name,
//             style: new TextStyle(color: Colors.white),
//           ),
//           leading: new IconButton(
//             icon: new Icon(Icons.arrow_back),
//             onPressed: () {
//               // Navigator.pushNamed(context, '/viewdoctors');
//               Navigator.pop(context);
//               // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyViewDoctorsPage(title: '',)),);
//               print("Hello");
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => ThirdScreen()),
//               // );
//             },
//           )),
//       body: Stack(
//         children: <Widget>[
//           ListView.builder(
//             itemCount: messages.length,
//             shrinkWrap: true,
//             padding: EdgeInsets.only(top: 10, bottom: 50),
//             physics: ScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Container(
//                 padding:
//                 EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
//                 child: Align(
//                   alignment: (messages[index].messageType == "receiver"
//                       ? Alignment.topLeft
//                       : Alignment.topRight),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: (messages[index].messageType == "receiver"
//                           ? Colors.grey.shade200
//                           : Colors.blue[200]),
//                     ),
//                     padding: EdgeInsets.all(16),
//                     child: Text(
//                       messages[index].messageContent,
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
//               height: 60,
//               width: double.infinity,
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.cyan,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: te_message,
//                       decoration: InputDecoration(
//                           hintText: "Write message...",
//                           hintStyle: TextStyle(color: Colors.black54),
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () async {
//                       String fid = "";
//                       String toid = "";
//                       String message = te_message.text.toString();
//
//                       /////
//                       try {
//                         final pref = await SharedPreferences.getInstance();
//                         String ip = pref.getString("url").toString();
//
//                         String url = ip + "/chat_send/";
//
//                         var data = await http.post(Uri.parse(url), body: {
//                           'message': message,
//                           'from_id': pref.getString("lid").toString(),
//                           'to_id': pref.getString("did").toString()
//                           // 'lastmsgid': pref.getString("lastmsgid").toString()
//                         });
//                         var jsondata = json.decode(data.body);
//                         String status = jsondata['status'];
//
//                         te_message.text = "";
//
//                         var arr = jsondata["data"];
//
//                         setState(() {});
//
//                         print("");
//                       } catch (e) {
//                         print("Error ------------------- " + e.toString());
//                         //there is error during converting file image to base64 encoding.
//                       }
//                       ////
//
//                       // print("Hiiiiii");
//                       //
//                       // setState(() {
//                       //
//                       //   List<ChatMessage> messages1= messages;
//                       //   messages1.add(ChatMessage(messageContent: "Hello, Fadhil", messageType: "receiver"));
//                       //   setState(() {
//                       //
//                       //     messages=messages1;
//                       //   });
//                       //
//                       // });
//                     },
//                     child: Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     backgroundColor: Colors.cyan,
//                     elevation: 0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyChatPage extends StatefulWidget {
  const MyChatPage({super.key, required this.title});
  final String title;

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class _MyChatPageState extends State<MyChatPage> {
  String name = "";
  List<ChatMessage> messages = [];
  TextEditingController te_message = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<String> from_id_ = <String>[];
  List<String> to_id_ = <String>[];
  List<String> message_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];

  _MyChatPageState() {
    Timer.periodic(Duration(seconds: 2), (_) {
      view_message();
    });
  }

  Future<void> view_message() async {
    final pref = await SharedPreferences.getInstance();
    name = pref.getString("name").toString() ?? "User";

    List<String> from_id = <String>[];
    List<String> to_id = <String>[];
    List<String> message = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String urls = pref.getString('url').toString();
      String url = '$urls/chat_view/';

      var data = await http.post(Uri.parse(url), body: {
        'from_id': pref.getString("lid").toString(),
        'to_id': pref.getString("did").toString()
      });
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      var arr = jsondata["data"];
      messages.clear();

      for (int i = 0; i < arr.length; i++) {
        from_id.add(arr[i]['fid'].toString());
        to_id.add(arr[i]['toid'].toString());
        message.add(arr[i]['msg']);
        date.add(arr[i]['date'].toString());
        time.add(arr[i]['date'].toString());

        if (pref.getString("lid").toString() == arr[i]['from'].toString()) {
          messages.add(ChatMessage(
              messageContent: arr[i]['msg'], messageType: "sender"));
        } else {
          messages.add(ChatMessage(
              messageContent: arr[i]['msg'], messageType: "receiver"));
        }
      }

      setState(() {
        from_id_ = from_id;
        to_id_ = to_id;
        message_ = message;
        date_ = date;
        time_ = time;
        messages = messages;
      });

      // Auto scroll to bottom
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  void _sendMessage() async {
    String message = te_message.text.toString().trim();
    if (message.isEmpty) return;

    try {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("url").toString();
      String url = ip + "/chat_send/";

      var data = await http.post(Uri.parse(url), body: {
        'message': message,
        'from_id': pref.getString("lid").toString(),
        'to_id': pref.getString("did").toString()
      });
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];

      te_message.clear();
      view_message(); // Refresh messages

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
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.person_rounded, color: Colors.white, size: 20),
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam_rounded, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call_rounded, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
                ),
              ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(16),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  bool isSender = messages[index].messageType == "sender";
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Align(
                      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSender
                              ? LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                              : LinearGradient(
                            colors: [Color(0xFF2A2A2A), Color(0xFF3A3A3A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: isSender ? Radius.circular(20) : Radius.circular(4),
                            bottomRight: isSender ? Radius.circular(4) : Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              border: Border(
                top: BorderSide(color: Colors.grey[800]!, width: 1),
              ),
            ),
            child: Row(
              children: [
                // Attachment Button
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file_rounded, color: Colors.grey[400], size: 20),
                  ),
                ),
                SizedBox(width: 12),

                // Message Input Field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: te_message,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Send Button
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6366F1).withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}