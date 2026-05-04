import 'package:cyber_bullying/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Loginmain.dart';

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
      home: const MyIpPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyIpPage extends StatefulWidget {
  const MyIpPage({super.key, required this.title});

  final String title;

  @override
  State<MyIpPage> createState() => _MyIpPageState();
}

class _MyIpPageState extends State<MyIpPage> {
  TextEditingController ipcontroller = TextEditingController();

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
              controller: ipcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'ip Address'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _send_data();
                },
                child: Text('submit'))
          ],
        ),
      ),
    );
  }

  void _send_data() async {
    String ip = ipcontroller.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    sh.setString("url", "http://" + ip + ":8000/myapp");
    sh.setString("img_url", "http://" + ip + ":8000");

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginNewFull(),
        ));
  }
}
