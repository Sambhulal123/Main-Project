// import 'package:clinicpharma/homenew.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

import 'sendcomplaint.dart';
void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const Myrejectedrequestpage(title: 'View Reply'),
    );
  }
}

class Myrejectedrequestpage extends StatefulWidget {
  const Myrejectedrequestpage({super.key, required this.title});

  final String title;

  @override
  State<Myrejectedrequestpage> createState() => _MyrejectedrequestpageState();
}

class _MyrejectedrequestpageState extends State<Myrejectedrequestpage> {

  _MyrejectedrequestpageState(){
    // viewreply();
  }


  List<String> from_ = <String>[];
  List<String> date_ = <String>[];
  List<String> to_ = <String>[];


  List<String> status_ = <String>[];



  Future<void> viewreply() async {

    List<String> date = <String>[];
    List<String> from = <String>[];
    List<String> to = <String>[];
    List<String> status = <String>[];





    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/user_viewreject/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {

        date.add(arr[i]['date']);
        from.add(arr[i]['from']);
        to.add(arr[i]['to']);
        status.add(arr[i]['status']);
      }

      setState(() {

        date_ = date;
        from_ = from;
        to_ = to;
        status_ = status;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        // appBar: AppBar(
        //   leading: BackButton( onPressed:() {
        //
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => HomeNew()),);
        //
        //   },),
        //   backgroundColor: Theme.of(context).colorScheme.primary,
        //   title: Text(widget.title),
        // ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: status_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child:
                        Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(from_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(to_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(status_[index]),

                                  ), Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(date_[index]),
                                  ),





                                ],
                              ),

                            ]
                        ),

                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  )),
            );
          },
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => MySendComplaint()));
        //
        // },
        //   child: Icon(Icons.plus_one),
        // ),


      ),
    );
  }
}
