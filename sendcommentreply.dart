import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart ' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MysendcommentandreplyPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MysendcommentandreplyPage extends StatefulWidget {
  const MysendcommentandreplyPage({super.key, required this.title});

  final String title;

  @override
  State<MysendcommentandreplyPage> createState() =>
      _MysendcommentandreplyPageState();
}

TextEditingController replycontroller = TextEditingController();

class _MysendcommentandreplyPageState extends State<MysendcommentandreplyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: replycontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'reply'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _send_data();
                },
                child: Text('send'))
          ],
        ),
      ),
    );
  }

  void _send_data() async {
    String reply = replycontroller.text;

    if (reply.length == 0) {
      SnackBar snackdemo = SnackBar(
        content: Text('Missing content'),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    } else {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();

      final urls = Uri.parse('$url/user_viewcommentsandreply/');
      try {
        final response = await http.post(urls, body: {
          'reply': reply,
        });
        if (response.statusCode == 200) {
          String status = jsonDecode(response.body)['status'];
          if (status == 'ok') {
            String lid = jsonDecode(response.body)['lid'];
            sh.setString("lid", lid);

            // Navigator.push(context, MaterialPageRoute(
            //   builder: (context) => MysendcommentandreplyPage(title: "Home"),));
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
}
