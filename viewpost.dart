// import 'package:clinicpharma/homenew.dart';
import 'package:cyber_bullying/addcomments.dart';
import 'package:cyber_bullying/viewcomment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
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
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const MyviewotherspostPage(title: 'View Reply'),
    );
  }
}

class MyviewotherspostPage extends StatefulWidget {
  const MyviewotherspostPage({super.key, required this.title});

  final String title;

  @override
  State<MyviewotherspostPage> createState() => MyViewfriendlistPage();
}

class MyViewfriendlistPage extends State<MyviewotherspostPage> {
  MyViewfriendlistPage() {
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
      String url = '$urls/user_viewotherspost/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        image.add(sh.getString('img_url').toString() + arr[i]['image']);
        post.add(sh.getString('img_url').toString() + arr[i]['post']);
        date.add(arr[i]['date']);
        liked.add(arr[i]['liked']);
        likes.add(arr[i]['likes']);
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

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home',)),
              );
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('otherPost'),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(0.7),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(image_[index]),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(name_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Text(date_[index]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Image.network(
                              post_[index],
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/post.jpg'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: liked_[index] == 'yes'
                                            ? Icon(
                                                Icons.thumb_up,
                                                color: Colors.blue,
                                              )
                                            : Icon(
                                                Icons.thumb_up_alt_outlined,
                                              ),
                                        onPressed: () async {
                                          SharedPreferences sh =
                                              await SharedPreferences
                                                  .getInstance();
                                          String url =
                                              sh.getString('url').toString();
                                          String lid =
                                              sh.getString('lid').toString();

                                          final urls = Uri.parse('$url/likes/');
                                          try {
                                            final response =
                                                await http.post(urls, body: {
                                              'lid': lid,
                                              'pid': id_[index],
                                            });
                                            if (response.statusCode == 200) {
                                              String status = jsonDecode(
                                                  response.body)['status'];
                                              if (status == 'ok') {
                                                viewreply();
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: 'Network Error');
                                              }
                                            }
                                          } catch (e) {
                                            Fluttertoast.showToast(
                                                msg: e.toString());
                                          }
                                        },
                                      ),
                                      Text(likes_[index]),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.comment,
                                  ),
                                  onPressed: () async {
                                    SharedPreferences sh =
                                        await SharedPreferences.getInstance();
                                    sh.setString("pid", id_[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MyViewCommetPage(
                                                  title: 'comments'),
                                        ));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  elevation: 8,
                  margin: EdgeInsets.all(10),
                ));
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
