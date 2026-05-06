// import 'dart:convert';
// import 'package:cyber_bullying/addpost.dart';
// import 'package:cyber_bullying/home.dart';
// import 'package:cyber_bullying/viewcomment.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(const ViewOwnPost());
// }
//
// class ViewOwnPost extends StatelessWidget {
//   const ViewOwnPost({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: MaterialApp(
//         title: 'Flutter demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: const myviewOwnPostPage(),
//       ),
//     );
//   }
// }
//
// class myviewOwnPostPage extends StatefulWidget {
//   const myviewOwnPostPage({Key? key}) : super(key: key);
//
//   @override
//   State<myviewOwnPostPage> createState() => _myviewOwnPostPageState();
// }
//
// class _myviewOwnPostPageState extends State<myviewOwnPostPage> {
//   _myviewOwnPostPageState() {
//     ViewOwnPost();
//   }
//
//   List<String> id_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> photo_ = <String>[];
//   List<String> desc_ = <String>[];
//   List<String> loc_ = <String>[];
//   List<String> name_ = <String>[];
//   List<String> post_ = <String>[];
//   List<String> lk_ = <String>[];
//
//   Future<void> ViewOwnPost() async {
//     List<String> id = <String>[];
//     List<String> loc = <String>[];
//     List<String> date = <String>[];
//     List<String> photo = <String>[];
//     List<String> desc = <String>[];
//     List<String> post = <String>[];
//     List<String> name = <String>[];
//     List<String> lk = <String>[];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/user_viewownpost/';
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//       var arr = jsondata["data"];
//       print(arr.length);
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date']);
//         desc.add(arr[i]['caption']);
//         loc.add(arr[i]['loc']);
//         name.add(arr[i]['name']);
//         lk.add(arr[i]['likes'].toString());
//         post.add(sh.getString("img_url").toString() + arr[i]['post']);
//         photo.add(sh.getString("img_url").toString() + arr[i]['image']);
//       }
//       setState(() {
//         id_ = id;
//         date_ = date;
//         loc_ = loc;
//         desc_ = desc;
//         photo_ = photo;
//         post_ = post;
//         name_ = name;
//         lk_ = lk;
//       });
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
//                 MaterialPageRoute(
//                     builder: (context) => HomeNewPage(title: 'home')),
//               );
//             },
//           ),
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           title: Text("Post"),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/cbc.jpg'),
//               // Replace with your background image path
//               fit: BoxFit.cover,
//             ),
//           ),
//
//           child: ListView.builder(
//             physics: BouncingScrollPhysics(),
//             itemCount: id_.length,
//             itemBuilder: (BuildContext context, int index) {
//               return
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child:
//                   Card(
//                     elevation: 10,
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: Text(loc_[index]),
//                           subtitle: Text(desc_[index]),
//                           trailing: Text(date_[index]),
//                         ),
//                         Image.network(
//                           post_[index],
//                           height: MediaQuery.of(context).size.height * 0.4, // Adjust as needed
//                           width: double.infinity,
//                           fit: BoxFit.fill,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text("Likes: "+lk_[index]),
//                             IconButton(onPressed: () async {
//                               SharedPreferences sh =
//                                   await SharedPreferences.getInstance();
//                               sh.setString("pid", id_[index]);
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         MyViewCommetPage(title: 'comments'),
//                                   ));
//                             }, icon: Icon(Icons.comment)),
//                             IconButton(onPressed: () async {
//                               SharedPreferences sh =
//                               await SharedPreferences.getInstance();
//                               String url = sh.getString('url').toString();
//                               String lid = sh.getString('lid').toString();
//                               String pid = id_[index].toString();
//                               final urls = Uri.parse('$url/postremove/');
//                               try {
//                                 final response = await http.post(urls, body: {
//                                   'lid': lid,
//                                   'uid': pid,
//                                 });
//                                 if (response.statusCode == 200) {
//                                   String status =
//                                   jsonDecode(response.body)['status'];
//                                   if (status == 'ok') {
//                                     Fluttertoast.showToast(msg: 'Removed');
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             myviewOwnPostPage(),
//                                       ),
//                                     );
//                                   } else {
//                                     Fluttertoast.showToast(msg: 'Not Found');
//                                   }
//                                 } else {
//                                   Fluttertoast.showToast(
//                                       msg: 'Network Error');
//                                 }
//                               } catch (e) {
//                                 Fluttertoast.showToast(msg: e.toString());
//                               }
//                             }, icon: Icon(Icons.delete)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//
//               );
//             },
//           )
//
//           // ListView.builder(
//           //   physics: BouncingScrollPhysics(),
//           //   itemCount: id_.length,
//           //   itemBuilder: (BuildContext context, int index) {
//           //     return ListTile(
//           //       onLongPress: () {
//           //         print("long press" + index.toString());
//           //       },
//           //       title: Padding(
//           //         padding: const EdgeInsets.all(8.0),
//           //         child: SizedBox(
//           //           width: double.infinity,
//           //           child: Card(
//           //             elevation: 8,
//           //             margin: EdgeInsets.all(10),
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(
//           //                   40), // Set the desired corner radius for the Card
//           //             ),
//           //             child: InkWell(
//           //               onTap: () {
//           //                 showDialog(
//           //                   context: context,
//           //                   builder: (context) => Image.network(post_[index]),
//           //                 );
//           //               },
//           //               child: Column(
//           //                 children: [
//           //                   SizedBox(
//           //                     height: 20,
//           //                   ),
//           //                   Container(
//           //                     height: 250, // Set the desired image height
//           //                     width: 250, // Set the desired image width
//           //                     child: ClipRRect(
//           //                       borderRadius: BorderRadius.circular(10),
//           //                       // Apply rounded corners to the image
//           //                       child: Image(
//           //                         image: NetworkImage(post_[index], scale: 2),
//           //                         fit:
//           //                             BoxFit.cover, // Adjust how the image fits
//           //                       ),
//           //                     ),
//           //                   ),
//           //                   Padding(
//           //                     padding: EdgeInsets.all(5),
//           //                     child: Text(date_[index]),
//           //                   ),
//           //                   Padding(
//           //                     padding: EdgeInsets.all(5),
//           //                     child: Text(desc_[index]),
//           //                   ),
//           //                   ElevatedButton(
//           //                     onPressed: () async {
//           //                       SharedPreferences sh =
//           //                           await SharedPreferences.getInstance();
//           //                       sh.setString("pid", id_[index]);
//           //                       Navigator.push(
//           //                           context,
//           //                           MaterialPageRoute(
//           //                             builder: (context) =>
//           //                                 MyViewCommetPage(title: 'comments'),
//           //                           ));
//           //                     },
//           //                     child: Text('comments'),
//           //                   ),
//           //                   ElevatedButton(
//           //                     onPressed: () async {
//           //                       SharedPreferences sh =
//           //                           await SharedPreferences.getInstance();
//           //                       String url = sh.getString('url').toString();
//           //                       String lid = sh.getString('lid').toString();
//           //                       String pid = id_[index].toString();
//           //                       final urls = Uri.parse('$url/postremove/');
//           //                       try {
//           //                         final response = await http.post(urls, body: {
//           //                           'lid': lid,
//           //                           'uid': pid,
//           //                         });
//           //                         if (response.statusCode == 200) {
//           //                           String status =
//           //                               jsonDecode(response.body)['status'];
//           //                           if (status == 'ok') {
//           //                             Fluttertoast.showToast(msg: 'Removed');
//           //                             Navigator.push(
//           //                               context,
//           //                               MaterialPageRoute(
//           //                                 builder: (context) =>
//           //                                     myviewOwnPostPage(),
//           //                               ),
//           //                             );
//           //                           } else {
//           //                             Fluttertoast.showToast(msg: 'Not Found');
//           //                           }
//           //                         } else {
//           //                           Fluttertoast.showToast(
//           //                               msg: 'Network Error');
//           //                         }
//           //                       } catch (e) {
//           //                         Fluttertoast.showToast(msg: e.toString());
//           //                       }
//           //                     },
//           //                     child: Text("Removed"),
//           //                   ),
//           //                 ],
//           //               ),
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //     );
//           //   },
//           // ),
//
//           // child: ListView.builder(
//           //    physics: BouncingScrollPhysics(),
//           //    // padding: EdgeInsets.all(5.0),
//           //    // shrinkWrap: true,
//           //    itemCount: id_.length,
//           //    itemBuilder: (BuildContext context, int index) {
//           //      return ListTile(
//           //        onLongPress: () {
//           //          print("long press" + index.toString());
//           //        },
//           //        title: Padding(
//           //            padding: const EdgeInsets.all(8.0),
//           //            child: Column(
//           //              children: [
//           //                Card(
//           //                  child:
//           //                  Row(
//           //                      children: [
//           //                        Column(
//           //                          children: [
//           //                            Image(
//           //
//           //                              image: NetworkImage(photo_[index]),
//           //                              height: 300,
//           //                              width: 280,
//           //
//           //                            ),
//           //
//           //                            Padding(
//           //                              padding: EdgeInsets.all(5),
//           //                              child: Text(date_[index]),
//           //                            ),
//           //
//           //
//           //                            Padding(
//           //                              padding: EdgeInsets.all(5),
//           //                              child: Text(desc_[index]),
//           //                            ),
//           //
//           //
//           //
//           //
//           //
//           //                            ElevatedButton(onPressed: () async{
//           //                              SharedPreferences sh=await SharedPreferences.getInstance();
//           //                              sh.setString("postid",id_[index] );
//           //                              Navigator.push(context, MaterialPageRoute(
//           //                                builder: (context) => MyOwnViewCommentsPage(title: "",),
//           //                              )
//           //                              );
//           //                              },
//           //
//           //
//           //
//           //                                child:
//           //                                Text('comments')
//           //                            ),
//           //
//           //
//           //                            ElevatedButton(
//           //                              onPressed: () async {
//           //
//           //                                SharedPreferences sh = await SharedPreferences.getInstance();
//           //                                String url = sh.getString('url').toString();
//           //                                String lid = sh.getString('lid').toString();
//           //                                // String sid = sh.getString('rid').toString();
//           //                                String pid = id_[index].toString();
//           //
//           //                                final urls = Uri.parse('$url/delete_post/');
//           //                                try {
//           //                                  final response = await http.post(urls, body: {
//           //                                    'lid':lid,
//           //                                    'pid':pid,
//           //
//           //
//           //                                  });
//           //                                  if (response.statusCode == 200) {
//           //                                    String status = jsonDecode(response.body)['status'];
//           //                                    if (status=='ok') {
//           //                                      Fluttertoast.showToast(msg: 'Removed');
//           //
//           //                                      Navigator.push(context, MaterialPageRoute(
//           //
//           //                                        builder: (context) => MyHomePage(title: "home",),));
//           //                                    }else {
//           //                                      Fluttertoast.showToast(msg: 'Not Found');
//           //                                    }
//           //                                  }
//           //                                  else {
//           //                                    Fluttertoast.showToast(msg: 'Network Error');
//           //                                  }
//           //                                }
//           //                                catch (e){
//           //                                  Fluttertoast.showToast(msg: e.toString());
//           //                                }
//           //                              },
//           //                              child: Text("Removed"),
//           //                            ),
//           //
//           //
//           //                          ],
//           //                        ),
//           //
//           //                      ]
//           //                  ),
//           //
//           //                  elevation: 8,
//           //                  margin: EdgeInsets.all(10),
//           //                ),
//           //              ],
//           //            )),
//           //      );
//           //    },
//           //  ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => MyAddpostPage(title: 'home')));
//           },
//           child: Icon(Icons.plus_one),
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:cyber_bullying/addpost.dart';
import 'package:cyber_bullying/home.dart';
import 'package:cyber_bullying/viewcomment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class myviewOwnPostPage extends StatefulWidget {
  const myviewOwnPostPage({Key? key}) : super(key: key);

  @override
  State<myviewOwnPostPage> createState() => _myviewOwnPostPageState();
}

class _myviewOwnPostPageState extends State<myviewOwnPostPage> {
  _myviewOwnPostPageState() {
    ViewOwnPost();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> desc_ = <String>[];
  List<String> loc_ = <String>[];
  List<String> name_ = <String>[];
  List<String> post_ = <String>[];
  List<String> lk_ = <String>[];

  Future<void> ViewOwnPost() async {
    List<String> id = <String>[];
    List<String> loc = <String>[];
    List<String> date = <String>[];
    List<String> photo = <String>[];
    List<String> desc = <String>[];
    List<String> post = <String>[];
    List<String> name = <String>[];
    List<String> lk = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/user_viewownpost/';
      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];
      var arr = jsondata["data"];
      print(arr.length);
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        desc.add(arr[i]['caption']);
        loc.add(arr[i]['loc']);
        name.add(arr[i]['name']);
        lk.add(arr[i]['likes'].toString());
        post.add(sh.getString("img_url").toString() + arr[i]['post']);
        photo.add(sh.getString("img_url").toString() + arr[i]['image']);
      }
      setState(() {
        id_ = id;
        date_ = date;
        loc_ = loc;
        desc_ = desc;
        photo_ = photo;
        post_ = post;
        name_ = name;
        lk_ = lk;
      });
      print(statuss);
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
          "My Posts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: id_.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library, size: 80, color: Colors.grey[600]),
            SizedBox(height: 16),
            Text(
              "No posts yet",
              style: TextStyle(color: Colors.grey[400], fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              "Create your first post!",
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
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with location and date
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[800],
                          child: Icon(Icons.person, color: Colors.grey[400]),
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
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                loc_[index],
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          date_[index],
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Caption
                  if (desc_[index].isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        desc_[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  SizedBox(height: 12),

                  // Post Image
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ClipRRect(
                      child: Image.network(
                        post_[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error, color: Colors.grey[600], size: 40),
                                SizedBox(height: 8),
                                Text(
                                  'Failed to load image',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[800],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Colors.blue,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Actions
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Likes
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.favorite, color: Colors.red, size: 16),
                              SizedBox(width: 6),
                              Text(
                                lk_[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Spacer(),

                        // Comment Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
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
                            icon: Icon(Icons.comment, color: Colors.blue, size: 20),
                          ),
                        ),

                        SizedBox(width: 8),

                        // Delete Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () => _showDeleteDialog(id_[index]),
                            icon: Icon(Icons.delete, color: Colors.red, size: 20),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyAddpostPage(title: 'Create Post')),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showDeleteDialog(String postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete, color: Colors.red, size: 40),
              SizedBox(height: 16),
              Text(
                'Delete Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Are you sure you want to delete this post?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400]),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Cancel', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _deletePost(postId);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Delete', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deletePost(String postId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/postremove/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'uid': postId,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(
            msg: 'Post deleted successfully',
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          ViewOwnPost(); // Refresh the list
        } else {
          Fluttertoast.showToast(
            msg: 'Failed to delete post',
            backgroundColor: Colors.red,
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